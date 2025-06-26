# GEMINI.md

This file provides guidance to Gemini when working with code in this repository.

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
fvm flutter pub get

# Run the app in debug mode
fvm flutter run

# Run with specific environment
fvm flutter run --target lib/main_development.dart    # Development mode (local data)

# Code generation (required after model changes)
fvm flutter packages pub run build_runner build       # One-time generation
fvm flutter packages pub run build_runner watch       # Watch mode

# Run tests
fvm flutter test
fvm flutter test integration_test/                    # Integration tests
fvm flutter test test/specific_test_file.dart         # Specific test file

# Analyze code for issues
fvm flutter analyze

# Format code
fvm dart format .

# Build for production
fvm flutter build apk    # Android
fvm flutter build ios    # iOS

# Clean build artifacts
fvm flutter clean

# Upgrade dependencies
fvm flutter pub upgrade
```

### Flutter Version Management
The project uses FVM (Flutter Version Management) with Flutter 3.29.3. **All flutter/dart commands must be prefixed with `fvm`**.
```bash
# Install correct Flutter version
fvm install 3.29.3
fvm use 3.29.3

# Run commands with FVM
fvm flutter run
```

## Architecture

### Clean Architecture (Strict Adherence)

This Flutter app follows **Clean Architecture** to achieve a strict separation of concerns:

#### Layer Structure
- **Domain** (`lib/domain/`): Business entities (Freezed models) and use cases.
- **Data** (`lib/data/`): Repository implementations (local/remote) and API services.
- **UI** (`lib/ui/`): ViewModels and Widgets organized by feature using the MVVM pattern.

#### Key Patterns
- **Repository Pattern**: Abstract repository and local/remote implementations for each entity.
- **MVVM**: StateNotifier handles business logic, Widgets are for presentation only.
- **Riverpod**: Dependency injection and state management.
- **Environment Configuration**: Development (local data) vs. Staging (remote data).

### Directory Structure and File Naming Conventions

#### Directory Layout
```
lib/
├── domain/models/[entity]/           # Business Entities
│   ├── [entity].dart                 # Main model (Freezed)
│   ├── [entity].freezed.dart         # Generated file
│   ├── [entity].g.dart              # JSON serialization
│   └── [entity]_summary.dart        # Summary model
├── data/repositories/[entity]/       # Data Access Layer
│   ├── [entity]_repository.dart      # Abstract interface
│   ├── [entity]_repository_local.dart    # Local implementation
│   └── [entity]_repository_remote.dart   # Remote implementation
└── ui/[feature]/                     # Feature-based UI
    ├── notifiers/
    │   └── [feature]_notifier.dart   # StateNotifier/AsyncNotifier
    └── widgets/
        ├── [feature]_screen.dart     # Main screen
        └── [feature]_*.dart          # Components
```

#### File Naming (snake_case required)
- **StateNotifiers**: `*_notifier.dart` (e.g., `home_notifier.dart`)
- **Repositories**: `*_repository.dart` (interface), `*_repository_local.dart`, `*_repository_remote.dart`
- **API Models**: `*_api_model.dart` (e.g., `user_api_model.dart`)
- **Screens**: `*_screen.dart` (e.g., `home_screen.dart`)
- **Use Cases**: `*_use_case.dart` (e.g., `booking_create_use_case.dart`)

## Development Principles (Strict Adherence)

**The following principles must be strictly followed:**

- **KISS (Keep It Simple, Stupid)**: 
  - Always prioritize simple and readable solutions.
  - Choose concise implementations over complex ones.
  - Avoid excessive abstraction.

- **DRY (Don't Repeat Yourself)**: 
  - Thoroughly eliminate code duplication.
  - Always extract common widgets and utilities.
  - Do not write the same logic in more than one place.

- **YAGNI (You Aren't Gonna Need It)**: 
  - Do not implement features until they are actually needed.
  - Avoid over-engineering for future scalability.
  - Focus on the current requirements.

## Coding Conventions

### Import Order (Strict Adherence)
Organize imports in the following order:
1. Dart core libraries (`dart:async`, `dart:convert`)
2. Flutter SDK (`package:flutter/material.dart`)
3. External packages (alphabetical order)
4. Relative imports (project files)
5. Part declarations (code generation)

**Always use relative imports for project files**:
```dart
// ✅ Correct
import '../../../data/repositories/booking/booking_repository.dart';

