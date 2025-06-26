# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the Flutter mobile application frontend for a bilingual English vocabulary learning system. It works with the FastAPI backend (`zenn-hack-backend/`) to provide:
- User authentication and management
- Flashcard-based vocabulary learning
- AI-generated media (images) for vocabulary words
- Translation and explanation features

## Common Development Commands

### Flutter Frontend
```bash
# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run

# Run with specific environment
flutter run --target lib/main_development.dart    # Development mode (local data)
flutter run --target lib/main_staging.dart        # Staging mode (remote server)

# Code generation (required after model changes)
flutter packages pub run build_runner build       # One-time generation
flutter packages pub run build_runner watch       # Watch mode

# Run tests
flutter test
flutter test integration_test/                    # Integration tests
flutter test test/specific_test_file.dart         # Specific test file

# Analyze code for issues
flutter analyze

# Format code
flutter format .

# Build for production
flutter build apk    # Android
flutter build ios    # iOS

# Clean build artifacts
flutter clean

# Upgrade dependencies
flutter pub upgrade
```

### Flutter Version Management
The project uses FVM (Flutter Version Management) with Flutter 3.29.3:
```bash
# Install correct Flutter version
fvm install 3.29.3
fvm use 3.29.3

# Run commands with FVM
fvm flutter run
```

## Architecture

### Clean Architecture (厳守)

このFlutterアプリは**Clean Architecture**に従い、厳密な関心の分離を実現します：

#### レイヤー構造
- **Domain** (`lib/domain/`): ビジネスエンティティ（Freezedモデル）とユースケース
- **Data** (`lib/data/`): リポジトリ実装（local/remote）とAPIサービス
- **UI** (`lib/ui/`): MVVMパターンで機能別に整理されたViewModelとWidget

#### 主要パターン
- **Repository Pattern**: 各エンティティに抽象リポジトリとlocal/remote実装を用意
- **MVVM**: StateNotifierがビジネスロジックを担当、Widgetはプレゼンテーションのみ
- **Riverpod**: 依存性注入と状態管理
- **環境設定**: Development（ローカルデータ）vs Staging（リモートデータ）

### ディレクトリ構造とファイル命名規則

#### ディレクトリ構成
```
lib/
├── domain/models/[entity]/           # ビジネスエンティティ
│   ├── [entity].dart                 # メインモデル (Freezed)
│   ├── [entity].freezed.dart         # 生成ファイル
│   ├── [entity].g.dart              # JSONシリアライゼーション
│   └── [entity]_summary.dart        # サマリーモデル
├── data/repositories/[entity]/       # データアクセス層
│   ├── [entity]_repository.dart      # 抽象インターフェース
│   ├── [entity]_repository_local.dart    # ローカル実装
│   └── [entity]_repository_remote.dart   # リモート実装
└── ui/[feature]/                     # 機能ベースのUI構成
    ├── notifiers/
    │   └── [feature]_notifier.dart   # StateNotifier/AsyncNotifier
    └── widgets/
        ├── [feature]_screen.dart     # メイン画面
        └── [feature]_*.dart          # コンポーネント
```

#### ファイル命名規則（snake_case厳守）
- **StateNotifiers**: `*_notifier.dart` (例: `home_notifier.dart`)
- **Repositories**: `*_repository.dart` (インターフェース), `*_repository_local.dart`, `*_repository_remote.dart`
- **APIモデル**: `*_api_model.dart` (例: `user_api_model.dart`)
- **画面**: `*_screen.dart` (例: `home_screen.dart`)
- **ユースケース**: `*_use_case.dart` (例: `booking_create_use_case.dart`)

