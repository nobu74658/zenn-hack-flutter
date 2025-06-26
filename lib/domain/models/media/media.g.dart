// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaImpl _$$MediaImplFromJson(Map<String, dynamic> json) => _$MediaImpl(
  mediaId: json['mediaId'] as String,
  meaningId: json['meaningId'] as String,
  mediaUrls:
      (json['mediaUrls'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$$MediaImplToJson(_$MediaImpl instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'meaningId': instance.meaningId,
      'mediaUrls': instance.mediaUrls,
    };
