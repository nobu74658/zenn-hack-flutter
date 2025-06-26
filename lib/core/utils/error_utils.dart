import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/app_error.dart';
import '../exceptions/app_exception.dart';
import 'result.dart';

/// Utility functions for error handling and conversion
class ErrorUtils {
  ErrorUtils._();

  /// Converts various error types to AppError
  static AppError fromException(Object error, [StackTrace? stackTrace]) {
    if (error is AppError) {
      return error;
    }

    if (error is AppException) {
      return _fromAppException(error, stackTrace);
    }

    if (error is DioException) {
      return _fromDioException(error, stackTrace);
    }

    if (error is SocketException) {
      return AppErrorFactory.network(
        'Socket error: ${error.message}',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

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
  static AppError _fromAppException(
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

  /// Converts DioException to AppError
  static AppError _fromDioException(
    DioException error,
    StackTrace? stackTrace,
  ) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppErrorFactory.network(
          'Request timeout: ${error.message}',
          userMessage: '通信がタイムアウトしました。再試行してください',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.connectionError:
        return AppErrorFactory.network(
          'Connection error: ${error.message}',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final statusMessage = error.response?.statusMessage;

        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return AppErrorFactory.validation(
                'Bad request: $statusMessage',
                userMessage: 'リクエストの内容に問題があります',
                originalError: error,
              );
            case 401:
              return AppErrorFactory.permission(
                'Unauthorized: $statusMessage',
                userMessage: '認証が必要です',
                originalError: error,
              );
            case 403:
              return AppErrorFactory.permission(
                'Forbidden: $statusMessage',
                userMessage: 'アクセス権限がありません',
                originalError: error,
              );
            case 404:
              return AppErrorFactory.notFound(
                'Not found: $statusMessage',
                originalError: error,
              );
            case 429:
              return AppErrorFactory.server(
                'Too many requests: $statusMessage',
                userMessage: 'リクエストが多すぎます。しばらく待ってから再試行してください',
                statusCode: statusCode,
                originalError: error,
              );
            case >= 500:
              return AppErrorFactory.server(
                'Server error: $statusMessage',
                statusCode: statusCode,
                originalError: error,
                stackTrace: stackTrace,
              );
            default:
              return AppErrorFactory.server(
                'HTTP error $statusCode: $statusMessage',
                statusCode: statusCode,
                originalError: error,
                stackTrace: stackTrace,
              );
          }
        }

        return AppErrorFactory.server(
          'Bad response: ${error.message}',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.cancel:
        return AppErrorFactory.unknown(
          'Request cancelled: ${error.message}',
          userMessage: 'リクエストがキャンセルされました',
          originalError: error,
        );

      case DioExceptionType.badCertificate:
        return AppErrorFactory.network(
          'Certificate error: ${error.message}',
          userMessage: '証明書エラーが発生しました',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.unknown:
        return AppErrorFactory.unknown(
          'Unknown error: ${error.message}',
          originalError: error,
          stackTrace: stackTrace,
        );
    }
  }

  /// Checks if error is retriable
  static bool isRetriable(Object error) {
    if (error is AppError) {
      return error.isRetryable;
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return true;
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          // Retry on server errors (5xx) but not client errors (4xx)
          return statusCode != null && statusCode >= 500;
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          return false;
      }
    }

    if (error is SocketException) {
      return true;
    }

    if (error is AppException) {
      return error is NetworkException || error is ApiException;
    }

    return false;
  }

  /// Gets user-friendly error message
  static String getUserMessage(Object error) {
    if (error is AppError) {
      return error.displayMessage;
    }

    return fromException(error).displayMessage;
  }

  /// Logs error for debugging
  static void logError(Object error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('Error: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }

  /// Wraps a function call with error handling
  static Result<T> wrapCall<T>(T Function() function) {
    try {
      final result = function();
      return Ok(result);
    } on Exception catch (e) {
      if (e is AppException) {
        return Error(e);
      } else {
        // Convert to a generic AppException
        return Error(ValidationException(e.toString()));
      }
    } on Object catch (e) {
      // Convert any other error to ValidationException
      return Error(ValidationException(e.toString()));
    }
  }

  /// Wraps an async function call with error handling
  static Future<Result<T>> wrapAsyncCall<T>(
    Future<T> Function() function,
  ) async {
    try {
      final result = await function();
      return Ok(result);
    } on Exception catch (e) {
      if (e is AppException) {
        return Error(e);
      } else {
        // Convert to a generic AppException
        return Error(ValidationException(e.toString()));
      }
    } on Object catch (e) {
      // Convert any other error to ValidationException
      return Error(ValidationException(e.toString()));
    }
  }

  /// Creates a safe async operation that returns Result
  static Future<Result<T>> safeAsync<T>(Future<T> Function() operation) {
    return wrapAsyncCall(operation);
  }

  /// Creates a safe sync operation that returns Result
  static Result<T> safe<T>(T Function() operation) {
    return wrapCall(operation);
  }
}
