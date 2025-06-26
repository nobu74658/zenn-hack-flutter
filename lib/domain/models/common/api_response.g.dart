// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  message: json['message'] as String,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error: json['error'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': instance.error,
  'statusCode': instance.statusCode,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$UserResponseImpl _$$UserResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserResponseImpl(
      message: json['message'] as String,
      user: json['user'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$UserResponseImplToJson(_$UserResponseImpl instance) =>
    <String, dynamic>{'message': instance.message, 'user': instance.user};

_$FlashcardsResponseImpl _$$FlashcardsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FlashcardsResponseImpl(
  message: json['message'] as String,
  flashcards:
      (json['flashcards'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
);

Map<String, dynamic> _$$FlashcardsResponseImplToJson(
  _$FlashcardsResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'flashcards': instance.flashcards,
};

_$SuccessResponseImpl _$$SuccessResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SuccessResponseImpl(
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$SuccessResponseImplToJson(
  _$SuccessResponseImpl instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};
