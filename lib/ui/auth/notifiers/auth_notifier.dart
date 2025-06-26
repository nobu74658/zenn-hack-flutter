import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/result.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/auth/providers.dart';
import '../../../domain/models/auth/auth_state.dart';
import '../../../domain/models/auth/auth_user.dart';

part 'auth_notifier.g.dart';

/// Firebase Authentication notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _logger = Logger();
  AuthRepository? _authRepository;

  @override
  Future<AuthState> build() async {
    _authRepository = await ref.read(authRepositoryProvider.future);
    _initializeAuthStateListener();
    return _getInitialAuthState();
  }

  /// Initialize auth state listener
  void _initializeAuthStateListener() {
    _authRepository?.authStateChanges().listen((user) {
      _logger.d('Auth state changed: ${user?.uid}');
      state = AsyncValue.data(
        state.value?.copyWith(
              user: user,
              isAuthenticated: user != null,
              error: null,
            ) ??
            AuthState(user: user, isAuthenticated: user != null),
      );
    });
  }

  /// Get initial authentication state
  Future<AuthState> _getInitialAuthState() async {
    final result = await _authRepository!.getCurrentUser();
    return result.when<AuthState>(
      ok: (AuthUser? user) {
        _logger.d('Initialized with current user: ${user?.uid}');
        return AuthState(user: user, isAuthenticated: user != null);
      },
      error: (error) {
        _logger.e('Failed to get current user: $error');
        return AuthState(error: error.message);
      },
    );
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.data(
      state.value?.copyWith(isLoading: true, error: null) ??
          const AuthState(isLoading: true),
    );

    _logger.d('Attempting sign in with email: $email');

    final result = await _authRepository!.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.when<void>(
      ok: (AuthUser user) {
        _logger.i('Successfully signed in: ${user.uid}');
        state = AsyncValue.data(
          state.value?.copyWith(
                user: user,
                isAuthenticated: true,
                isLoading: false,
                error: null,
              ) ??
              AuthState(user: user, isAuthenticated: true),
        );
      },
      error: (error) {
        _logger.e('Sign in failed: $error');
        state = AsyncValue.data(
          state.value?.copyWith(
                error: error.message,
                isLoading: false,
                isAuthenticated: false,
              ) ??
              AuthState(error: error.message),
        );
      },
    );
  }

  /// Sign out current user
  Future<void> signOut() async {
    state = AsyncValue.data(
      state.value?.copyWith(isLoading: true, error: null) ??
          const AuthState(isLoading: true),
    );

    _logger.d('Attempting sign out');

    final result = await _authRepository!.signOut();

    result.when<void>(
      ok: (_) {
        _logger.i('Successfully signed out');
        state = AsyncValue.data(
          state.value?.copyWith(
                user: null,
                isAuthenticated: false,
                isLoading: false,
                error: null,
              ) ??
              const AuthState(),
        );
      },
      error: (error) {
        _logger.e('Sign out failed: $error');
        state = AsyncValue.data(
          state.value?.copyWith(error: error.message, isLoading: false) ??
              AuthState(error: error.message),
        );
      },
    );
  }

  /// Clear error state
  void clearError() {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(error: null));
    }
  }
}
