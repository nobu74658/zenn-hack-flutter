// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordImpl _$$WordImplFromJson(Map<String, dynamic> json) => _$WordImpl(
  wordId: json['wordId'] as String,
  word: json['word'] as String,
  coreMeaning: json['coreMeaning'] as String,
  explanation: json['explanation'] as String,
);

Map<String, dynamic> _$$WordImplToJson(_$WordImpl instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'word': instance.word,
      'coreMeaning': instance.coreMeaning,
      'explanation': instance.explanation,
    };
