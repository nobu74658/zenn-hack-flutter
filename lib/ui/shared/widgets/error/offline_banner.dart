import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/connectivity_service.dart';

/// Banner widget that shows when device is offline
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({
    super.key,
    required this.child,
    this.showWhenOnline = false,
  });

  final Widget child;
  final bool showWhenOnline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);

    return connectivityStatus.when(
      data: (status) => _buildWithStatus(context, status),
      loading: () => child, // Don't show banner while loading
      error: (_, _) => child, // Don't show banner on error
    );
  }

  Widget _buildWithStatus(BuildContext context, ConnectivityStatus status) {
    final isOffline = status == ConnectivityStatus.disconnected;
    final isOnline = status == ConnectivityStatus.connected;

    // Show banner when offline, or when explicitly requested
    // to show when online
    final shouldShowBanner = isOffline || (showWhenOnline && isOnline);

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: shouldShowBanner ? 32 : 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                shouldShowBanner
                    ? _buildBanner(context, isOnline)
                    : const SizedBox.shrink(),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildBanner(BuildContext context, bool isOnline) {
    return Container(
      key: ValueKey(isOnline),
      width: double.infinity,
      height: 32,
      color: isOnline ? const Color(0xFF4CAF50) : AppColors.error,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isOnline ? Icons.wifi : Icons.wifi_off,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              isOnline ? 'オンラインに戻りました' : 'オフライン - インターネット接続を確認してください',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating offline indicator that shows as a card
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          isOnline
              ? const SizedBox.shrink()
              : Container(
                key: const ValueKey('offline'),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'オフライン',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

/// Connectivity wrapper that shows offline state for the entire content
class ConnectivityWrapper extends ConsumerWidget {
  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.offlineChild,
  });

  final Widget child;
  final Widget? offlineChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    if (!isOnline && offlineChild != null) {
      return offlineChild!;
    }

    return child;
  }
}

/// Default offline page widget
class DefaultOfflinePage extends StatelessWidget {
  const DefaultOfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wifi_off,
                  size: 64,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'オフライン',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'インターネット接続を確認してください',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSub,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  // In a real app, you might want to check connectivity here
                  // and show a loading state
                },
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
