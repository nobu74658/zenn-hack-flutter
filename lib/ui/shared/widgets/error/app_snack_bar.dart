import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Custom snack bar implementation with Material 3 design
class AppSnackBar {
  AppSnackBar._();

  /// Shows a success snack bar
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      action: action,
    );
  }

  /// Shows an error snack bar
  static void showError(
    BuildContext context, {
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      action: action,
    );
  }

  /// Shows a warning snack bar
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      action: action,
    );
  }

  /// Shows an info snack bar
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      action: action,
    );
  }

  /// Internal method to show snack bar
  static void _show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration? duration,
    SnackBarAction? action,
  }) {
    final colors = _getColors(type);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(_getIcon(type), color: colors.iconColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: colors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: colors.backgroundColor,
          duration: duration ?? const Duration(seconds: 4),
          action: action,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
          elevation: 6,
        ),
      );
  }

  /// Gets icon for snack bar type
  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }

  /// Gets colors for snack bar type
  static _SnackBarColors _getColors(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const _SnackBarColors(
          backgroundColor: Color(0xFF4CAF50),
          textColor: Colors.white,
          iconColor: Colors.white,
        );
      case SnackBarType.error:
        return const _SnackBarColors(
          backgroundColor: AppColors.error,
          textColor: Colors.white,
          iconColor: Colors.white,
        );
      case SnackBarType.warning:
        return const _SnackBarColors(
          backgroundColor: Color(0xFFFF9800),
          textColor: Colors.white,
          iconColor: Colors.white,
        );
      case SnackBarType.info:
        return const _SnackBarColors(
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
          iconColor: Colors.white,
        );
    }
  }
}

/// Snack bar type enumeration
enum SnackBarType { success, error, warning, info }

/// Internal class for snack bar colors
class _SnackBarColors {
  const _SnackBarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
}
