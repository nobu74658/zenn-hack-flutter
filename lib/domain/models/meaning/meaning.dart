import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/enums.dart';

part 'meaning.freezed.dart';
part 'meaning.g.dart';

/// Meaning domain entity representing a word definition
@freezed
class Meaning with _$Meaning {
  const factory Meaning({
    /// Unique meaning identifier
    required String meaningId,

    /// Part of speech - type-safe enum
    required PartOfSpeech pos,

    /// Japanese translation
    required String translation,

    /// Pronunciation guide
    required String pronunciation,

    /// English example sentence
    required String exampleEng,

    /// Japanese example sentence
    required String exampleJpn,
  }) = _Meaning;

  factory Meaning.fromJson(Map<String, Object?> json) =>
      _$MeaningFromJson(json);
}


/// Response containing multiple meanings for a word
@freezed
class MeaningsResponse with _$MeaningsResponse {
  const factory MeaningsResponse({
    /// Success message
    required String message,

    /// List of meanings for the word
    required List<Meaning> meanings,
  }) = _MeaningsResponse;

  factory MeaningsResponse.fromJson(Map<String, Object?> json) {
    final meaningsJson = json['meanings'] as List<dynamic>? ?? [];
    return MeaningsResponse(
      message: json['message'] as String? ?? '',
      meanings: meaningsJson
          .map((e) => Meaning.fromJson(e as Map<String, Object?>))
          .toList(),
    );
  }
}
