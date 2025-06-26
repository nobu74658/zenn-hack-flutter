import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user.dart';

part 'auth_state.freezed.dart';

/// Authentication state for the application
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    /// Current authenticated user
    AuthUser? user,

    /// Whether authentication is in progress
    @Default(false) bool isLoading,

    /// Authentication error message
    String? error,

    /// Whether user is authenticated
    @Default(false) bool isAuthenticated,
  }) = _AuthState;
}
