import '../../core/constants/api_endpoints.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/models/meaning/meaning.dart';
import 'http_client.dart';

/// Meaning API service for handling meaning-related HTTP requests
class MeaningApiService {
  MeaningApiService(this._httpClient);

  final HttpClient _httpClient;

  /// Get all meanings for a word
  Future<Result<List<Meaning>>> getWordMeanings(String wordId) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        ApiEndpoints.meaningByWordId(wordId),
      );

      if (response.data == null) {
        return const Error(ApiException('単語の意味データの取得に失敗しました'));
      }

      final meaningsResponse = MeaningsResponse.fromJson(response.data!);
      return Ok(meaningsResponse.meanings);
    } on AppException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(ApiException('意味取得時に予期しないエラーが発生しました: $e'));
    }
  }
}
