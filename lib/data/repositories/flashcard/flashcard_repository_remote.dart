import 'package:flutter/material.dart';

import '../../../core/utils/result.dart';
import '../../../domain/models/flashcard/flashcard.dart';
import '../../services/flashcard_api_service.dart';
import 'flashcard_repository.dart';

/// Remote implementation of FlashcardRepository using API calls (read-only)
class FlashcardRepositoryRemote implements FlashcardRepository {
  FlashcardRepositoryRemote(this._apiService);

  final FlashcardApiService _apiService;

  @override
  Future<Result<List<Flashcard>>> getUserFlashcards(String userId) {
    debugPrint('Fetching flashcards for user: $userId');
    return _apiService.getUserFlashcards(userId);
  }

  @override
  Future<Result<List<Flashcard>>> getCachedFlashcards(String userId) async {
    // Remote repository doesn't handle caching
    return const Ok([]);
  }

  @override
  Future<Result<void>> cacheFlashcards(
    String userId,
    List<Flashcard> flashcards,
  ) async {
    // Remote repository doesn't handle caching
    return const Ok(null);
  }

  @override
  Future<Result<void>> clearCachedFlashcards(String userId) async {
    // Remote repository doesn't handle caching
    return const Ok(null);
  }
}
