import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../domain/models/common/enums.dart';

/// Overlay widget that shows visual feedback during swipe gestures
class SwipeFeedbackOverlay extends StatelessWidget {
  const SwipeFeedbackOverlay({
    super.key,
    required this.direction,
    required this.opacity,
  });

  /// The swipe direction
  final SwipeDirection direction;

  /// Opacity of the feedback (0.0 to 1.0)
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    IconData icon;
    String text;

    switch (direction) {
      case SwipeDirection.right:
        backgroundColor = AppColors.swipeRightFeedback;
        icon = Icons.thumb_up_rounded;
        text = '覚えた！';
      case SwipeDirection.left:
        backgroundColor = AppColors.swipeLeftFeedback;
        icon = Icons.thumb_down_rounded;
        text = 'もう一度';
      case SwipeDirection.up:
      case SwipeDirection.down:
        backgroundColor = Colors.transparent;
        icon = Icons.help_outline;
        text = '';
    }

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: opacity * 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            opacity > 0.3
                ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 48, color: backgroundColor),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          text,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : null,
      ),
    );
  }
}
