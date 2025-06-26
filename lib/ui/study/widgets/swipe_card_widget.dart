import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/common/enums.dart';
import '../../../domain/models/flashcard/flashcard.dart';
import 'flashcard_widget.dart';
import 'swipe_feedback_overlay.dart';

/// Swipeable card widget with gesture detection and animations
class SwipeCardWidget extends HookConsumerWidget {
  const SwipeCardWidget({
    super.key,
    required this.flashcard,
    required this.isFlipped,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onTap,
    this.stackOffset = 0.0,
    this.isTopCard = true,
  });

  /// The flashcard to display
  final Flashcard flashcard;

  /// Whether the card is flipped to show meaning
  final bool isFlipped;

  /// Callback for left swipe (not learned)
  final VoidCallback onSwipeLeft;

  /// Callback for right swipe (learned)
  final VoidCallback onSwipeRight;

  /// Callback for tap (flip card)
  final VoidCallback onTap;

  /// Offset for stacked cards behind this one
  final double stackOffset;

  /// Whether this is the top interactive card
  final bool isTopCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    // Animation controllers
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final flipController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    // Animation values
    final dragOffset = useState(Offset.zero);
    final isDragging = useState(false);
    final swipeDirection = useState<SwipeDirection?>(null);

    // Flip animation
    final flipAnimation = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: flipController, curve: Curves.easeInOut),
      ),
    );

    // Update flip animation when isFlipped changes
    useEffect(() {
      if (isFlipped) {
        flipController.forward();
      } else {
        flipController.reverse();
      }
      return null;
    }, [isFlipped]);

    // Card dimensions
    final cardWidth = screenSize.width * 0.85;
    final cardHeight = screenSize.height * 0.70;

    // Calculate transform values
    final rotation = dragOffset.value.dx / screenSize.width * 0.3;
    final scale = 1.0 - (stackOffset * 0.05);
    final opacity = 1.0 - (stackOffset * 0.3);

    // Determine swipe feedback
    final swipeFeedbackOpacity = math.min(
      dragOffset.value.distance / (screenSize.width * 0.3),
      1,
    );

    SwipeDirection? currentSwipeDirection;
    if (dragOffset.value.dx.abs() > 50) {
      currentSwipeDirection =
          dragOffset.value.dx > 0 ? SwipeDirection.right : SwipeDirection.left;
    }

    return Transform.scale(
      scale: scale,
      child: Transform.translate(
        offset: Offset(
          dragOffset.value.dx + (stackOffset * 8),
          dragOffset.value.dy + (stackOffset * 4),
        ),
        child: Transform.rotate(
          angle: rotation,
          child: Opacity(
            opacity: opacity,
            child: GestureDetector(
              onTap: isTopCard ? onTap : null,
              onPanStart:
                  isTopCard
                      ? (details) {
                        isDragging.value = true;
                        animationController.stop();
                      }
                      : null,
              onPanUpdate:
                  isTopCard
                      ? (details) {
                        dragOffset.value += details.delta;
                        swipeDirection.value = currentSwipeDirection;
                      }
                      : null,
              onPanEnd:
                  isTopCard
                      ? (details) {
                        isDragging.value = false;

                        // Determine if swipe threshold is met
                        final swipeThreshold = screenSize.width * 0.25;

                        if (dragOffset.value.dx.abs() > swipeThreshold) {
                          // Complete swipe animation
                          final targetX =
                              dragOffset.value.dx > 0
                                  ? screenSize.width
                                  : -screenSize.width;

                          animationController.reset();
                          final animation = Tween<Offset>(
                            begin: dragOffset.value,
                            end: Offset(targetX, dragOffset.value.dy),
                          ).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Curves.easeOut,
                            ),
                          );

                          animation.addListener(() {
                            dragOffset.value = animation.value;
                          });

                          animationController.forward().then((_) {
                            // Reset position and trigger callback
                            dragOffset.value = Offset.zero;
                            swipeDirection.value = null;

                            if (targetX > 0) {
                              onSwipeRight();
                            } else {
                              onSwipeLeft();
                            }
                          });
                        } else {
                          // Return to center
                          animationController.reset();
                          final returnAnimation = Tween<Offset>(
                            begin: dragOffset.value,
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Curves.elasticOut,
                            ),
                          );

                          returnAnimation.addListener(() {
                            dragOffset.value = returnAnimation.value;
                          });

                          animationController.forward().then((_) {
                            swipeDirection.value = null;
                          });
                        }
                      }
                      : null,
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: Stack(
                  children: [
                    // Main card content
                    FlashcardWidget(
                      flashcard: flashcard,
                      isFlipped: isFlipped,
                      flipAnimation: flipAnimation,
                    ),

                    // Swipe feedback overlay
                    if (isTopCard && currentSwipeDirection != null)
                      SwipeFeedbackOverlay(
                        direction: currentSwipeDirection,
                        opacity: swipeFeedbackOpacity.toDouble(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
