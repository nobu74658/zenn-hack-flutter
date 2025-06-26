import '../../core/constants/api_endpoints.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/models/flashcard/flashcard.dart';
import 'http_client.dart';

/// Flashcard API service for handling flashcard-related HTTP requests
/// (read-only)
class FlashcardApiService {
  FlashcardApiService(this._httpClient);

  final HttpClient _httpClient;

  /// Get user's flashcards
  Future<Result<List<Flashcard>>> getUserFlashcards(String userId) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        ApiEndpoints.flashcardByUserId(userId),
      );

      if (response.data == null) {
        return const Error(ApiException('フラッシュカードデータの取得に失敗しました'));
      }

      final flashcardsResponse = FlashcardListResponse.fromJson(response.data!);
      return Ok(flashcardsResponse.flashcards);
    } on AppException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(ApiException('フラッシュカード取得時に予期しないエラーが発生しました: $e'));
    }
  }
}
