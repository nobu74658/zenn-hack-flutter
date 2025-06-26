import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/flashcard/flashcard.dart';
import 'swipe_card_widget.dart';

/// Widget that displays a stack of flashcards with layered effect
class CardStackWidget extends HookConsumerWidget {
  const CardStackWidget({
    super.key,
    required this.currentCard,
    required this.nextCard,
    required this.thirdCard,
    required this.isCurrentCardFlipped,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onCardTap,
  });

  /// The current top card
  final Flashcard? currentCard;

  /// The next card (behind current)
  final Flashcard? nextCard;

  /// The third card (further behind)
  final Flashcard? thirdCard;

  /// Whether the current card is flipped
  final bool isCurrentCardFlipped;

  /// Callback for left swipe
  final VoidCallback onSwipeLeft;

  /// Callback for right swipe
  final VoidCallback onSwipeRight;

  /// Callback for card tap
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Third card (furthest back)
        if (thirdCard != null)
          SwipeCardWidget(
            flashcard: thirdCard!,
            isFlipped: false,
            onSwipeLeft: () {},
            onSwipeRight: () {},
            onTap: () {},
            stackOffset: 2,
            isTopCard: false,
          ),

        // Next card (middle)
        if (nextCard != null)
          SwipeCardWidget(
            flashcard: nextCard!,
            isFlipped: false,
            onSwipeLeft: () {},
            onSwipeRight: () {},
            onTap: () {},
            stackOffset: 1,
            isTopCard: false,
          ),

        // Current card (top)
        if (currentCard != null)
          SwipeCardWidget(
            flashcard: currentCard!,
            isFlipped: isCurrentCardFlipped,
            onSwipeLeft: onSwipeLeft,
            onSwipeRight: onSwipeRight,
            onTap: onCardTap,
          ),

        // Empty state when no cards available
        if (currentCard == null) const _EmptyCardStack(),
      ],
    );
  }
}

/// Widget displayed when no cards are available
class _EmptyCardStack extends StatelessWidget {
  const _EmptyCardStack();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.85,
      height: screenSize.height * 0.70,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            '学習完了！',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '全てのカードを学習しました',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
