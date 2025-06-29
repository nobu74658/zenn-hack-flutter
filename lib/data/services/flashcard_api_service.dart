import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gen_flash_english_study/core/constants/app_config.dart';
import 'package:http/http.dart' as http;

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
      final response = await http.get(
        Uri.parse(
          '${AppConfig.environment.baseUrl}/flashcard/$userId',
        ),
      );

      debugPrint('Fetching flashcards: $response');
      final flashcardsResponse = FlashcardListResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      return Ok(flashcardsResponse.flashcards);
    } on AppException catch (e) {
      debugPrint('Error fetching flashcards: ${e.message}');
      return Error(e);
    } on Exception catch (e) {
      debugPrint('Unexpected error fetching flashcards: $e');
      return Error(ApiException('フラッシュカード取得時に予期しないエラーが発生しました: $e'));
    }
  }
}
