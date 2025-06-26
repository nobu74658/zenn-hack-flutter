import '../exceptions/app_exception.dart';

/// Result pattern for error handling
sealed class Result<T> {
  const Result();
}

/// Success result containing data
class Ok<T> extends Result<T> {
  const Ok(this.data);

  final T data;

  @override
  String toString() => 'Ok($data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ok<T> && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// Error result containing exception
class Error<T> extends Result<T> {
  const Error(this.exception);

  final AppException exception;

  @override
  String toString() => 'Error($exception)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          exception == other.exception;

  @override
  int get hashCode => exception.hashCode;
}

/// Extensions for Result handling
extension ResultExtensions<T> on Result<T> {
  /// Returns true if result is Ok
  bool get isOk => this is Ok<T>;

  /// Returns true if result is Error
  bool get isError => this is Error<T>;

  /// Returns data if Ok, null if Error
  T? get dataOrNull => switch (this) {
    Ok(data: final data) => data,
    Error() => null,
  };

  /// Returns exception if Error, null if Ok
  AppException? get exceptionOrNull => switch (this) {
    Ok() => null,
    Error(exception: final exception) => exception,
  };

  /// Maps the data if Ok, returns Error unchanged
  Result<U> map<U>(U Function(T) mapper) => switch (this) {
    Ok(data: final data) => Ok(mapper(data)),
    Error(exception: final exception) => Error(exception),
  };

  /// FlatMaps the result
  Result<U> flatMap<U>(Result<U> Function(T) mapper) => switch (this) {
    Ok(data: final data) => mapper(data),
    Error(exception: final exception) => Error(exception),
  };
}
