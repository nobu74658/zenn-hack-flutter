import 'package:freezed_annotation/freezed_annotation.dart';

import '../meaning/meaning.dart';
import '../media/media.dart';
import '../word/word.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

/// Flashcard domain entity - aligned with frontend type
@freezed
class Flashcard with _$Flashcard {
  const factory Flashcard({
    /// Unique flashcard identifier
    required String flashcardId,

    /// Word object
    required Word word,

    /// List of meanings
    required List<Meaning> meanings,

    /// Media object (optional for API responses)
    Media? media,

    /// Version number (defaults to 1)
    @Default(1) int version,

    /// User memo (defaults to empty string)
    @Default('') String memo,

    /// Whether the user has mastered this card (defaults to false)
    @Default(false) bool checkFlag,

    /// Creation timestamp (defaults to current time)
    DateTime? createdAt,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, Object?> json) =>
      _$FlashcardFromJson(json);
}


/// Response containing flashcards for a user
@freezed
class FlashcardListResponse with _$FlashcardListResponse {
  const factory FlashcardListResponse({
    /// Success message
    required String message,

    /// List of flashcards
    required List<Flashcard> flashcards,
  }) = _FlashcardListResponse;

  factory FlashcardListResponse.fromJson(Map<String, Object?> json) {
    final flashcardsJson = json['flashcards'] as List<dynamic>? ?? [];
    return FlashcardListResponse(
      message: json['message'] as String? ?? '',
      flashcards: flashcardsJson
          .map((e) => Flashcard.fromJson(e as Map<String, Object?>))
          .toList(),
    );
  }
}
