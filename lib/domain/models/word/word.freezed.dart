// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Word _$WordFromJson(Map<String, dynamic> json) {
  return _Word.fromJson(json);
}

/// @nodoc
mixin _$Word {
  /// Unique word identifier
  String get wordId => throw _privateConstructorUsedError;

  /// The English word
  String get word => throw _privateConstructorUsedError;

  /// Core meaning summary
  String get coreMeaning => throw _privateConstructorUsedError;

  /// Detailed explanation
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordCopyWith<Word> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) then) =
      _$WordCopyWithImpl<$Res, Word>;
  @useResult
  $Res call({
    String wordId,
    String word,
    String coreMeaning,
    String explanation,
  });
}

/// @nodoc
class _$WordCopyWithImpl<$Res, $Val extends Word>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = null,
    Object? coreMeaning = null,
    Object? explanation = null,
  }) {
    return _then(
      _value.copyWith(
            wordId:
                null == wordId
                    ? _value.wordId
                    : wordId // ignore: cast_nullable_to_non_nullable
                        as String,
            word:
                null == word
                    ? _value.word
                    : word // ignore: cast_nullable_to_non_nullable
                        as String,
            coreMeaning:
                null == coreMeaning
                    ? _value.coreMeaning
                    : coreMeaning // ignore: cast_nullable_to_non_nullable
                        as String,
            explanation:
                null == explanation
                    ? _value.explanation
                    : explanation // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordImplCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$$WordImplCopyWith(
    _$WordImpl value,
    $Res Function(_$WordImpl) then,
  ) = __$$WordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String wordId,
    String word,
    String coreMeaning,
    String explanation,
  });
}

/// @nodoc
class __$$WordImplCopyWithImpl<$Res>
    extends _$WordCopyWithImpl<$Res, _$WordImpl>
    implements _$$WordImplCopyWith<$Res> {
  __$$WordImplCopyWithImpl(_$WordImpl _value, $Res Function(_$WordImpl) _then)
    : super(_value, _then);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = null,
    Object? coreMeaning = null,
    Object? explanation = null,
  }) {
    return _then(
      _$WordImpl(
        wordId:
            null == wordId
                ? _value.wordId
                : wordId // ignore: cast_nullable_to_non_nullable
                    as String,
        word:
            null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                    as String,
        coreMeaning:
            null == coreMeaning
                ? _value.coreMeaning
                : coreMeaning // ignore: cast_nullable_to_non_nullable
                    as String,
        explanation:
            null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordImpl implements _Word {
  const _$WordImpl({
    required this.wordId,
    required this.word,
    required this.coreMeaning,
    required this.explanation,
  });

  factory _$WordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordImplFromJson(json);

  /// Unique word identifier
  @override
  final String wordId;

  /// The English word
  @override
  final String word;

  /// Core meaning summary
  @override
  final String coreMeaning;

  /// Detailed explanation
  @override
  final String explanation;

  @override
  String toString() {
    return 'Word(wordId: $wordId, word: $word, coreMeaning: $coreMeaning, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.coreMeaning, coreMeaning) ||
                other.coreMeaning == coreMeaning) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, wordId, word, coreMeaning, explanation);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      __$$WordImplCopyWithImpl<_$WordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordImplToJson(this);
  }
}

abstract class _Word implements Word {
  const factory _Word({
    required final String wordId,
    required final String word,
    required final String coreMeaning,
    required final String explanation,
  }) = _$WordImpl;

  factory _Word.fromJson(Map<String, dynamic> json) = _$WordImpl.fromJson;

  /// Unique word identifier
  @override
  String get wordId;

  /// The English word
  @override
  String get word;

  /// Core meaning summary
  @override
  String get coreMeaning;

  /// Detailed explanation
  @override
  String get explanation;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
