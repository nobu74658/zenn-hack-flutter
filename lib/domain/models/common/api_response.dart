import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Generic API response wrapper
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    /// Response message
    required String message,

    /// Response data
    T? data,

    /// Error details
    String? error,

    /// HTTP status code
    int? statusCode,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

/// Success response with user data
@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    /// Success message
    required String message,

    /// User data
    required Map<String, dynamic> user,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, Object?> json) =>
      _$UserResponseFromJson(json);
}

/// Success response with flashcards data
@freezed
class FlashcardsResponse with _$FlashcardsResponse {
  const factory FlashcardsResponse({
    /// Success message
    required String message,

    /// List of flashcards
    required List<Map<String, dynamic>> flashcards,
  }) = _FlashcardsResponse;

  factory FlashcardsResponse.fromJson(Map<String, Object?> json) =>
      _$FlashcardsResponseFromJson(json);
}

/// Generic success response
@freezed
class SuccessResponse with _$SuccessResponse {
  const factory SuccessResponse({
    /// Success message
    required String message,

    /// Optional additional data
    Map<String, dynamic>? data,
  }) = _SuccessResponse;

  factory SuccessResponse.fromJson(Map<String, Object?> json) =>
      _$SuccessResponseFromJson(json);
}
