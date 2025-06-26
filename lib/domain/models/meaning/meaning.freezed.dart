// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meaning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Meaning _$MeaningFromJson(Map<String, dynamic> json) {
  return _Meaning.fromJson(json);
}

/// @nodoc
mixin _$Meaning {
  /// Unique meaning identifier
  String get meaningId => throw _privateConstructorUsedError;

  /// Part of speech - type-safe enum
  PartOfSpeech get pos => throw _privateConstructorUsedError;

  /// Japanese translation
  String get translation => throw _privateConstructorUsedError;

  /// Pronunciation guide
  String get pronunciation => throw _privateConstructorUsedError;

  /// English example sentence
  String get exampleEng => throw _privateConstructorUsedError;

  /// Japanese example sentence
  String get exampleJpn => throw _privateConstructorUsedError;

  /// Serializes this Meaning to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meaning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeaningCopyWith<Meaning> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeaningCopyWith<$Res> {
  factory $MeaningCopyWith(Meaning value, $Res Function(Meaning) then) =
      _$MeaningCopyWithImpl<$Res, Meaning>;
  @useResult
  $Res call({
    String meaningId,
    PartOfSpeech pos,
    String translation,
    String pronunciation,
    String exampleEng,
    String exampleJpn,
  });
}

/// @nodoc
class _$MeaningCopyWithImpl<$Res, $Val extends Meaning>
    implements $MeaningCopyWith<$Res> {
  _$MeaningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meaning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meaningId = null,
    Object? pos = null,
    Object? translation = null,
    Object? pronunciation = null,
    Object? exampleEng = null,
    Object? exampleJpn = null,
  }) {
    return _then(
      _value.copyWith(
            meaningId:
                null == meaningId
                    ? _value.meaningId
                    : meaningId // ignore: cast_nullable_to_non_nullable
                        as String,
            pos:
                null == pos
                    ? _value.pos
                    : pos // ignore: cast_nullable_to_non_nullable
                        as PartOfSpeech,
            translation:
                null == translation
                    ? _value.translation
                    : translation // ignore: cast_nullable_to_non_nullable
                        as String,
            pronunciation:
                null == pronunciation
                    ? _value.pronunciation
                    : pronunciation // ignore: cast_nullable_to_non_nullable
                        as String,
            exampleEng:
                null == exampleEng
                    ? _value.exampleEng
                    : exampleEng // ignore: cast_nullable_to_non_nullable
                        as String,
            exampleJpn:
                null == exampleJpn
                    ? _value.exampleJpn
                    : exampleJpn // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeaningImplCopyWith<$Res> implements $MeaningCopyWith<$Res> {
  factory _$$MeaningImplCopyWith(
    _$MeaningImpl value,
    $Res Function(_$MeaningImpl) then,
  ) = __$$MeaningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String meaningId,
    PartOfSpeech pos,
    String translation,
    String pronunciation,
    String exampleEng,
    String exampleJpn,
  });
}

