import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_form_notifier.freezed.dart';
part 'auth_form_notifier.g.dart';

/// Form validation state
@freezed
class FormValidationState with _$FormValidationState {
  const factory FormValidationState({
    @Default('') String userId,
    @Default('') String email,
    @Default('') String userName,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool agreeTerms,
    @Default({}) Map<String, String> errors,
    @Default(false) bool isValid,
  }) = _FormValidationState;
}

/// Form validation notifier
@riverpod
class AuthFormNotifier extends _$AuthFormNotifier {
  @override
  FormValidationState build() {
    return const FormValidationState();
  }

  /// Update user ID and validate
  void updateUserId(String value) {
    final errors = Map<String, String>.from(state.errors);

    // Validate user ID
    if (value.isEmpty) {
      errors['userId'] = 'ユーザーIDを入力してください';
    } else if (value.length < 3) {
      errors['userId'] = 'ユーザーIDは3文字以上で入力してください';
    } else if (value.length > 20) {
      errors['userId'] = 'ユーザーIDは20文字以下で入力してください';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      errors['userId'] = 'ユーザーIDは英数字とアンダースコアのみ使用できます';
    } else {
      errors.remove('userId');
    }

    state = state.copyWith(
      userId: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Update email and validate
  void updateEmail(String value) {
    final errors = Map<String, String>.from(state.errors);

    // Validate email
    if (value.isEmpty) {
      errors['email'] = 'メールアドレスを入力してください';
    } else if (!_isValidEmail(value)) {
      errors['email'] = '正しいメールアドレスを入力してください';
    } else {
      errors.remove('email');
    }

    state = state.copyWith(
      email: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Update user name and validate
  void updateUserName(String value) {
    final errors = Map<String, String>.from(state.errors);

    // Validate user name
    if (value.isEmpty) {
      errors['userName'] = 'ユーザー名を入力してください';
    } else if (value.length < 2) {
      errors['userName'] = 'ユーザー名は2文字以上で入力してください';
    } else if (value.length > 50) {
      errors['userName'] = 'ユーザー名は50文字以下で入力してください';
    } else {
      errors.remove('userName');
    }

    state = state.copyWith(
      userName: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Update password and validate
  void updatePassword(String value) {
    final errors = Map<String, String>.from(state.errors);

    // Validate password
    if (value.isEmpty) {
      errors['password'] = 'パスワードを入力してください';
    } else if (value.length < 6) {
      errors['password'] = 'パスワードは6文字以上で入力してください';
    } else if (value.length > 128) {
      errors['password'] = 'パスワードは128文字以下で入力してください';
    } else {
      errors.remove('password');
    }

    // Revalidate confirm password if it exists
    if (state.confirmPassword.isNotEmpty) {
      if (state.confirmPassword != value) {
        errors['confirmPassword'] = 'パスワードが一致しません';
      } else {
        errors.remove('confirmPassword');
      }
    }

    state = state.copyWith(
      password: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Update confirm password and validate
  void updateConfirmPassword(String value) {
    final errors = Map<String, String>.from(state.errors);

    // Validate confirm password
    if (value.isEmpty) {
      errors['confirmPassword'] = 'パスワード確認を入力してください';
    } else if (value != state.password) {
      errors['confirmPassword'] = 'パスワードが一致しません';
    } else {
      errors.remove('confirmPassword');
    }

    state = state.copyWith(
      confirmPassword: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Update terms agreement
  void updateAgreeTerms({required bool value}) {
    final errors = Map<String, String>.from(state.errors);

    if (!value) {
      errors['agreeTerms'] = '利用規約に同意してください';
    } else {
      errors.remove('agreeTerms');
    }

    state = state.copyWith(
      agreeTerms: value,
      errors: errors,
      isValid: _calculateIsValid(errors),
    );
  }

  /// Clear all form data
  void clear() {
    state = const FormValidationState();
  }

  /// Get error message for specific field
  String? getErrorFor(String field) {
    return state.errors[field];
  }

  /// Check if specific field has error
  bool hasErrorFor(String field) {
    return state.errors.containsKey(field);
  }

  /// Validate all fields for login
  bool validateForLogin() {
    final errors = <String, String>{};

    if (state.email.isEmpty) {
      errors['email'] = 'メールアドレスを入力してください';
    } else if (!_isValidEmail(state.email)) {
      errors['email'] = '正しいメールアドレスを入力してください';
    }

    if (state.password.isEmpty) {
      errors['password'] = 'パスワードを入力してください';
    }

    state = state.copyWith(errors: errors, isValid: errors.isEmpty);

    return errors.isEmpty;
  }

  /// Validate all fields for signup
  bool validateForSignup() {
    final errors = <String, String>{};

    if (state.userId.isEmpty) {
      errors['userId'] = 'ユーザーIDを入力してください';
    }
    if (state.email.isEmpty) {
      errors['email'] = 'メールアドレスを入力してください';
    }
    if (state.userName.isEmpty) {
      errors['userName'] = 'ユーザー名を入力してください';
    }
    if (!state.agreeTerms) {
      errors['agreeTerms'] = '利用規約に同意してください';
    }

    state = state.copyWith(errors: errors, isValid: errors.isEmpty);

    return errors.isEmpty;
  }

  /// Calculate if form is valid based on current errors and required fields
  bool _calculateIsValid(Map<String, String> errors) {
    return errors.isEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty;
  }

  /// Email validation regex
  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }
}
