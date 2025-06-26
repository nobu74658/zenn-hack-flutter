// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlashcardImpl _$$FlashcardImplFromJson(Map<String, dynamic> json) =>
    _$FlashcardImpl(
      flashcardId: json['flashcardId'] as String,
      word: Word.fromJson(json['word'] as Map<String, dynamic>),
      meanings:
          (json['meanings'] as List<dynamic>)
              .map((e) => Meaning.fromJson(e as Map<String, dynamic>))
              .toList(),
      media: Media.fromJson(json['media'] as Map<String, dynamic>),
      version: (json['version'] as num).toInt(),
      memo: json['memo'] as String,
      checkFlag: json['checkFlag'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FlashcardImplToJson(_$FlashcardImpl instance) =>
    <String, dynamic>{
      'flashcardId': instance.flashcardId,
      'word': instance.word,
      'meanings': instance.meanings,
      'media': instance.media,
      'version': instance.version,
      'memo': instance.memo,
      'checkFlag': instance.checkFlag,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$FlashcardListResponseImpl _$$FlashcardListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FlashcardListResponseImpl(
  message: json['message'] as String,
  flashcards:
      (json['flashcards'] as List<dynamic>)
          .map((e) => Flashcard.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$FlashcardListResponseImplToJson(
  _$FlashcardListResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'flashcards': instance.flashcards,
};
