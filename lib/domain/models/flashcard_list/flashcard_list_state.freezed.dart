// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FlashcardListState {
  List<Flashcard> get flashcards => throw _privateConstructorUsedError;
  List<Flashcard> get originalFlashcards => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  DisplayMode get displayMode => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  PartOfSpeech? get posFilter => throw _privateConstructorUsedError;
  LearningStatus? get statusFilter => throw _privateConstructorUsedError;
  SortOption get sortOption => throw _privateConstructorUsedError;
  bool get isAscending => throw _privateConstructorUsedError;

  /// Create a copy of FlashcardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardListStateCopyWith<FlashcardListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardListStateCopyWith<$Res> {
  factory $FlashcardListStateCopyWith(
    FlashcardListState value,
    $Res Function(FlashcardListState) then,
  ) = _$FlashcardListStateCopyWithImpl<$Res, FlashcardListState>;
  @useResult
  $Res call({
    List<Flashcard> flashcards,
    List<Flashcard> originalFlashcards,
    bool isLoading,
    Object? error,
    DisplayMode displayMode,
    String searchQuery,
    PartOfSpeech? posFilter,
    LearningStatus? statusFilter,
    SortOption sortOption,
    bool isAscending,
  });
}

/// @nodoc
class _$FlashcardListStateCopyWithImpl<$Res, $Val extends FlashcardListState>
    implements $FlashcardListStateCopyWith<$Res> {
  _$FlashcardListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlashcardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flashcards = null,
    Object? originalFlashcards = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? displayMode = null,
    Object? searchQuery = null,
    Object? posFilter = freezed,
    Object? statusFilter = freezed,
    Object? sortOption = null,
    Object? isAscending = null,
  }) {
    return _then(
      _value.copyWith(
            flashcards:
                null == flashcards
                    ? _value.flashcards
                    : flashcards // ignore: cast_nullable_to_non_nullable
                        as List<Flashcard>,
            originalFlashcards:
                null == originalFlashcards
                    ? _value.originalFlashcards
                    : originalFlashcards // ignore: cast_nullable_to_non_nullable
                        as List<Flashcard>,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error: freezed == error ? _value.error : error,
            displayMode:
                null == displayMode
                    ? _value.displayMode
                    : displayMode // ignore: cast_nullable_to_non_nullable
                        as DisplayMode,
            searchQuery:
                null == searchQuery
                    ? _value.searchQuery
                    : searchQuery // ignore: cast_nullable_to_non_nullable
                        as String,
            posFilter:
                freezed == posFilter
                    ? _value.posFilter
                    : posFilter // ignore: cast_nullable_to_non_nullable
                        as PartOfSpeech?,
            statusFilter:
                freezed == statusFilter
                    ? _value.statusFilter
                    : statusFilter // ignore: cast_nullable_to_non_nullable
                        as LearningStatus?,
            sortOption:
                null == sortOption
                    ? _value.sortOption
                    : sortOption // ignore: cast_nullable_to_non_nullable
                        as SortOption,
            isAscending:
                null == isAscending
                    ? _value.isAscending
                    : isAscending // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashcardListStateImplCopyWith<$Res>
    implements $FlashcardListStateCopyWith<$Res> {
  factory _$$FlashcardListStateImplCopyWith(
    _$FlashcardListStateImpl value,
    $Res Function(_$FlashcardListStateImpl) then,
  ) = __$$FlashcardListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Flashcard> flashcards,
    List<Flashcard> originalFlashcards,
    bool isLoading,
    Object? error,
    DisplayMode displayMode,
    String searchQuery,
    PartOfSpeech? posFilter,
    LearningStatus? statusFilter,
    SortOption sortOption,
    bool isAscending,
  });
}

/// @nodoc
class __$$FlashcardListStateImplCopyWithImpl<$Res>
    extends _$FlashcardListStateCopyWithImpl<$Res, _$FlashcardListStateImpl>
    implements _$$FlashcardListStateImplCopyWith<$Res> {
  __$$FlashcardListStateImplCopyWithImpl(
    _$FlashcardListStateImpl _value,
    $Res Function(_$FlashcardListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlashcardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flashcards = null,
    Object? originalFlashcards = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? displayMode = null,
    Object? searchQuery = null,
    Object? posFilter = freezed,
    Object? statusFilter = freezed,
    Object? sortOption = null,
    Object? isAscending = null,
  }) {
    return _then(
      _$FlashcardListStateImpl(
        flashcards:
            null == flashcards
                ? _value._flashcards
                : flashcards // ignore: cast_nullable_to_non_nullable
                    as List<Flashcard>,
        originalFlashcards:
            null == originalFlashcards
                ? _value._originalFlashcards
                : originalFlashcards // ignore: cast_nullable_to_non_nullable
                    as List<Flashcard>,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error: freezed == error ? _value.error : error,
        displayMode:
            null == displayMode
                ? _value.displayMode
                : displayMode // ignore: cast_nullable_to_non_nullable
                    as DisplayMode,
        searchQuery:
            null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                    as String,
        posFilter:
            freezed == posFilter
                ? _value.posFilter
                : posFilter // ignore: cast_nullable_to_non_nullable
                    as PartOfSpeech?,
        statusFilter:
            freezed == statusFilter
                ? _value.statusFilter
                : statusFilter // ignore: cast_nullable_to_non_nullable
                    as LearningStatus?,
        sortOption:
            null == sortOption
                ? _value.sortOption
                : sortOption // ignore: cast_nullable_to_non_nullable
                    as SortOption,
        isAscending:
            null == isAscending
                ? _value.isAscending
                : isAscending // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$FlashcardListStateImpl implements _FlashcardListState {
  const _$FlashcardListStateImpl({
    final List<Flashcard> flashcards = const [],
    final List<Flashcard> originalFlashcards = const [],
    this.isLoading = true,
    this.error,
    this.displayMode = DisplayMode.grid,
    this.searchQuery = '',
    this.posFilter,
    this.statusFilter,
    this.sortOption = SortOption.dateAdded,
    this.isAscending = true,
  }) : _flashcards = flashcards,
       _originalFlashcards = originalFlashcards;

  final List<Flashcard> _flashcards;
  @override
  @JsonKey()
  List<Flashcard> get flashcards {
    if (_flashcards is EqualUnmodifiableListView) return _flashcards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flashcards);
  }

  final List<Flashcard> _originalFlashcards;
  @override
  @JsonKey()
  List<Flashcard> get originalFlashcards {
    if (_originalFlashcards is EqualUnmodifiableListView)
      return _originalFlashcards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originalFlashcards);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;
  @override
  @JsonKey()
  final DisplayMode displayMode;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  final PartOfSpeech? posFilter;
  @override
  final LearningStatus? statusFilter;
  @override
  @JsonKey()
  final SortOption sortOption;
  @override
  @JsonKey()
  final bool isAscending;

  @override
  String toString() {
    return 'FlashcardListState(flashcards: $flashcards, originalFlashcards: $originalFlashcards, isLoading: $isLoading, error: $error, displayMode: $displayMode, searchQuery: $searchQuery, posFilter: $posFilter, statusFilter: $statusFilter, sortOption: $sortOption, isAscending: $isAscending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardListStateImpl &&
            const DeepCollectionEquality().equals(
              other._flashcards,
              _flashcards,
            ) &&
            const DeepCollectionEquality().equals(
              other._originalFlashcards,
              _originalFlashcards,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.displayMode, displayMode) ||
                other.displayMode == displayMode) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.posFilter, posFilter) ||
                other.posFilter == posFilter) &&
            (identical(other.statusFilter, statusFilter) ||
                other.statusFilter == statusFilter) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption) &&
            (identical(other.isAscending, isAscending) ||
                other.isAscending == isAscending));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_flashcards),
    const DeepCollectionEquality().hash(_originalFlashcards),
    isLoading,
    const DeepCollectionEquality().hash(error),
    displayMode,
    searchQuery,
    posFilter,
    statusFilter,
    sortOption,
    isAscending,
  );

  /// Create a copy of FlashcardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardListStateImplCopyWith<_$FlashcardListStateImpl> get copyWith =>
      __$$FlashcardListStateImplCopyWithImpl<_$FlashcardListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FlashcardListState implements FlashcardListState {
  const factory _FlashcardListState({
    final List<Flashcard> flashcards,
    final List<Flashcard> originalFlashcards,
    final bool isLoading,
    final Object? error,
    final DisplayMode displayMode,
    final String searchQuery,
    final PartOfSpeech? posFilter,
    final LearningStatus? statusFilter,
    final SortOption sortOption,
    final bool isAscending,
  }) = _$FlashcardListStateImpl;

  @override
  List<Flashcard> get flashcards;
  @override
  List<Flashcard> get originalFlashcards;
  @override
  bool get isLoading;
  @override
  Object? get error;
  @override
  DisplayMode get displayMode;
  @override
  String get searchQuery;
  @override
  PartOfSpeech? get posFilter;
  @override
  LearningStatus? get statusFilter;
  @override
  SortOption get sortOption;
  @override
  bool get isAscending;

  /// Create a copy of FlashcardListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardListStateImplCopyWith<_$FlashcardListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
