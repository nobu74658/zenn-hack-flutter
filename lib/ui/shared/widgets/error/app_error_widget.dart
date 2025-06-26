import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/error/app_error.dart';
import '../buttons/app_button.dart';

/// Widget for displaying different types of errors with appropriate UI
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.onGoBack,
    this.showIcon = true,
    this.compact = false,
  });

  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback? onGoBack;
  final bool showIcon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _buildCompactError(context);
    }

    return _buildFullError(context);
  }

  Widget _buildCompactError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getBackgroundColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getBackgroundColor().withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          if (showIcon) ...[
            Icon(_getIcon(), color: _getIconColor(), size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              error.displayMessage,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMain),
            ),
          ),
          if (error.isRetryable && onRetry != null) ...[
            const SizedBox(width: 12),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: _getIconColor(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('再試行'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFullError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getBackgroundColor().withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(_getIcon(), size: 48, color: _getIconColor()),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              _getTitle(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              error.displayMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSub,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final actions = <Widget>[];

    if (error.isRetryable && onRetry != null) {
      actions.add(
        AppButton(text: '再試行', onPressed: onRetry, fullWidth: actions.isEmpty),
      );
    }

    if (onGoBack != null) {
      actions.add(
        AppButton(
          text: '戻る',
          onPressed: onGoBack,
          variant:
              actions.isEmpty
                  ? AppButtonVariant.primary
                  : AppButtonVariant.outlined,
          fullWidth: actions.isEmpty,
        ),
      );
    }

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    if (actions.length == 1) {
      return actions.first;
    }

    return Column(
      children: [actions.first, const SizedBox(height: 12), actions.last],
    );
  }

  IconData _getIcon() {
    switch (error.type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.error_outline;
      case ErrorType.validation:
        return Icons.warning_outlined;
      case ErrorType.notFound:
        return Icons.search_off;
      case ErrorType.permission:
        return Icons.lock_outlined;
      case ErrorType.unknown:
        return Icons.help_outline;
    }
  }

  Color _getIconColor() {
    switch (error.type) {
      case ErrorType.network:
        return const Color(0xFFFF9800); // Orange
      case ErrorType.server:
        return AppColors.error;
      case ErrorType.validation:
        return const Color(0xFFFF9800); // Orange
      case ErrorType.notFound:
        return AppColors.textSub;
      case ErrorType.permission:
        return AppColors.error;
      case ErrorType.unknown:
        return AppColors.textSub;
    }
  }

  Color _getBackgroundColor() {
    switch (error.type) {
      case ErrorType.network:
        return const Color(0xFFFF9800); // Orange
      case ErrorType.server:
        return AppColors.error;
      case ErrorType.validation:
        return const Color(0xFFFF9800); // Orange
      case ErrorType.notFound:
        return AppColors.textSub;
      case ErrorType.permission:
        return AppColors.error;
      case ErrorType.unknown:
        return AppColors.textSub;
    }
  }

  String _getTitle() {
    switch (error.type) {
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
        return 'エラーが発生しました';
    }
  }
}

/// Specialized error widget for network connectivity issues
class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key, this.onRetry, this.message});

  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      error: AppErrorFactory.network(
        'Network connection failed',
        userMessage: message ?? 'インターネット接続を確認してください',
      ),
      onRetry: onRetry,
    );
  }
}

/// Specialized error widget for server errors
class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({super.key, this.onRetry, this.message});

  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      error: AppErrorFactory.server(
        'Server error occurred',
        userMessage: message ?? 'サーバーで問題が発生しました。しばらく後に再試行してください',
      ),
      onRetry: onRetry,
    );
  }
}

/// Specialized error widget for not found errors
class NotFoundErrorWidget extends StatelessWidget {
  const NotFoundErrorWidget({super.key, this.onGoBack, this.message});

  final VoidCallback? onGoBack;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      error: AppErrorFactory.notFound(
        'Data not found',
        userMessage: message ?? 'データが見つかりませんでした',
      ),
      onGoBack: onGoBack,
    );
  }
}