### Frontend Structure
- **lib/main.dart**: App entry point and root widget
- **android/**: Android-specific configuration (package: `com.example.gen_flash_english_study`)
- **ios/**: iOS-specific configuration
- **pubspec.yaml**: Project dependencies and metadata

### Key Features to Implement
1. **Authentication**: Connect to backend auth endpoints
2. **Flashcard Management**: CRUD operations for vocabulary cards
3. **Media Display**: Show AI-generated images from backend
4. **Learning Interface**: Implement spaced repetition and study modes
5. **User Progress**: Track and display learning statistics

### Backend Integration
- Base URL: Configure for local development (`http://localhost:8000`) and production
- API Endpoints:
  - `/user/*`: User management
  - `/flashcard/*`: Flashcard CRUD operations
  - `/media/*`: Media generation and retrieval
  - `/compare/*`: Media comparison features
  - `/translate/*`: Translation services

### Development Configuration
- Strict linting enabled via `analysis_options.yaml`
- Material 3 design system
- Follows Flutter best practices for state management and UI structure

## Development Principles (厳守)

**以下の原則を必ず守ること:**

- **KISS (Keep It Simple, Stupid)**: 
  - 常にシンプルで読みやすい解決策を最優先する
  - 複雑な実装より簡潔な実装を選ぶ
  - 過度な抽象化を避ける

- **DRY (Don't Repeat Yourself)**: 
  - コードの重複を徹底的に排除する
  - 共通のウィジェットやユーティリティは必ず抽出する
  - 同じロジックを2箇所以上に書かない

- **YAGNI (You Aren't Gonna Need It)**: 
  - 実際に必要になるまで機能を実装しない
  - 将来の拡張性のための過度な設計を避ける
  - 現在の要件に集中する

## コーディング規約

### Import順序（厳守）
以下の順序でimportを整理すること：
1. Dart coreライブラリ (`dart:async`, `dart:convert`)
2. Flutter SDK (`package:flutter/material.dart`)
3. 外部パッケージ (アルファベット順)
4. 相対インポート (プロジェクトファイル)
5. Part宣言 (コード生成)

**プロジェクトファイルは必ず相対インポートを使用**：
```dart
// ✅ 正しい
import '../../../data/repositories/booking/booking_repository.dart';

// ❌ 間違い
import 'package:gen_flash_english_study/data/repositories/booking/booking_repository.dart';
```

### エラーハンドリング規約
- **Result<T>**パターンを使用（`Ok<T>`と`Error<T>`型）
- Result処理には必ず`switch`式を使用
- エラーログにはコンテキスト情報を含める
- クリーンアップには`finally`ブロックを使用

### Freezedモデル規約
```dart
@freezed
class ModelName with _$ModelName {
  const factory ModelName({
    /// 各フィールドには必ずドキュメントコメントを記載
    int? id,
    
    /// 必須フィールドの説明
    required String name,
    
    /// リストフィールドは具体的な型を指定
    required List<Activity> activities,
  }) = _ModelName;

  factory ModelName.fromJson(Map<String, Object?> json) => _$ModelNameFromJson(json);
}
```

### UI構築規約

**Widgetの選択基準（厳守）**：

- **StatelessWidget**: 状態を持たない部分に使用
  - 再利用性とテスト容易性を最大化
  - 純粋な表示コンポーネントに最適

- **HookWidget**: ephemeral state（一時的な状態）を持つ部分に使用
  - TextEditingController、AnimationControllerなどの管理
  - UIローカルな状態管理に最適

- **ConsumerWidget**: app state（アプリケーション状態）を持つ部分に使用
  - Riverpodプロバイダーの状態を参照
  - グローバルな状態管理に最適

- **ConsumerHookWidget**: 必要に応じて両方の機能を組み合わせて使用
  - app stateとephemeral stateの両方が必要な場合

**コンポーネント設計原則**：
- コンポーネント化と再利用可能性を常に意識する
- 単一責任の原則に従い、各Widgetは一つの役割に集中
- 共通UIパーツは別ファイルに切り出して再利用

## ⚠️ Code Quality Assurance (実装後必須・厳守) ⚠️

**🚨 重要: 以下の手順を実装後に必ず実行すること。これをスキップしてはいけません 🚨**

### 🚫 厳格禁止事項
- **analysis_options.yamlの変更は絶対に禁止** - 既存のlint設定を変更してはいけない
- lint警告やエラーを隠すためにanalysis_options.yamlを編集することは厳禁
- 代わりにコード自体を修正してlint規則に準拠すること

### 必須チェックリスト

- [ ] **1. 静的解析の実行**
   ```bash
   dart analyze
   ```

- [ ] **2. 問題が検出された場合の自動修正**
   ```bash
   # 自動修正とフォーマットを実行
   dart fix --apply && dart format .
   ```

- [ ] **3. 残った問題の手動修正**
   - 自動修正で解決しなかった問題を一つずつ手動で修正
   - 全ての問題が解消されるまで繰り返す

- [ ] **4. 最終確認**
   ```bash
   # 全ての問題が解消されていることを確認
   dart analyze
   # "No issues found!" が表示されることを確認
   ```

**❌ 絶対にやってはいけないこと:**
- `dart analyze`を実行せずにタスクを完了する
- 警告やエラーが残った状態で次のタスクに進む
- 「後で修正する」と先延ばしにする

**✅ 成功の基準:**
- `dart analyze` の実行結果が "No issues found!" であること

## テスト戦略

### テスト構成
- **Unit Tests**: `test/`内でリポジトリとユースケースのロジックをテスト
- **Widget Tests**: `test/ui/`内でモック依存関係を使用した画面コンポーネントテスト
- **Integration Tests**: `integration_test/`内でエンドツーエンドフローをテスト

### テストツール
- **Mocktail**を使用して外部依存関係をモック
- `testing/fakes/`のフェイクリポジトリで一貫したテストデータを提供
- `testing/app.dart`でテストアプリ設定を利用

### テスト規約
- テストファイル名: `*_test.dart`
- `group()`で関連テストを整理
- テスト名: `'should [action/behavior]'`形式
- 簡単なモックには**Fake**実装を使用
- 複雑な検証には**Mock**オブジェクト（Mocktail）を使用
- ウィジェットセットアップ用ヘルパー関数: `loadWidget(WidgetTester tester)`
- プロバイダーとnotifierのテストには`ProviderContainer`を使用

## Task Completion Protocol (必須実行手順)

**すべてのタスク完了時に以下を必ず実行すること:**

1. **コード品質チェック（必須）**
   ```bash
   # 静的解析を実行して問題がないことを確認
   dart analyze
   ```

2. **問題が検出された場合の対応**
   ```bash
   # 自動修正を実行
   dart fix --apply && dart format .
   
   # 再度解析を実行
   dart analyze
   ```

3. **手動修正が必要な場合**
   - 残った問題を一つずつ手動で修正
   - 全ての警告・エラーが解消されるまで繰り返す

4. **最終確認**
   ```bash
   # 最終的にクリーンな状態であることを確認
   dart analyze
   # "No issues found!" が表示されることを確認
   ```

**重要**: 
- `dart analyze`で問題が残っている状態でタスクを完了してはいけません
- **analysis_options.yamlの変更は絶対に禁止** - lint規則を無効化してはいけません
- 警告やエラーはコード修正で解決すること

## After Task Completion
- タスクの実行内容を以下のコマンドで読み上げる
```bash
say -v kyoko "{タスク内容}"
```