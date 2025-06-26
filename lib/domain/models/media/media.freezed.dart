// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Media _$MediaFromJson(Map<String, dynamic> json) {
  return _Media.fromJson(json);
}

/// @nodoc
mixin _$Media {
  /// Unique media identifier
  String get mediaId => throw _privateConstructorUsedError;

  /// Associated meaning identifier
  String get meaningId => throw _privateConstructorUsedError;

  /// List of media URLs
  List<String> get mediaUrls => throw _privateConstructorUsedError;

  /// Serializes this Media to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaCopyWith<Media> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaCopyWith<$Res> {
  factory $MediaCopyWith(Media value, $Res Function(Media) then) =
      _$MediaCopyWithImpl<$Res, Media>;
  @useResult
  $Res call({String mediaId, String meaningId, List<String> mediaUrls});
}

/// @nodoc
class _$MediaCopyWithImpl<$Res, $Val extends Media>
    implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? meaningId = null,
    Object? mediaUrls = null,
  }) {
    return _then(
      _value.copyWith(
            mediaId:
                null == mediaId
                    ? _value.mediaId
                    : mediaId // ignore: cast_nullable_to_non_nullable
                        as String,
            meaningId:
                null == meaningId
                    ? _value.meaningId
                    : meaningId // ignore: cast_nullable_to_non_nullable
                        as String,
            mediaUrls:
                null == mediaUrls
                    ? _value.mediaUrls
                    : mediaUrls // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaImplCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$$MediaImplCopyWith(
    _$MediaImpl value,
    $Res Function(_$MediaImpl) then,
  ) = __$$MediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mediaId, String meaningId, List<String> mediaUrls});
}

/// @nodoc
class __$$MediaImplCopyWithImpl<$Res>
    extends _$MediaCopyWithImpl<$Res, _$MediaImpl>
    implements _$$MediaImplCopyWith<$Res> {
  __$$MediaImplCopyWithImpl(
    _$MediaImpl _value,
    $Res Function(_$MediaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? meaningId = null,
    Object? mediaUrls = null,
  }) {
    return _then(
      _$MediaImpl(
        mediaId:
            null == mediaId
                ? _value.mediaId
                : mediaId // ignore: cast_nullable_to_non_nullable
                    as String,
        meaningId:
            null == meaningId
                ? _value.meaningId
                : meaningId // ignore: cast_nullable_to_non_nullable
                    as String,
        mediaUrls:
            null == mediaUrls
                ? _value._mediaUrls
                : mediaUrls // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaImpl implements _Media {
  const _$MediaImpl({
    required this.mediaId,
    required this.meaningId,
    required final List<String> mediaUrls,
  }) : _mediaUrls = mediaUrls;

  factory _$MediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaImplFromJson(json);

  /// Unique media identifier
  @override
  final String mediaId;

  /// Associated meaning identifier
  @override
  final String meaningId;

  /// List of media URLs
  final List<String> _mediaUrls;

  /// List of media URLs
  @override
  List<String> get mediaUrls {
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaUrls);
  }

  @override
  String toString() {
    return 'Media(mediaId: $mediaId, meaningId: $meaningId, mediaUrls: $mediaUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaImpl &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.meaningId, meaningId) ||
                other.meaningId == meaningId) &&
            const DeepCollectionEquality().equals(
              other._mediaUrls,
              _mediaUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mediaId,
    meaningId,
    const DeepCollectionEquality().hash(_mediaUrls),
  );

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      __$$MediaImplCopyWithImpl<_$MediaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaImplToJson(this);
  }
}

abstract class _Media implements Media {
  const factory _Media({
    required final String mediaId,
    required final String meaningId,
    required final List<String> mediaUrls,
  }) = _$MediaImpl;

  factory _Media.fromJson(Map<String, dynamic> json) = _$MediaImpl.fromJson;

  /// Unique media identifier
  @override
  String get mediaId;

  /// Associated meaning identifier
  @override
  String get meaningId;

  /// List of media URLs
  @override
  List<String> get mediaUrls;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
