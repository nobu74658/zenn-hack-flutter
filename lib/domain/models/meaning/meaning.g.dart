// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meaning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeaningImpl _$$MeaningImplFromJson(Map<String, dynamic> json) =>
    _$MeaningImpl(
      meaningId: json['meaningId'] as String,
      pos: $enumDecode(_$PartOfSpeechEnumMap, json['pos']),
      translation: json['translation'] as String,
      pronunciation: json['pronunciation'] as String,
      exampleEng: json['exampleEng'] as String,
      exampleJpn: json['exampleJpn'] as String,
    );

Map<String, dynamic> _$$MeaningImplToJson(_$MeaningImpl instance) =>
    <String, dynamic>{
      'meaningId': instance.meaningId,
      'pos': _$PartOfSpeechEnumMap[instance.pos]!,
      'translation': instance.translation,
      'pronunciation': instance.pronunciation,
      'exampleEng': instance.exampleEng,
      'exampleJpn': instance.exampleJpn,
    };

const _$PartOfSpeechEnumMap = {
  PartOfSpeech.noun: 'noun',
  PartOfSpeech.pronoun: 'pronoun',
  PartOfSpeech.intransitiveVerb: 'intransitiveVerb',
  PartOfSpeech.transitiveVerb: 'transitiveVerb',
  PartOfSpeech.adjective: 'adjective',
  PartOfSpeech.adverb: 'adverb',
  PartOfSpeech.auxiliaryVerb: 'auxiliaryVerb',
  PartOfSpeech.preposition: 'preposition',
  PartOfSpeech.article: 'article',
  PartOfSpeech.interjection: 'interjection',
  PartOfSpeech.conjunction: 'conjunction',
  PartOfSpeech.idiom: 'idiom',
};

_$MeaningsResponseImpl _$$MeaningsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MeaningsResponseImpl(
  message: json['message'] as String,
  meanings:
      (json['meanings'] as List<dynamic>)
          .map((e) => Meaning.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$MeaningsResponseImplToJson(
  _$MeaningsResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'meanings': instance.meanings,
};
