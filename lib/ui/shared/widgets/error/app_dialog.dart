import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Dialog action configuration
class DialogAction {
  const DialogAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isDestructive;
}

/// Custom dialog implementation with Material 3 design
class AppDialog {
  AppDialog._();

  /// Shows a confirmation dialog
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = '確認',
    String cancelText = 'キャンセル',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => _AppAlertDialog(
            title: title,
            message: message,
            actions: [
              DialogAction(
                label: cancelText,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              DialogAction(
                label: confirmText,
                onPressed: () => Navigator.of(context).pop(true),
                isPrimary: true,
                isDestructive: isDestructive,
              ),
            ],
          ),
    );
  }

  /// Shows an error dialog
  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    DialogAction? primaryAction,
    String dismissText = '閉じる',
  }) {
    return showDialog<void>(
      context: context,
      builder:
          (context) => _AppAlertDialog(
            title: title,
            message: message,
            icon: const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 48,
            ),
            actions: [
              if (primaryAction != null) primaryAction,
              DialogAction(
                label: dismissText,
                onPressed: () => Navigator.of(context).pop(),
                isPrimary: primaryAction == null,
              ),
            ],
          ),
    );
  }

  /// Shows an info dialog
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    DialogAction? primaryAction,
    String dismissText = '閉じる',
  }) {
    return showDialog<void>(
      context: context,
      builder:
          (context) => _AppAlertDialog(
            title: title,
            message: message,
            icon: const Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: 48,
            ),
            actions: [
              if (primaryAction != null) primaryAction,
              DialogAction(
                label: dismissText,
                onPressed: () => Navigator.of(context).pop(),
                isPrimary: primaryAction == null,
              ),
            ],
          ),
    );
  }

  /// Shows a warning dialog
  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    DialogAction? primaryAction,
    String dismissText = '閉じる',
  }) {
    return showDialog<void>(
      context: context,
      builder:
          (context) => _AppAlertDialog(
            title: title,
            message: message,
            icon: const Icon(
              Icons.warning_outlined,
              color: Color(0xFFFF9800),
              size: 48,
            ),
            actions: [
              if (primaryAction != null) primaryAction,
              DialogAction(
                label: dismissText,
                onPressed: () => Navigator.of(context).pop(),
                isPrimary: primaryAction == null,
              ),
            ],
          ),
    );
  }

  /// Shows a custom dialog
  static Future<T?> showCustom<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }

  /// Shows a loading dialog
  static Future<void> showLoading(
    BuildContext context, {
    String message = '読み込み中...',
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _LoadingDialog(message: message),
    );
  }

  /// Hides any visible loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}

/// Internal alert dialog widget
class _AppAlertDialog extends StatelessWidget {
  const _AppAlertDialog({
    required this.title,
    required this.message,
    required this.actions,
    this.icon,
  });

  final String title;
  final String message;
  final List<DialogAction> actions;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(height: 16)],
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textMain,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSub,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions:
          actions.map((action) => _buildActionButton(context, action)).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, DialogAction action) {
    if (action.isPrimary) {
      return FilledButton(
        onPressed: action.onPressed,
        style: FilledButton.styleFrom(
          backgroundColor:
              action.isDestructive ? AppColors.error : AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(action.label),
      );
    } else {
      return TextButton(
        onPressed: action.onPressed,
        style: TextButton.styleFrom(
          foregroundColor:
              action.isDestructive ? AppColors.error : AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(action.label),
      );
    }
  }
}

/// Internal loading dialog widget
class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMain),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
