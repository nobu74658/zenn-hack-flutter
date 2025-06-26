// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppErrorImpl _$$AppErrorImplFromJson(Map<String, dynamic> json) =>
    _$AppErrorImpl(
      type: $enumDecode(_$ErrorTypeEnumMap, json['type']),
      message: json['message'] as String,
      userMessage: json['userMessage'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      code: json['code'] as String?,
      context: json['context'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AppErrorImplToJson(_$AppErrorImpl instance) =>
    <String, dynamic>{
      'type': _$ErrorTypeEnumMap[instance.type]!,
      'message': instance.message,
      'userMessage': instance.userMessage,
      'statusCode': instance.statusCode,
      'code': instance.code,
      'context': instance.context,
    };

const _$ErrorTypeEnumMap = {
  ErrorType.network: 'network',
  ErrorType.server: 'server',
  ErrorType.validation: 'validation',
  ErrorType.notFound: 'notFound',
  ErrorType.permission: 'permission',
  ErrorType.unknown: 'unknown',
};
