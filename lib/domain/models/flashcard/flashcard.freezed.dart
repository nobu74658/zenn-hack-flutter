// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Flashcard _$FlashcardFromJson(Map<String, dynamic> json) {
  return _Flashcard.fromJson(json);
}

/// @nodoc
mixin _$Flashcard {
  /// Unique flashcard identifier
  String get flashcardId => throw _privateConstructorUsedError;

  /// Word object
  Word get word => throw _privateConstructorUsedError;

  /// List of meanings
  List<Meaning> get meanings => throw _privateConstructorUsedError;

  /// Media object
  Media get media => throw _privateConstructorUsedError;

  /// Version number
  int get version => throw _privateConstructorUsedError;

  /// User memo
  String get memo => throw _privateConstructorUsedError;

  /// Whether the user has mastered this card
  bool get checkFlag => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Flashcard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardCopyWith<Flashcard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardCopyWith<$Res> {
  factory $FlashcardCopyWith(Flashcard value, $Res Function(Flashcard) then) =
      _$FlashcardCopyWithImpl<$Res, Flashcard>;
  @useResult
  $Res call({
    String flashcardId,
    Word word,
    List<Meaning> meanings,
    Media media,
    int version,
    String memo,
    bool checkFlag,
    DateTime createdAt,
  });

  $WordCopyWith<$Res> get word;
  $MediaCopyWith<$Res> get media;
}

/// @nodoc
class _$FlashcardCopyWithImpl<$Res, $Val extends Flashcard>
    implements $FlashcardCopyWith<$Res> {
  _$FlashcardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flashcardId = null,
    Object? word = null,
    Object? meanings = null,
    Object? media = null,
    Object? version = null,
    Object? memo = null,
    Object? checkFlag = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            flashcardId:
                null == flashcardId
                    ? _value.flashcardId
                    : flashcardId // ignore: cast_nullable_to_non_nullable
                        as String,
            word:
                null == word
                    ? _value.word
                    : word // ignore: cast_nullable_to_non_nullable
                        as Word,
            meanings:
                null == meanings
                    ? _value.meanings
                    : meanings // ignore: cast_nullable_to_non_nullable
                        as List<Meaning>,
            media:
                null == media
                    ? _value.media
                    : media // ignore: cast_nullable_to_non_nullable
                        as Media,
            version:
                null == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as int,
            memo:
                null == memo
                    ? _value.memo
                    : memo // ignore: cast_nullable_to_non_nullable
                        as String,
            checkFlag:
                null == checkFlag
                    ? _value.checkFlag
                    : checkFlag // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WordCopyWith<$Res> get word {
    return $WordCopyWith<$Res>(_value.word, (value) {
      return _then(_value.copyWith(word: value) as $Val);
    });
  }

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediaCopyWith<$Res> get media {
    return $MediaCopyWith<$Res>(_value.media, (value) {
      return _then(_value.copyWith(media: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FlashcardImplCopyWith<$Res>
    implements $FlashcardCopyWith<$Res> {
  factory _$$FlashcardImplCopyWith(
    _$FlashcardImpl value,
    $Res Function(_$FlashcardImpl) then,
  ) = __$$FlashcardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String flashcardId,
    Word word,
    List<Meaning> meanings,
    Media media,
    int version,
    String memo,
    bool checkFlag,
    DateTime createdAt,
  });

  @override
  $WordCopyWith<$Res> get word;
  @override
  $MediaCopyWith<$Res> get media;
}

/// @nodoc
class __$$FlashcardImplCopyWithImpl<$Res>
    extends _$FlashcardCopyWithImpl<$Res, _$FlashcardImpl>
    implements _$$FlashcardImplCopyWith<$Res> {
  __$$FlashcardImplCopyWithImpl(
    _$FlashcardImpl _value,
    $Res Function(_$FlashcardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flashcardId = null,
    Object? word = null,
    Object? meanings = null,
    Object? media = null,
    Object? version = null,
    Object? memo = null,
    Object? checkFlag = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$FlashcardImpl(
        flashcardId:
            null == flashcardId
                ? _value.flashcardId
                : flashcardId // ignore: cast_nullable_to_non_nullable
                    as String,
        word:
            null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                    as Word,
        meanings:
            null == meanings
                ? _value._meanings
                : meanings // ignore: cast_nullable_to_non_nullable
                    as List<Meaning>,
        media:
            null == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                    as Media,
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as int,
        memo:
            null == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                    as String,
        checkFlag:
            null == checkFlag
                ? _value.checkFlag
                : checkFlag // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlashcardImpl implements _Flashcard {
  const _$FlashcardImpl({
    required this.flashcardId,
    required this.word,
    required final List<Meaning> meanings,
    required this.media,
    required this.version,
    required this.memo,
    required this.checkFlag,
    required this.createdAt,
  }) : _meanings = meanings;

  factory _$FlashcardImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlashcardImplFromJson(json);

  /// Unique flashcard identifier
  @override
  final String flashcardId;

  /// Word object
  @override
  final Word word;

  /// List of meanings
  final List<Meaning> _meanings;

  /// List of meanings
  @override
  List<Meaning> get meanings {
    if (_meanings is EqualUnmodifiableListView) return _meanings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meanings);
  }

  /// Media object
  @override
  final Media media;

  /// Version number
  @override
  final int version;

  /// User memo
  @override
  final String memo;

  /// Whether the user has mastered this card
  @override
  final bool checkFlag;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Flashcard(flashcardId: $flashcardId, word: $word, meanings: $meanings, media: $media, version: $version, memo: $memo, checkFlag: $checkFlag, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardImpl &&
            (identical(other.flashcardId, flashcardId) ||
                other.flashcardId == flashcardId) &&
            (identical(other.word, word) || other.word == word) &&
            const DeepCollectionEquality().equals(other._meanings, _meanings) &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.checkFlag, checkFlag) ||
                other.checkFlag == checkFlag) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    flashcardId,
    word,
    const DeepCollectionEquality().hash(_meanings),
    media,
    version,
    memo,
    checkFlag,
    createdAt,
  );

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      __$$FlashcardImplCopyWithImpl<_$FlashcardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlashcardImplToJson(this);
  }
}

abstract class _Flashcard implements Flashcard {
  const factory _Flashcard({
    required final String flashcardId,
    required final Word word,
    required final List<Meaning> meanings,
    required final Media media,
    required final int version,
    required final String memo,
    required final bool checkFlag,
    required final DateTime createdAt,
  }) = _$FlashcardImpl;

  factory _Flashcard.fromJson(Map<String, dynamic> json) =
      _$FlashcardImpl.fromJson;

  /// Unique flashcard identifier
  @override
  String get flashcardId;

  /// Word object
  @override
  Word get word;

  /// List of meanings
  @override
  List<Meaning> get meanings;

  /// Media object
  @override
  Media get media;

  /// Version number
  @override
  int get version;

  /// User memo
  @override
  String get memo;

  /// Whether the user has mastered this card
  @override
  bool get checkFlag;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlashcardListResponse _$FlashcardListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _FlashcardListResponse.fromJson(json);
}

/// @nodoc
mixin _$FlashcardListResponse {
  /// Success message
  String get message => throw _privateConstructorUsedError;

  /// List of flashcards
  List<Flashcard> get flashcards => throw _privateConstructorUsedError;

  /// Serializes this FlashcardListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlashcardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardListResponseCopyWith<FlashcardListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardListResponseCopyWith<$Res> {
  factory $FlashcardListResponseCopyWith(
    FlashcardListResponse value,
    $Res Function(FlashcardListResponse) then,
  ) = _$FlashcardListResponseCopyWithImpl<$Res, FlashcardListResponse>;
  @useResult
  $Res call({String message, List<Flashcard> flashcards});
}

/// @nodoc
class _$FlashcardListResponseCopyWithImpl<
  $Res,
  $Val extends FlashcardListResponse
>
    implements $FlashcardListResponseCopyWith<$Res> {
  _$FlashcardListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlashcardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? flashcards = null}) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            flashcards:
                null == flashcards
                    ? _value.flashcards
                    : flashcards // ignore: cast_nullable_to_non_nullable
                        as List<Flashcard>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashcardListResponseImplCopyWith<$Res>
    implements $FlashcardListResponseCopyWith<$Res> {
  factory _$$FlashcardListResponseImplCopyWith(
    _$FlashcardListResponseImpl value,
    $Res Function(_$FlashcardListResponseImpl) then,
  ) = __$$FlashcardListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, List<Flashcard> flashcards});
}