/// @nodoc
class __$$MeaningImplCopyWithImpl<$Res>
    extends _$MeaningCopyWithImpl<$Res, _$MeaningImpl>
    implements _$$MeaningImplCopyWith<$Res> {
  __$$MeaningImplCopyWithImpl(
    _$MeaningImpl _value,
    $Res Function(_$MeaningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Meaning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meaningId = null,
    Object? pos = null,
    Object? translation = null,
    Object? pronunciation = null,
    Object? exampleEng = null,
    Object? exampleJpn = null,
  }) {
    return _then(
      _$MeaningImpl(
        meaningId:
            null == meaningId
                ? _value.meaningId
                : meaningId // ignore: cast_nullable_to_non_nullable
                    as String,
        pos:
            null == pos
                ? _value.pos
                : pos // ignore: cast_nullable_to_non_nullable
                    as PartOfSpeech,
        translation:
            null == translation
                ? _value.translation
                : translation // ignore: cast_nullable_to_non_nullable
                    as String,
        pronunciation:
            null == pronunciation
                ? _value.pronunciation
                : pronunciation // ignore: cast_nullable_to_non_nullable
                    as String,
        exampleEng:
            null == exampleEng
                ? _value.exampleEng
                : exampleEng // ignore: cast_nullable_to_non_nullable
                    as String,
        exampleJpn:
            null == exampleJpn
                ? _value.exampleJpn
                : exampleJpn // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MeaningImpl implements _Meaning {
  const _$MeaningImpl({
    required this.meaningId,
    required this.pos,
    required this.translation,
    required this.pronunciation,
    required this.exampleEng,
    required this.exampleJpn,
  });

  factory _$MeaningImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeaningImplFromJson(json);

  /// Unique meaning identifier
  @override
  final String meaningId;

  /// Part of speech - type-safe enum
  @override
  final PartOfSpeech pos;

  /// Japanese translation
  @override
  final String translation;

  /// Pronunciation guide
  @override
  final String pronunciation;

  /// English example sentence
  @override
  final String exampleEng;

  /// Japanese example sentence
  @override
  final String exampleJpn;

  @override
  String toString() {
    return 'Meaning(meaningId: $meaningId, pos: $pos, translation: $translation, pronunciation: $pronunciation, exampleEng: $exampleEng, exampleJpn: $exampleJpn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeaningImpl &&
            (identical(other.meaningId, meaningId) ||
                other.meaningId == meaningId) &&
            (identical(other.pos, pos) || other.pos == pos) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.exampleEng, exampleEng) ||
                other.exampleEng == exampleEng) &&
            (identical(other.exampleJpn, exampleJpn) ||
                other.exampleJpn == exampleJpn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meaningId,
    pos,
    translation,
    pronunciation,
    exampleEng,
    exampleJpn,
  );

  /// Create a copy of Meaning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeaningImplCopyWith<_$MeaningImpl> get copyWith =>
      __$$MeaningImplCopyWithImpl<_$MeaningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeaningImplToJson(this);
  }
}

abstract class _Meaning implements Meaning {
  const factory _Meaning({
    required final String meaningId,
    required final PartOfSpeech pos,
    required final String translation,
    required final String pronunciation,
    required final String exampleEng,
    required final String exampleJpn,
  }) = _$MeaningImpl;

  factory _Meaning.fromJson(Map<String, dynamic> json) = _$MeaningImpl.fromJson;

  /// Unique meaning identifier
  @override
  String get meaningId;

  /// Part of speech - type-safe enum
  @override
  PartOfSpeech get pos;

  /// Japanese translation
  @override
  String get translation;

  /// Pronunciation guide
  @override
  String get pronunciation;

  /// English example sentence
  @override
  String get exampleEng;

  /// Japanese example sentence
  @override
  String get exampleJpn;

  /// Create a copy of Meaning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeaningImplCopyWith<_$MeaningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeaningsResponse _$MeaningsResponseFromJson(Map<String, dynamic> json) {
  return _MeaningsResponse.fromJson(json);
}

/// @nodoc
mixin _$MeaningsResponse {
  /// Success message
  String get message => throw _privateConstructorUsedError;

  /// List of meanings for the word
  List<Meaning> get meanings => throw _privateConstructorUsedError;

  /// Serializes this MeaningsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeaningsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeaningsResponseCopyWith<MeaningsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeaningsResponseCopyWith<$Res> {
  factory $MeaningsResponseCopyWith(
    MeaningsResponse value,
    $Res Function(MeaningsResponse) then,
  ) = _$MeaningsResponseCopyWithImpl<$Res, MeaningsResponse>;
  @useResult
  $Res call({String message, List<Meaning> meanings});
}

/// @nodoc
class _$MeaningsResponseCopyWithImpl<$Res, $Val extends MeaningsResponse>
    implements $MeaningsResponseCopyWith<$Res> {
  _$MeaningsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeaningsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? meanings = null}) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            meanings:
                null == meanings
                    ? _value.meanings
                    : meanings // ignore: cast_nullable_to_non_nullable
                        as List<Meaning>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeaningsResponseImplCopyWith<$Res>
    implements $MeaningsResponseCopyWith<$Res> {
  factory _$$MeaningsResponseImplCopyWith(
    _$MeaningsResponseImpl value,
    $Res Function(_$MeaningsResponseImpl) then,
  ) = __$$MeaningsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, List<Meaning> meanings});
}

/// @nodoc
class __$$MeaningsResponseImplCopyWithImpl<$Res>
    extends _$MeaningsResponseCopyWithImpl<$Res, _$MeaningsResponseImpl>
    implements _$$MeaningsResponseImplCopyWith<$Res> {
  __$$MeaningsResponseImplCopyWithImpl(
    _$MeaningsResponseImpl _value,
    $Res Function(_$MeaningsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeaningsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? meanings = null}) {
    return _then(
      _$MeaningsResponseImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        meanings:
            null == meanings
                ? _value._meanings
                : meanings // ignore: cast_nullable_to_non_nullable
                    as List<Meaning>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MeaningsResponseImpl implements _MeaningsResponse {
  const _$MeaningsResponseImpl({
    required this.message,
    required final List<Meaning> meanings,
  }) : _meanings = meanings;

  factory _$MeaningsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeaningsResponseImplFromJson(json);

  /// Success message
  @override
  final String message;

  /// List of meanings for the word
  final List<Meaning> _meanings;

  /// List of meanings for the word
  @override
  List<Meaning> get meanings {
    if (_meanings is EqualUnmodifiableListView) return _meanings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meanings);
  }

  @override
  String toString() {
    return 'MeaningsResponse(message: $message, meanings: $meanings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeaningsResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._meanings, _meanings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_meanings),
  );

  /// Create a copy of MeaningsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeaningsResponseImplCopyWith<_$MeaningsResponseImpl> get copyWith =>
      __$$MeaningsResponseImplCopyWithImpl<_$MeaningsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MeaningsResponseImplToJson(this);
  }
}

abstract class _MeaningsResponse implements MeaningsResponse {
  const factory _MeaningsResponse({
    required final String message,
    required final List<Meaning> meanings,
  }) = _$MeaningsResponseImpl;

  factory _MeaningsResponse.fromJson(Map<String, dynamic> json) =
      _$MeaningsResponseImpl.fromJson;

  /// Success message
  @override
  String get message;

  /// List of meanings for the word
  @override
  List<Meaning> get meanings;

  /// Create a copy of MeaningsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeaningsResponseImplCopyWith<_$MeaningsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
