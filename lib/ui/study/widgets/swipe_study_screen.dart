import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../shared/widgets/layout/app_scaffold.dart';
import '../notifiers/swipe_study_notifier.dart';
import 'card_stack_widget.dart';

/// Main screen for swipe-based flashcard learning
class SwipeStudyScreen extends HookConsumerWidget {
  const SwipeStudyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swipeStudyAsync = ref.watch(swipeStudyNotifierProvider);

    return AppScaffold(
      body: swipeStudyAsync.when(
        data: (state) => _buildContent(context, ref, state),
        loading: () => _buildLoading(context),
        error: (error, stackTrace) => _buildError(context, error.toString()),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    SwipeStudyState state,
  ) {
    if (state.isCompleted) {
      return _buildCompletionScreen(context, ref);
    }

    return Column(
      children: [
        // App Bar
        _buildAppBar(context, state),

        // Main content area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress indicator
                _buildProgressIndicator(context, state),

                const SizedBox(height: 20),

                // Card stack
                Expanded(
                  child: Center(
                    child: CardStackWidget(
                      currentCard: state.currentCard,
                      nextCard: state.nextCard,
                      thirdCard: state.thirdCard,
                      isCurrentCardFlipped: state.isCardFlipped,
                      onSwipeLeft: () {
                        HapticFeedback.mediumImpact();
                        ref
                            .read(swipeStudyNotifierProvider.notifier)
                            .onSwipeLeft();
                      },
                      onSwipeRight: () {
                        HapticFeedback.mediumImpact();
                        ref
                            .read(swipeStudyNotifierProvider.notifier)
                            .onSwipeRight();
                      },
                      onCardTap: () {
                        HapticFeedback.selectionClick();
                        ref
                            .read(swipeStudyNotifierProvider.notifier)
                            .flipCard();
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Bottom action panel
                _buildBottomPanel(context, ref, state),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, SwipeStudyState state) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Back button
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: theme.colorScheme.onSurface,
              ),
            ),

            // Title
            Expanded(
              child: Text(
                '暗記学習',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Menu button
            IconButton(
              onPressed: () {
                // TODO(nobu): Show menu options (settings, etc.)
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, SwipeStudyState state) {
    final theme = Theme.of(context);
    final progress =
        state.totalCards > 0 ? state.currentProgress / state.totalCards : 0.0;

    return Column(
      children: [
        // Progress text
        Text(
          '${state.currentProgress} / ${state.totalCards}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // Progress bar
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildBottomPanel(
    BuildContext context,
    WidgetRef ref,
    SwipeStudyState state,
  ) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Hint button
        _buildActionButton(
          context,
          icon: Icons.lightbulb_outline_rounded,
          label: 'ヒント',
          color: AppColors.warning,
          onPressed: () {
            HapticFeedback.selectionClick();
            ref.read(swipeStudyNotifierProvider.notifier).showHint();
          },
        ),

        // Skip button
        _buildActionButton(
          context,
          icon: Icons.skip_next_rounded,
          label: 'スキップ',
          color: theme.colorScheme.outline,
          onPressed:
              state.hasMoreCards
                  ? () {
                    HapticFeedback.lightImpact();
                    ref.read(swipeStudyNotifierProvider.notifier).skipCard();
                  }
                  : null,
        ),

        // Flip button
        _buildActionButton(
          context,
          icon: Icons.flip_rounded,
          label: 'カード裏返し',
          color: theme.colorScheme.primary,
          onPressed: () {
            HapticFeedback.selectionClick();
            ref.read(swipeStudyNotifierProvider.notifier).flipCard();
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isEnabled ? color : theme.colorScheme.outline,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isEnabled ? color : theme.colorScheme.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Celebration icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.celebration_rounded,
                size: 64,
                color: AppColors.success,
              ),
            ),

            const SizedBox(height: 24),

            // Completion message
            Text(
              '学習完了！',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '全てのカードを学習しました',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Restart button
                ElevatedButton.icon(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ref
                        .read(swipeStudyNotifierProvider.notifier)
                        .resetSession();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('もう一度'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),

                // Return button
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('ホームに戻る'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    foregroundColor: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'フラッシュカードを読み込み中...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'エラーが発生しました',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
