/// Base class for all application exceptions
abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message';
}

/// Exception thrown when network request fails
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

/// Exception thrown when API returns an error
class ApiException extends AppException {
  const ApiException(super.message, [super.code]);
}

/// Exception thrown when authentication fails
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// Exception thrown when data parsing fails
class DataException extends AppException {
  const DataException(super.message, [super.code]);
}

/// Exception thrown when local storage operation fails
class StorageException extends AppException {
  const StorageException(super.message, [super.code]);
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}
