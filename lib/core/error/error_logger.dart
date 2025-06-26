import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'app_error.dart';

/// Service for logging errors with different levels
class ErrorLogger {
  ErrorLogger._();

  static final _instance = ErrorLogger._();
  static ErrorLogger get instance => _instance;

  /// Logs an AppError with appropriate level
  void logError(AppError error) {
    if (kDebugMode) {
      // In debug mode, log everything with details
      _logToConsole(error);
    } else {
      // In release mode, only log certain errors
      if (_shouldLogInRelease(error)) {
        _logToConsole(error, includeStackTrace: false);
      }
    }

    // TODO(feature): Send to external logging service in production
    // Example: FirebaseCrashlytics, Sentry, etc.
  }

  /// Logs error to console
  void _logToConsole(AppError error, {bool includeStackTrace = true}) {
    final level = _getLogLevel(error.severity);
    final message = _formatErrorMessage(error);

    developer.log(
      message,
      name: 'AppError',
      level: level,
      error: includeStackTrace ? error.originalError : null,
      stackTrace: includeStackTrace ? error.stackTrace : null,
    );
  }

  /// Determines if error should be logged in release mode
  bool _shouldLogInRelease(AppError error) {
    switch (error.severity) {
      case ErrorSeverity.info:
        return false;
      case ErrorSeverity.warning:
        return false;
      case ErrorSeverity.error:
      case ErrorSeverity.critical:
        return true;
    }
  }

  /// Gets appropriate log level based on error severity
  int _getLogLevel(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return 800; // INFO
      case ErrorSeverity.warning:
        return 900; // WARNING
      case ErrorSeverity.error:
        return 1000; // SEVERE
      case ErrorSeverity.critical:
        return 1200; // SHOUT
    }
  }

  /// Formats error message for logging
  String _formatErrorMessage(AppError error) {
    final buffer =
        StringBuffer()
          ..writeln('Error Type: ${error.type.name}')
          ..writeln('Message: ${error.message}');

    if (error.userMessage != null && error.userMessage != error.message) {
      buffer.writeln('User Message: ${error.userMessage}');
    }

    if (error.code != null) {
      buffer.writeln('Code: ${error.code}');
    }

    if (error.statusCode != null) {
      buffer.writeln('HTTP Status: ${error.statusCode}');
    }

    if (error.context != null && error.context!.isNotEmpty) {
      buffer.writeln('Context: ${error.context}');
    }

    return buffer.toString().trim();
  }

  /// Logs info level message
  void logInfo(String message, {Map<String, dynamic>? context}) {
    if (kDebugMode) {
      developer.log(message, name: 'AppInfo', level: 800);
    }
  }

  /// Logs warning level message
  void logWarning(String message, {Map<String, dynamic>? context}) {
    developer.log(message, name: 'AppWarning', level: 900);
  }

  /// Logs debug level message (only in debug mode)
  void logDebug(String message, {Map<String, dynamic>? context}) {
    if (kDebugMode) {
      developer.log(message, name: 'AppDebug', level: 500);
    }
  }
}
