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
      media:
          json['media'] == null
              ? null
              : Media.fromJson(json['media'] as Map<String, dynamic>),
      version: (json['version'] as num?)?.toInt() ?? 1,
      memo: json['memo'] as String? ?? '',
      checkFlag: json['checkFlag'] as bool? ?? false,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
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
      'createdAt': instance.createdAt?.toIso8601String(),
    };
