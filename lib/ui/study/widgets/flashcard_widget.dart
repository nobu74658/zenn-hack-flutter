import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../domain/models/common/enums.dart';
import '../../../domain/models/flashcard/flashcard.dart';

/// Widget that displays flashcard content (front and back)
class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.isFlipped,
    required this.flipAnimation,
  });

  /// The flashcard to display
  final Flashcard flashcard;

  /// Whether the card is showing the back (meaning) side
  final bool isFlipped;

  /// Animation value for card flip (0.0 = front, 1.0 = back)
  final double flipAnimation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine which side to show based on flip animation
    final showBack = flipAnimation >= 0.5;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedBuilder(
          animation: AlwaysStoppedAnimation(flipAnimation),
          builder: (context, child) {
            // Apply 3D flip transform
            return Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(flipAnimation * 3.14159),
              child:
                  showBack
                      ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(3.14159),
                        child: _buildBackSide(context, theme),
                      )
                      : _buildFrontSide(context, theme),
            );
          },
        ),
      ),
    );
  }

  /// Build the front side of the card (word + image)
  Widget _buildFrontSide(BuildContext context, ThemeData theme) {
    final primaryMeaning =
        flashcard.meanings.isNotEmpty ? flashcard.meanings.first : null;
    final imageUrl =
        flashcard.media.mediaUrls.isNotEmpty
            ? flashcard.media.mediaUrls.first
            : null;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          // Image section (top 60%)
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child:
                  imageUrl != null
                      ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 48,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                      )
                      : Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
            ),
          ),

          // Content section (bottom 40%)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Part of speech tag
                  if (primaryMeaning?.pos != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.getPartOfSpeechColor(
                          primaryMeaning!.pos.name,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        primaryMeaning.pos.displayName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // English word
                  Text(
                    flashcard.word.word,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Core meaning
                  Text(
                    flashcard.word.coreMeaning,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the back side of the card (detailed meaning)
  Widget _buildBackSide(BuildContext context, ThemeData theme) {
    final primaryMeaning =
        flashcard.meanings.isNotEmpty ? flashcard.meanings.first : null;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with word and part of speech
          Row(
            children: [
              Expanded(
                child: Text(
                  flashcard.word.word,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (primaryMeaning?.pos != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.getPartOfSpeechColor(
                      primaryMeaning!.pos.name,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    primaryMeaning.pos.displayName,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // Pronunciation
          if (primaryMeaning?.pronunciation.isNotEmpty == true)
            _buildSection(context, '発音', primaryMeaning!.pronunciation, theme),

          // Translation
          if (primaryMeaning?.translation.isNotEmpty == true)
            _buildSection(context, '意味', primaryMeaning!.translation, theme),

          // Example sentence
          if (primaryMeaning?.exampleEng.isNotEmpty == true)
            _buildSection(
              context,
              '例文',
              '${primaryMeaning!.exampleEng}\n${primaryMeaning.exampleJpn}',
              theme,
            ),

          const Spacer(),

          // Flip hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_outlined,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'タップして表に戻る',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build a content section with title and content
  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
