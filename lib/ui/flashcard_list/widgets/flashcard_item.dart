import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gen_flash_english_study/domain/models/flashcard/flashcard.dart';
import '../../../domain/models/common/enums.dart';

class FlashcardItem extends StatelessWidget {
  const FlashcardItem({super.key, required this.flashcard});

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: flashcard.media?.mediaUrls.isNotEmpty == true
                ? CachedNetworkImage(
                    imageUrl: flashcard.media!.mediaUrls.first,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  )
                : const Center(
                    child: Icon(Icons.image_not_supported, size: 48),
                  ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (flashcard.meanings.isNotEmpty)
                    Chip(
                      label: Text(flashcard.meanings.first.pos.displayName),
                      padding: EdgeInsets.zero,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    flashcard.word.word,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  if (flashcard.meanings.isNotEmpty)
                    Text(
                      flashcard.meanings.first.translation,
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
}
