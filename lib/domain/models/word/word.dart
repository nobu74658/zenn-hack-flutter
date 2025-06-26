import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

/// Word domain entity representing an English word
@freezed
class Word with _$Word {
  const factory Word({
    /// Unique word identifier
    required String wordId,

    /// The English word
    required String word,

    /// Core meaning summary
    required String coreMeaning,

    /// Detailed explanation
    required String explanation,
  }) = _Word;

  factory Word.fromJson(Map<String, Object?> json) => _$WordFromJson(json);
}
