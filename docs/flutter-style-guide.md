# Flutter スタイル実装ガイド

## 🎨 概要

このドキュメントは、**Webフロントエンドのテーマ・カラー**を使用した**モバイル独自UI**の実装ガイドです。

### 設計方針
- **テーマ・カラー**: Webフロントエンド準拠（統一感）
- **UI・レイアウト**: モバイル独自（スワイプカード等）

## 🚀 基本セットアップ

### 1. テーマの適用

```dart
// main.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenFlash English Study',
      theme: AppTheme.lightTheme,        // Webスタイルのライトテーマ
      darkTheme: AppTheme.darkTheme,     // ダークテーマ（オプション）
      home: HomeScreen(),
    );
  }
}
```

### 2. カラーのインポート

```dart
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_theme.dart';
```

## 📱 モバイル独自UI実装方針

### 1. **メイン学習画面**: Tinder/Tapple風スワイプカード (必須)
- **レイアウト**: スタック形式の重ねカード
- **インタラクション**: 左右スワイプ（覚えた/覚えていない）
- **アニメーション**: スムーズなカード移動・回転
- **フィードバック**: ハプティック振動、色による視覚フィードバック

### 2. **カード一覧画面**: モバイル最適化リスト
- **レイアウト**: 縦スクロール、タップ操作
- **表示**: カード状の要素、Webの表形式は使わない
- **ナビゲーション**: モバイル特有のスワイプ・タップ操作

### 3. **詳細画面**: フルスクリーン表示
- **レイアウト**: 単一カード、縦積みレイアウト
- **操作**: タップ・スワイプジェスチャー
- **情報**: 読み取り専用表示（編集機能なし）

## 🎨 Webテーマの活用方法

### スワイプカードでのWebテーマ適用
```dart
// カード背景：Webのカラーパレット使用
decoration: context.flashcardDecoration

// 品詞タグ：Web準拠のカラー
decoration: context.posChipDecoration(meaning.pos.name)

// テキスト：Webフロントエンドと同じカラー
color: AppColors.textMain        // メインテキスト
color: AppColors.textSub         // サブテキスト
color: AppColors.colorMain       // アクセントテキスト
```

### スワイプフィードバック
```dart
// 右スワイプ（覚えた）：成功色
backgroundColor: AppColors.swipeRightFeedback  // #4CAF50

// 左スワイプ（覚えていない）：エラー色  
backgroundColor: AppColors.swipeLeftFeedback   // #F44336
```

### モバイルボタン
```dart
// Webテーマ色を使用したモバイル特化ボタン
backgroundColor: AppColors.buttonPrimary    // Web準拠の緑
foregroundColor: AppColors.onPrimary       // 白テキスト
```

## 🎨 カラーパレット クイックリファレンス

### 基本カラー
```dart
AppColors.background        // #fffdf6 (メイン背景)
AppColors.bgSecondary      // #faf6e9 (セカンダリ背景)
AppColors.bgWhole          // #eaefd2 (ヘッダー背景)
AppColors.primary          // #a0c878 (メインテーマ色)
AppColors.secondary        // #ddeb9d (サブテーマ色)
```

### テキストカラー
```dart
AppColors.textMain         // #302c53 (メインテキスト)
AppColors.textSub          // #6b6a8e (サブテキスト)
```

### 品詞別カラー
```dart
AppColors.getPartOfSpeechColor('noun')        // #ddeb9d (薄緑)
AppColors.getPartOfSpeechColor('verb')        // #ffff99 (薄黄)  
AppColors.getPartOfSpeechColor('adjective')   // #87ceeb (薄青)
AppColors.getPartOfSpeechColor('adverb')      // #dda0dd (薄紫)
```

### 状態カラー
```dart
AppColors.success          // #a0c878 (成功・学習済み)
AppColors.error           // #c87a78 (エラー・未学習)
AppColors.warning         // #ffb74d (警告・学習中)
```

## 🔧 便利なヘルパー

### 色の明度調整
```dart
// 明るくする
final lightColor = AppColors.getLighterVariant(AppColors.primary, 0.3);

// 暗くする  
final darkColor = AppColors.getDarkerVariant(AppColors.primary, 0.3);
```

### テーマ拡張の活用
```dart
// 現在のテーマコンテキストから使用
context.flashcardDecoration    // Web風カードデコレーション
context.posChipDecoration(pos) // 品詞チップデコレーション
context.backgroundGradient     // 背景グラデーション
```

## 🔧 モバイルUI実装の重要ポイント

### 1. **スワイプカードの設計指針**
- **カードサイズ**: 画面の80-90%を占める大きさ
- **重なり**: 後ろのカードが少し見える程度のオフセット
- **アニメーション**: 滑らかな移動・回転・フェード
- **閾値**: スワイプ距離の30%で判定（`AppConfig.swipeThreshold`）

### 2. **モバイル特有のインタラクション**
- **ハプティックフィードバック**: スワイプ成功時の振動
- **視覚フィードバック**: カラー変化によるスワイプ方向指示
- **ジェスチャー**: タップ、スワイプ、長押しの適切な使い分け
- **片手操作**: 親指で届く範囲のUI配置

### 3. **パフォーマンス最適化**
- **アニメーション**: 60fps維持
- **画像**: 適切なサイズとキャッシュ
- **メモリ**: カードスタックの効率的な管理

## ✨ 実装ガイドライン

### **DO（推奨）**
- ✅ Webテーマのカラーパレットを使用
- ✅ モバイル独自のレイアウト・インタラクション
- ✅ スワイプカードをメイン機能に設計
- ✅ `AppColors`と`AppTheme`で一貫性確保

### **DON'T（非推奨）**  
- ❌ Webのレイアウトをそのまま移植
- ❌ 表形式やグリッド形式の多用
- ❌ ホバー効果などPC向けインタラクション
- ❌ 独自カラーの追加（Webテーマから逸脱）

---

**このガイドに従うことで、Webフロントエンドと統一されたテーマを持ちながら、モバイルに最適化されたUXを提供できます。**