/// @nodoc
class __$$FlashcardListResponseImplCopyWithImpl<$Res>
    extends
        _$FlashcardListResponseCopyWithImpl<$Res, _$FlashcardListResponseImpl>
    implements _$$FlashcardListResponseImplCopyWith<$Res> {
  __$$FlashcardListResponseImplCopyWithImpl(
    _$FlashcardListResponseImpl _value,
    $Res Function(_$FlashcardListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlashcardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? flashcards = null}) {
    return _then(
      _$FlashcardListResponseImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        flashcards:
            null == flashcards
                ? _value._flashcards
                : flashcards // ignore: cast_nullable_to_non_nullable
                    as List<Flashcard>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlashcardListResponseImpl implements _FlashcardListResponse {
  const _$FlashcardListResponseImpl({
    required this.message,
    required final List<Flashcard> flashcards,
  }) : _flashcards = flashcards;

  factory _$FlashcardListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlashcardListResponseImplFromJson(json);

  /// Success message
  @override
  final String message;

  /// List of flashcards
  final List<Flashcard> _flashcards;

  /// List of flashcards
  @override
  List<Flashcard> get flashcards {
    if (_flashcards is EqualUnmodifiableListView) return _flashcards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flashcards);
  }

  @override
  String toString() {
    return 'FlashcardListResponse(message: $message, flashcards: $flashcards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardListResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._flashcards,
              _flashcards,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_flashcards),
  );

  /// Create a copy of FlashcardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardListResponseImplCopyWith<_$FlashcardListResponseImpl>
  get copyWith =>
      __$$FlashcardListResponseImplCopyWithImpl<_$FlashcardListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FlashcardListResponseImplToJson(this);
  }
}

abstract class _FlashcardListResponse implements FlashcardListResponse {
  const factory _FlashcardListResponse({
    required final String message,
    required final List<Flashcard> flashcards,
  }) = _$FlashcardListResponseImpl;

  factory _FlashcardListResponse.fromJson(Map<String, dynamic> json) =
      _$FlashcardListResponseImpl.fromJson;

  /// Success message
  @override
  String get message;

  /// List of flashcards
  @override
  List<Flashcard> get flashcards;

  /// Create a copy of FlashcardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardListResponseImplCopyWith<_$FlashcardListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
