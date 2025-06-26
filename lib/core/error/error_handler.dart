import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../ui/shared/widgets/error/app_dialog.dart';
import '../../ui/shared/widgets/error/app_snack_bar.dart';
import '../exceptions/app_exception.dart';
import 'app_error.dart';
import 'error_logger.dart';

/// Global error handler service
/// for consistent error handling throughout the app
class ErrorHandler {
  ErrorHandler._();

  static final _instance = ErrorHandler._();
  static ErrorHandler get instance => _instance;

  final ErrorLogger _logger = ErrorLogger.instance;

  /// Handles any error and converts it to AppError
  static AppError handleError(Object error, [StackTrace? stackTrace]) {
    final appError = _convertToAppError(error, stackTrace);
    _instance._logger.logError(appError);
    return appError;
  }

  /// Shows error to user via snackbar
  static void showErrorSnackBar(
    BuildContext context,
    Object error, {
    Duration? duration,
    bool includeRetry = false,
    VoidCallback? onRetry,
  }) {
    final appError = handleError(error);

    AppSnackBar.showError(
      context,
      message: appError.displayMessage,
      duration: duration,
      action:
          includeRetry && appError.isRetryable
              ? SnackBarAction(label: '再試行', onPressed: onRetry ?? () {})
              : null,
    );
  }

  /// Shows error dialog to user
  static Future<void> showErrorDialog(
    BuildContext context,
    Object error, {
    String? title,
    bool includeRetry = false,
    VoidCallback? onRetry,
  }) {
    final appError = handleError(error);

    return AppDialog.showError(
      context,
      title: title ?? _getErrorTitle(appError.type),
      message: appError.displayMessage,
      primaryAction:
          includeRetry && appError.isRetryable
              ? DialogAction(label: '再試行', onPressed: onRetry ?? () {})
              : null,
    );
  }

  /// Shows error in the most appropriate way based on context
  static void showError(
    BuildContext context,
    Object error, {
    ErrorDisplayMode mode = ErrorDisplayMode.auto,
    bool includeRetry = false,
    VoidCallback? onRetry,
  }) {
    final appError = handleError(error);

    switch (mode) {
      case ErrorDisplayMode.snackBar:
        showErrorSnackBar(
          context,
          error,
          includeRetry: includeRetry,
          onRetry: onRetry,
        );
      case ErrorDisplayMode.dialog:
        showErrorDialog(
          context,
          error,
          includeRetry: includeRetry,
          onRetry: onRetry,
        );
      case ErrorDisplayMode.auto:
        // Use dialog for critical errors, snackbar for others
        if (appError.severity == ErrorSeverity.critical ||
            appError.severity == ErrorSeverity.error) {
          showErrorDialog(
            context,
            error,
            includeRetry: includeRetry,
            onRetry: onRetry,
          );
        } else {
          showErrorSnackBar(
            context,
            error,
            includeRetry: includeRetry,
            onRetry: onRetry,
          );
        }
    }
  }

  /// Converts various error types to AppError
  static AppError _convertToAppError(Object error, StackTrace? stackTrace) {
    if (error is AppError) {
      return error;
    }

    if (error is AppException) {
      return _convertAppExceptionToAppError(error, stackTrace);
    }

    // Handle common Flutter/Dart exceptions
    if (error is FormatException) {
      return AppErrorFactory.validation(
        'Format error: ${error.message}',
        userMessage: 'データの形式が正しくありません',
        originalError: error,
      );
    }

    if (error is ArgumentError) {
      return AppErrorFactory.validation(
        'Argument error: ${error.message}',
        userMessage: '入力値が正しくありません',
        originalError: error,
      );
    }

    // Fallback to unknown error
    return AppErrorFactory.unknown(
      error.toString(),
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Converts AppException to AppError
  static AppError _convertAppExceptionToAppError(
    AppException exception,
    StackTrace? stackTrace,
  ) {
    switch (exception.runtimeType) {
      case NetworkException _:
        return AppErrorFactory.network(
          exception.message,
          originalError: exception,
          stackTrace: stackTrace,
        );
      case ApiException _:
        return AppErrorFactory.server(
          exception.message,
          originalError: exception,
          stackTrace: stackTrace,
        );
      case AuthException _:
        return AppErrorFactory.permission(
          exception.message,
          originalError: exception,
        );
      case ValidationException _:
        return AppErrorFactory.validation(
          exception.message,
          originalError: exception,
        );
      case DataException _:
        return AppErrorFactory.notFound(
          exception.message,
          originalError: exception,
        );
      case StorageException _:
        return AppErrorFactory.server(
          exception.message,
          userMessage: 'データの保存に失敗しました',
          originalError: exception,
          stackTrace: stackTrace,
        );
      default:
        return AppErrorFactory.unknown(
          exception.message,
          originalError: exception,
          stackTrace: stackTrace,
        );
    }
  }

  /// Gets appropriate title for error type
  static String _getErrorTitle(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return '接続エラー';
      case ErrorType.server:
        return 'サーバーエラー';
      case ErrorType.validation:
        return '入力エラー';
      case ErrorType.notFound:
        return 'データ未検出';
      case ErrorType.permission:
        return '権限エラー';
      case ErrorType.unknown:
        return 'エラー';
    }
  }

  /// Reports error to external service (Crashlytics, Sentry, etc.)
  static Future<void> reportError(
    Object error,
    StackTrace? stackTrace, {
    Map<String, dynamic>? context,
  }) async {
    final appError = handleError(error, stackTrace);

    // Log locally first
    _instance._logger.logError(appError);

    // In development, log to console
    if (kDebugMode) {
      developer.log(
        'Error reported: ${appError.message}',
        name: 'ErrorHandler',
        error: error,
        stackTrace: stackTrace,
      );
    }

    // TODO(feature): Integrate with external error reporting service
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Initializes global error handling
  static void initialize() {
    // Set up Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      reportError(details.exception, details.stack);
    };

    // Set up platform dispatcher error handling
    PlatformDispatcher.instance.onError = (error, stack) {
      reportError(error, stack);
      return true;
    };
  }
}

/// How errors should be displayed to users
enum ErrorDisplayMode {
  /// Show as snackbar
  snackBar,

  /// Show as dialog
  dialog,

  /// Automatically choose based on error severity
  auto,
}
