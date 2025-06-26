import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/utils/result.dart';
import '../../../data/services/providers.dart';
import '../../../domain/models/user/user.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';

/// Authentication state
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

/// Authentication notifier for managing auth state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _logger = Logger();

  @override
  AuthState build() {
    _checkInitialAuthState();
    return const AuthState.initial();
  }

  /// Check if user is already authenticated on app start
  Future<void> _checkInitialAuthState() async {
    final authService = ref.read(authServiceProvider);
    final result = await authService.getCurrentUser();

    state = switch (result) {
      Ok() =>
        result.data != null
            ? AuthState.authenticated(result.data!)
            : const AuthState.unauthenticated(),
      Error() => AuthState.error(result.exception.message),
    };
  }

  /// Login with user credentials
  Future<void> login(String userId, String email, String userName) async {
    state = const AuthState.loading();
    _logger.i('Attempting login for user: $userId');

    try {
      final user = User(userId: userId, email: email, userName: userName);
      final authService = ref.read(authServiceProvider);
      final result = await authService.login(user);

      state = switch (result) {
        Ok() => () {
          _logger.i('Login successful for user: $userId');
          return AuthState.authenticated(user);
        }(),
        Error() => () {
          _logger.e('Login failed for user: $userId', error: result.exception);
          return AuthState.error(result.exception.message);
        }(),
      };
    } on Exception catch (e) {
      _logger.e('Unexpected error during login', error: e);
      state = AuthState.error('ログインに失敗しました: $e');
    }
  }

  /// Logout current user
  Future<void> logout() async {
    state = const AuthState.loading();
    _logger.i('Attempting logout');

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.logout();

      state = switch (result) {
        Ok() => () {
          _logger.i('Logout successful');
          return const AuthState.unauthenticated();
        }(),
        Error() => () {
          _logger.e('Logout failed', error: result.exception);
          return AuthState.error(result.exception.message);
        }(),
      };
    } on Exception catch (e) {
      _logger.e('Unexpected error during logout', error: e);
      state = AuthState.error('ログアウトに失敗しました: $e');
    }
  }

  /// Clear error state
  void clearError() {
    if (state case _Error()) {
      state = const AuthState.unauthenticated();
    }
  }
}

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return AuthService(sharedPreferences);
});
