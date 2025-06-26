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

    /// Media object
    required Media media,

    /// Version number
    required int version,

    /// User memo
    required String memo,

    /// Whether the user has mastered this card
    required bool checkFlag,

    /// Creation timestamp
    required DateTime createdAt,
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

  factory FlashcardListResponse.fromJson(Map<String, Object?> json) =>
      _$FlashcardListResponseFromJson(json);
}
