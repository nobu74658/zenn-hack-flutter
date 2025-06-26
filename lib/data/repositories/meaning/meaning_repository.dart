import '../../../core/utils/result.dart';
import '../../../domain/models/meaning/meaning.dart';

/// Abstract repository interface for meaning operations
abstract class MeaningRepository {
  /// Get all meanings for a word
  Future<Result<List<Meaning>>> getWordMeanings(String wordId);

  /// Get cached meanings locally
  Future<Result<List<Meaning>>> getCachedMeanings(String wordId);

  /// Cache meanings locally
  Future<Result<void>> cacheMeanings(String wordId, List<Meaning> meanings);

  /// Clear cached meanings
  Future<Result<void>> clearCachedMeanings(String wordId);
}
