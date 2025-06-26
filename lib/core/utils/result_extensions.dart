import 'package:flutter/material.dart';

import '../error/app_error.dart';
import '../error/error_handler.dart';
import '../exceptions/app_exception.dart';
import 'result.dart';

/// Extensions for Result type to handle errors in UI
extension ResultErrorHandling<T> on Result<T> {
  /// Shows error to user if Result is Error
  void showErrorIfFailed(BuildContext context) {
    switch (this) {
      case Ok():
        break;
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        ErrorHandler.showError(context, appError);
    }
  }

  /// Shows error snackbar if Result is Error
  void showErrorSnackBarIfFailed(BuildContext context) {
    switch (this) {
      case Ok():
        break;
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        ErrorHandler.showErrorSnackBar(context, appError);
    }
  }

  /// Shows error dialog if Result is Error
  Future<void> showErrorDialogIfFailed(BuildContext context) async {
    switch (this) {
      case Ok():
        break;
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        await ErrorHandler.showErrorDialog(context, appError);
    }
  }

  /// Shows error with retry option if Result is Error
  void showErrorWithRetry(
    BuildContext context, {
    required VoidCallback onRetry,
  }) {
    switch (this) {
      case Ok():
        break;
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        ErrorHandler.showError(
          context,
          appError,
          includeRetry: true,
          onRetry: onRetry,
        );
    }
  }

  /// Converts Result to AppError if failed, returns null if successful
  AppError? toAppErrorOrNull() {
    switch (this) {
      case Ok():
        return null;
      case Error(:final exception):
        return ErrorHandler.handleError(exception);
    }
  }

  /// Executes success callback if Ok, error callback if Error
  void when({
    required void Function(T data) onSuccess,
    required void Function(AppError error) onError,
  }) {
    switch (this) {
      case Ok(:final data):
        onSuccess(data);
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        onError(appError);
    }
  }

  /// Executes callbacks and returns a widget based on result state
  Widget buildWidget({
    required Widget Function(T data) onSuccess,
    required Widget Function(AppError error) onError,
  }) {
    switch (this) {
      case Ok(:final data):
        return onSuccess(data);
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        return onError(appError);
    }
  }

  /// Fold the result into a single value
  U fold<U>({
    required U Function(T data) onSuccess,
    required U Function(AppError error) onError,
  }) {
    switch (this) {
      case Ok(:final data):
        return onSuccess(data);
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        return onError(appError);
    }
  }
}

/// Extensions for handling async Results
extension AsyncResultErrorHandling<T> on Future<Result<T>> {
  /// Shows error to user if Future Result is Error
  Future<void> showErrorIfFailed(BuildContext context) async {
    final result = await this;
    if (context.mounted) {
      result.showErrorIfFailed(context);
    }
  }

  /// Shows error snackbar if Future Result is Error
  Future<void> showErrorSnackBarIfFailed(BuildContext context) async {
    final result = await this;
    if (context.mounted) {
      result.showErrorSnackBarIfFailed(context);
    }
  }

  /// Shows error dialog if Future Result is Error
  Future<void> showErrorDialogIfFailed(BuildContext context) async {
    final result = await this;
    if (context.mounted) {
      await result.showErrorDialogIfFailed(context);
    }
  }

  /// Shows error with retry option if Future Result is Error
  Future<void> showErrorWithRetry(
    BuildContext context, {
    required VoidCallback onRetry,
  }) async {
    final result = await this;
    if (context.mounted) {
      result.showErrorWithRetry(context, onRetry: onRetry);
    }
  }

  /// Executes success callback if Ok, error callback if Error
  Future<void> whenAsync({
    required Future<void> Function(T data) onSuccess,
    required Future<void> Function(AppError error) onError,
  }) async {
    final result = await this;
    switch (result) {
      case Ok(:final data):
        await onSuccess(data);
      case Error(:final exception):
        final appError = ErrorHandler.handleError(exception);
        await onError(appError);
    }
  }

  /// Maps success value while preserving error
  Future<Result<U>> mapAsync<U>(Future<U> Function(T) mapper) async {
    final result = await this;
    switch (result) {
      case Ok(:final data):
        try {
          final mappedData = await mapper(data);
          return Ok(mappedData);
        } on Exception catch (e) {
          if (e is AppException) {
            return Error(e);
          } else {
            return Error(ValidationException(e.toString()));
          }
        } on Object catch (e) {
          return Error(ValidationException(e.toString()));
        }
      case Error(:final exception):
        return Error(exception);
    }
  }

  /// Flat maps async result
  Future<Result<U>> flatMapAsync<U>(
    Future<Result<U>> Function(T) mapper,
  ) async {
    final result = await this;
    switch (result) {
      case Ok(:final data):
        try {
          return await mapper(data);
        } on Exception catch (e) {
          if (e is AppException) {
            return Error(e);
          } else {
            return Error(ValidationException(e.toString()));
          }
        } on Object catch (e) {
          return Error(ValidationException(e.toString()));
        }
      case Error(:final exception):
        return Error(exception);
    }
  }
}

/// Utility functions for working with multiple Results
class ResultUtils {
  ResultUtils._();

  /// Combines multiple Results into a single Result
  static Result<List<T>> combine<T>(List<Result<T>> results) {
    final values = <T>[];

    for (final result in results) {
      switch (result) {
        case Ok(:final data):
          values.add(data);
        case Error(:final exception):
          return Error(exception);
      }
    }

    return Ok(values);
  }

  /// Executes multiple async operations and combines results
  static Future<Result<List<T>>> combineAsync<T>(
    List<Future<Result<T>>> futures,
  ) async {
    final results = await Future.wait(futures);
    return combine(results);
  }

  /// Returns the first successful result, or the last error if all fail
  static Result<T> firstSuccess<T>(List<Result<T>> results) {
    Result<T>? lastError;

    for (final result in results) {
      switch (result) {
        case Ok():
          return result;
        case Error():
          lastError = result;
      }
    }

    return lastError ?? const Error(ValidationException('No results provided'));
  }
}
