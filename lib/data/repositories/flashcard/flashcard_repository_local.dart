import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/result.dart';
import '../../../domain/models/flashcard/flashcard.dart';
import 'flashcard_repository.dart';

/// Local implementation of FlashcardRepository using SharedPreferences
class FlashcardRepositoryLocal implements FlashcardRepository {
  FlashcardRepositoryLocal(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<Result<List<Flashcard>>> getUserFlashcards(String userId) {
    return getCachedFlashcards(userId);
  }

  @override
  Future<Result<List<Flashcard>>> getCachedFlashcards(String userId) async {
    try {
      final cacheKey = _getFlashcardCacheKey(userId);
      final flashcardsJson = _preferences.getString(cacheKey);

      if (flashcardsJson == null) {
        return const Ok([]);
      }

      final flashcardsList = jsonDecode(flashcardsJson) as List;
      final flashcards =
          flashcardsList
              .map((data) => Flashcard.fromJson(data as Map<String, dynamic>))
              .toList();

      return Ok(flashcards);
    } on Exception catch (e) {
      return Error(StorageException('キャッシュされたフラッシュカードデータの読み込みに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> cacheFlashcards(
    String userId,
    List<Flashcard> flashcards,
  ) async {
    try {
      final cacheKey = _getFlashcardCacheKey(userId);
      final flashcardsJson = jsonEncode(
        flashcards.map((flashcard) => flashcard.toJson()).toList(),
      );

      await _preferences.setString(cacheKey, flashcardsJson);
      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('フラッシュカードデータのキャッシュに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> clearCachedFlashcards(String userId) async {
    try {
      final cacheKey = _getFlashcardCacheKey(userId);
      await _preferences.remove(cacheKey);
      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('キャッシュされたフラッシュカードデータの削除に失敗しました: $e'));
    }
  }

  /// Generate cache key for user's flashcards
  String _getFlashcardCacheKey(String userId) => 'flashcards_$userId';
}