// ❌ Incorrect
import 'package:gen_flash_english_study/data/repositories/booking/booking_repository.dart';
```

### Error Handling
- Use the **Result<T>** pattern (`Ok<T>` and `Error<T>` types).
- Always use a `switch` expression for Result handling.
- Include context information in error logs.
- Use `finally` blocks for cleanup.

### Freezed Models
```dart
@freezed
class ModelName with _$ModelName {
  const factory ModelName({
    /// Always add doc comments for each field
    int? id,
    
    /// Description for required fields
    required String name,
    
    /// Specify concrete types for list fields
    required List<Activity> activities,
  }) = _ModelName;

  factory ModelName.fromJson(Map<String, Object?> json) => _$ModelNameFromJson(json);
}
```

### UI Construction

**Widget Selection Criteria (Strict Adherence)**:

- **StatelessWidget**: For parts without state. Maximizes reusability and testability. Ideal for pure presentation components.
- **HookWidget**: For parts with ephemeral state (e.g., TextEditingController, AnimationController). Ideal for UI-local state management.
- **ConsumerWidget**: For parts with app state. References Riverpod providers. Ideal for global state management.
- **ConsumerHookWidget**: Combine both features when necessary (for both app state and ephemeral state).

**Component Design Principles**:
- Always consider componentization and reusability.
- Follow the Single Responsibility Principle: each Widget should focus on one role.
- Extract common UI parts into separate files for reuse.

## ⚠️ Code Quality Assurance (Required After Implementation) ⚠️

**🚨 IMPORTANT: The following steps must be performed after every implementation. Do not skip this. 🚨**

### 🚫 Strictly Prohibited
- **Absolutely no changes to `analysis_options.yaml`** - Do not modify existing lint settings.
- It is forbidden to edit `analysis_options.yaml` to hide lint warnings or errors.
- Instead, fix the code itself to comply with the lint rules.

### Required Checklist

- [ ] **1. Run static analysis**
   ```bash
   fvm dart analyze
   ```

- [ ] **2. Auto-fix detected issues**
   ```bash
   # Run auto-fix and format
   fvm dart fix --apply && fvm dart format .
   ```

- [ ] **3. Manually fix remaining issues**
   - Manually correct any issues not resolved by the auto-fix.
   - Repeat until all issues are resolved.

- [ ] **4. Final verification**
   ```bash
   # Confirm all issues are resolved
   fvm dart analyze
   # Ensure "No issues found!" is displayed
   ```

**❌ What you must NOT do:**
- Complete a task without running `fvm dart analyze`.
- Proceed to the next task with remaining warnings or errors.
- Postpone fixes with "I'll fix it later."

**✅ Success Criteria:**
- The output of `fvm dart analyze` is "No issues found!".

## Testing Strategy

### Test Structure
- **Unit Tests**: Test repository and use case logic in `test/`.
- **Widget Tests**: Test screen components with mock dependencies in `test/ui/`.
- **Integration Tests**: Test end-to-end flows in `integration_test/`.

### Test Tools
- Use **Mocktail** to mock external dependencies.
- Use fake repositories in `testing/fakes/` for consistent test data.
- Use `testing/app.dart` for test app configuration.

### Testing Conventions
- Test file names: `*_test.dart`.
- Organize related tests with `group()`.
- Test names: `'should [action/behavior]'` format.
- Use **Fake** implementations for simple mocks.
- Use **Mock** objects (Mocktail) for complex verification.
- Use helper function `loadWidget(WidgetTester tester)` for widget setup.
- Use `ProviderContainer` for testing providers and notifiers.

## Task Completion Protocol (Required Steps)

**Always perform the following upon completing any task:**

1. **Code Quality Check (Mandatory)**
   ```bash
   # Run static analysis to ensure no issues
   fvm dart analyze
   ```

2. **Action on Detected Issues**
   ```bash
   # Run auto-fix
   fvm dart fix --apply && fvm dart format .
   
   # Re-run analysis
   fvm dart analyze
   ```

3. **If Manual Fixes are Needed**
   - Manually correct any remaining issues one by one.
   - Repeat until all warnings and errors are resolved.

4. **Final Confirmation**
   ```bash
   # Confirm a clean state finally
   fvm dart analyze
   # Ensure "No issues found!" is displayed
   ```

**Important**: 
- Do not complete a task if `fvm dart analyze` has remaining issues.
- **Changing `analysis_options.yaml` is strictly prohibited** - do not disable lint rules.
- Resolve warnings and errors by fixing the code.
