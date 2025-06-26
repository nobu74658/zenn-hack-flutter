// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';
part 'app_error.g.dart';

/// Error types for categorizing different kinds of errors
enum ErrorType {
  /// Network connectivity issues
  network,

  /// Server-side errors
  server,

  /// Validation errors (input, form, etc.)
  validation,

  /// Data not found errors
  notFound,

  /// Permission/authorization errors
  permission,

  /// Unknown or uncategorized errors
  unknown,
}

/// Comprehensive error model using Freezed for immutability and code generation
@freezed
class AppError with _$AppError {
  const factory AppError({
    /// Type of error for categorization
    required ErrorType type,

    /// Technical error message (for logging/debugging)
    required String message,

    /// User-friendly message to display to users
    String? userMessage,

    /// Original error object if available
    @JsonKey(includeFromJson: false, includeToJson: false)
    Object? originalError,

    /// Stack trace for debugging
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,

    /// HTTP status code if applicable
    int? statusCode,

    /// Error code for specific error identification
    String? code,

    /// Additional context data
    Map<String, dynamic>? context,
  }) = _AppError;

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);
}

/// Utility class for creating AppError instances
class AppErrorFactory {
  AppErrorFactory._();

  /// Creates a network error
  static AppError network(
    String message, {
    String? userMessage,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      type: ErrorType.network,
      message: message,
      userMessage: userMessage ?? 'インターネット接続を確認してください',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Creates a server error
  static AppError server(
    String message, {
    String? userMessage,
    int? statusCode,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      type: ErrorType.server,
      message: message,
      userMessage: userMessage ?? 'サーバーで問題が発生しました。しばらく後に再試行してください',
      statusCode: statusCode,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Creates a validation error
  static AppError validation(
    String message, {
    String? userMessage,
    String? field,
    Object? originalError,
  }) {
    return AppError(
      type: ErrorType.validation,
      message: message,
      userMessage: userMessage ?? message,
      originalError: originalError,
      context: field != null ? {'field': field} : null,
    );
  }

  /// Creates a not found error
  static AppError notFound(
    String message, {
    String? userMessage,
    Object? originalError,
  }) {
    return AppError(
      type: ErrorType.notFound,
      message: message,
      userMessage: userMessage ?? 'データが見つかりませんでした',
      originalError: originalError,
    );
  }

  /// Creates a permission error
  static AppError permission(
    String message, {
    String? userMessage,
    Object? originalError,
  }) {
    return AppError(
      type: ErrorType.permission,
      message: message,
      userMessage: userMessage ?? '権限がありません',
      originalError: originalError,
    );
  }

  /// Creates an unknown error
  static AppError unknown(
    String message, {
    String? userMessage,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AppError(
      type: ErrorType.unknown,
      message: message,
      userMessage: userMessage ?? '予期しないエラーが発生しました',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }
}

/// Extension methods for AppError to provide convenient getters and methods
extension AppErrorExtensions on AppError {
  /// Returns the appropriate user message to display
  String get displayMessage => userMessage ?? _getDefaultUserMessage();

  /// Gets default user message based on error type
  String _getDefaultUserMessage() {
    switch (type) {
      case ErrorType.network:
        return 'インターネット接続を確認してください';
      case ErrorType.server:
        return 'サーバーで問題が発生しました。しばらく後に再試行してください';
      case ErrorType.validation:
        return '入力内容を確認してください';
      case ErrorType.notFound:
        return 'データが見つかりませんでした';
      case ErrorType.permission:
        return '権限がありません';
      case ErrorType.unknown:
        return '予期しないエラーが発生しました';
    }
  }

  /// Returns true if this error should trigger a retry mechanism
  bool get isRetryable {
    switch (type) {
      case ErrorType.network:
      case ErrorType.server:
        return true;
      case ErrorType.validation:
      case ErrorType.notFound:
      case ErrorType.permission:
      case ErrorType.unknown:
        return false;
    }
  }

  /// Returns the severity level of the error
  ErrorSeverity get severity {
    switch (type) {
      case ErrorType.network:
        return ErrorSeverity.warning;
      case ErrorType.server:
        return ErrorSeverity.error;
      case ErrorType.validation:
        return ErrorSeverity.info;
      case ErrorType.notFound:
        return ErrorSeverity.info;
      case ErrorType.permission:
        return ErrorSeverity.error;
      case ErrorType.unknown:
        return ErrorSeverity.error;
    }
  }
}

/// Error severity levels for determining display treatment
enum ErrorSeverity {
  /// Informational messages (light impact)
  info,

  /// Warning messages (medium impact)
  warning,

  /// Error messages (high impact)
  error,

  /// Critical messages (critical impact)
  critical,
}

/// Error recovery actions that can be suggested to users
enum ErrorRecoveryAction {
  /// Retry the failed operation
  retry,

  /// Go back to previous screen
  goBack,

  /// Navigate to home screen
  goHome,

  /// Refresh the current screen
  refresh,

  /// Contact support
  contactSupport,

  /// No action available
  none,
}
