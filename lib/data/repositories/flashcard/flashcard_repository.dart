import '../../../core/utils/result.dart';
import '../../../domain/models/flashcard/flashcard.dart';

/// Abstract repository interface for flashcard operations (read-only)
abstract class FlashcardRepository {
  /// Get user's flashcards
  Future<Result<List<Flashcard>>> getUserFlashcards(String userId);

  /// Get cached flashcards locally
  Future<Result<List<Flashcard>>> getCachedFlashcards(String userId);

  /// Cache flashcards locally
  Future<Result<void>> cacheFlashcards(
    String userId,
    List<Flashcard> flashcards,
  );

  /// Clear cached flashcards
  Future<Result<void>> clearCachedFlashcards(String userId);
}
