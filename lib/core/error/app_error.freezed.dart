// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppError _$AppErrorFromJson(Map<String, dynamic> json) {
  return _AppError.fromJson(json);
}

/// @nodoc
mixin _$AppError {
  /// Type of error for categorization
  ErrorType get type => throw _privateConstructorUsedError;

  /// Technical error message (for logging/debugging)
  String get message => throw _privateConstructorUsedError;

  /// User-friendly message to display to users
  String? get userMessage => throw _privateConstructorUsedError;

  /// Original error object if available
  @JsonKey(includeFromJson: false, includeToJson: false)
  Object? get originalError => throw _privateConstructorUsedError;

  /// Stack trace for debugging
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  /// HTTP status code if applicable
  int? get statusCode => throw _privateConstructorUsedError;

  /// Error code for specific error identification
  String? get code => throw _privateConstructorUsedError;

  /// Additional context data
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;

  /// Serializes this AppError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppErrorCopyWith<AppError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppErrorCopyWith<$Res> {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) then) =
      _$AppErrorCopyWithImpl<$Res, AppError>;
  @useResult
  $Res call({
    ErrorType type,
    String message,
    String? userMessage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Object? originalError,
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,
    int? statusCode,
    String? code,
    Map<String, dynamic>? context,
  });
}

/// @nodoc
class _$AppErrorCopyWithImpl<$Res, $Val extends AppError>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? userMessage = freezed,
    Object? originalError = freezed,
    Object? stackTrace = freezed,
    Object? statusCode = freezed,
    Object? code = freezed,
    Object? context = freezed,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ErrorType,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            userMessage:
                freezed == userMessage
                    ? _value.userMessage
                    : userMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            originalError:
                freezed == originalError ? _value.originalError : originalError,
            stackTrace:
                freezed == stackTrace
                    ? _value.stackTrace
                    : stackTrace // ignore: cast_nullable_to_non_nullable
                        as StackTrace?,
            statusCode:
                freezed == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int?,
            code:
                freezed == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as String?,
            context:
                freezed == context
                    ? _value.context
                    : context // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$AppErrorImplCopyWith(
    _$AppErrorImpl value,
    $Res Function(_$AppErrorImpl) then,
  ) = __$$AppErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ErrorType type,
    String message,
    String? userMessage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Object? originalError,
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,
    int? statusCode,
    String? code,
    Map<String, dynamic>? context,
  });
}

/// @nodoc
class __$$AppErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$AppErrorImpl>
    implements _$$AppErrorImplCopyWith<$Res> {
  __$$AppErrorImplCopyWithImpl(
    _$AppErrorImpl _value,
    $Res Function(_$AppErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? userMessage = freezed,
    Object? originalError = freezed,
    Object? stackTrace = freezed,
    Object? statusCode = freezed,
    Object? code = freezed,
    Object? context = freezed,
  }) {
    return _then(
      _$AppErrorImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ErrorType,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        userMessage:
            freezed == userMessage
                ? _value.userMessage
                : userMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        originalError:
            freezed == originalError ? _value.originalError : originalError,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as StackTrace?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
        code:
            freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as String?,
        context:
            freezed == context
                ? _value._context
                : context // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppErrorImpl implements _AppError {
  const _$AppErrorImpl({
    required this.type,
    required this.message,
    this.userMessage,
    @JsonKey(includeFromJson: false, includeToJson: false) this.originalError,
    @JsonKey(includeFromJson: false, includeToJson: false) this.stackTrace,
    this.statusCode,
    this.code,
    final Map<String, dynamic>? context,
  }) : _context = context;

  factory _$AppErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppErrorImplFromJson(json);

  /// Type of error for categorization
  @override
  final ErrorType type;

  /// Technical error message (for logging/debugging)
  @override
  final String message;

  /// User-friendly message to display to users
  @override
  final String? userMessage;

  /// Original error object if available
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Object? originalError;

  /// Stack trace for debugging
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StackTrace? stackTrace;

  /// HTTP status code if applicable
  @override
  final int? statusCode;

  /// Error code for specific error identification
  @override
  final String? code;

  /// Additional context data
  final Map<String, dynamic>? _context;

  /// Additional context data
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AppError(type: $type, message: $message, userMessage: $userMessage, originalError: $originalError, stackTrace: $stackTrace, statusCode: $statusCode, code: $code, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppErrorImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userMessage, userMessage) ||
                other.userMessage == userMessage) &&
            const DeepCollectionEquality().equals(
              other.originalError,
              originalError,
            ) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._context, _context));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    message,
    userMessage,
    const DeepCollectionEquality().hash(originalError),
    stackTrace,
    statusCode,
    code,
    const DeepCollectionEquality().hash(_context),
  );

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppErrorImplCopyWith<_$AppErrorImpl> get copyWith =>
      __$$AppErrorImplCopyWithImpl<_$AppErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppErrorImplToJson(this);
  }
}

abstract class _AppError implements AppError {
  const factory _AppError({
    required final ErrorType type,
    required final String message,
    final String? userMessage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final Object? originalError,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final StackTrace? stackTrace,
    final int? statusCode,
    final String? code,
    final Map<String, dynamic>? context,
  }) = _$AppErrorImpl;

  factory _AppError.fromJson(Map<String, dynamic> json) =
      _$AppErrorImpl.fromJson;

  /// Type of error for categorization
  @override
  ErrorType get type;

  /// Technical error message (for logging/debugging)
  @override
  String get message;

  /// User-friendly message to display to users
  @override
  String? get userMessage;

  /// Original error object if available
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Object? get originalError;

  /// Stack trace for debugging
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? get stackTrace;

  /// HTTP status code if applicable
  @override
  int? get statusCode;

  /// Error code for specific error identification
  @override
  String? get code;

  /// Additional context data
  @override
  Map<String, dynamic>? get context;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppErrorImplCopyWith<_$AppErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
