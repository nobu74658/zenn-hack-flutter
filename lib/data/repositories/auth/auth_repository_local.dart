import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/result.dart';
import '../../../domain/models/auth/auth_user.dart';
import 'auth_repository.dart';

/// Local implementation of AuthRepository for development/testing
class AuthRepositoryLocal implements AuthRepository {
  AuthRepositoryLocal(this._preferences);

  final SharedPreferences _preferences;

  static const _userKey = 'auth_user';
  static const _emailKey = 'auth_email';
  static const _displayNameKey = 'auth_display_name';

  final _authStateController = StreamController<AuthUser?>.broadcast();

  @override
  Future<Result<AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Simple validation for demo purposes
      if (email.isEmpty || password.isEmpty) {
        return const Error(ValidationException('メールアドレスとパスワードを入力してください'));
      }

      if (!email.contains('@')) {
        return const Error(ValidationException('有効なメールアドレスを入力してください'));
      }

      // Mock user for local development
      final authUser = AuthUser(
        uid: 'local_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: 'Local User',
        emailVerified: true,
      );

      // Save to local storage
      await _preferences.setString(_userKey, authUser.uid);
      await _preferences.setString(_emailKey, authUser.email);
      await _preferences.setString(_displayNameKey, authUser.displayName ?? '');

      // Notify listeners
      _authStateController.add(authUser);

      return Ok(authUser);
    } on Exception catch (e) {
      return Error(AuthException('ローカルサインインに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _preferences.remove(_userKey);
      await _preferences.remove(_emailKey);
      await _preferences.remove(_displayNameKey);

      // Notify listeners
      _authStateController.add(null);

      return const Ok(null);
    } on Exception catch (e) {
      return Error(AuthException('ローカルサインアウトに失敗しました: $e'));
    }
  }

  @override
  Future<Result<AuthUser?>> getCurrentUser() async {
    try {
      final uid = _preferences.getString(_userKey);
      if (uid == null) {
        return const Ok(null);
      }

      final email = _preferences.getString(_emailKey) ?? '';
      final displayName = _preferences.getString(_displayNameKey);

      final authUser = AuthUser(
        uid: uid,
        email: email,
        displayName: displayName,
        emailVerified: true,
      );

      return Ok(authUser);
    } on Exception catch (e) {
      return Error(AuthException('ユーザー情報の取得に失敗しました: $e'));
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _authStateController.stream;
  }

  @override
  Future<Result<void>> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final uid = _preferences.getString(_userKey);
      if (uid == null) {
        return const Error(AuthException('ユーザーがサインインしていません'));
      }

      if (displayName != null) {
        await _preferences.setString(_displayNameKey, displayName);
      }

      // Get updated user and notify listeners
      final result = await getCurrentUser();
      result.when(
        ok: (user) {
          if (user != null) {
            _authStateController.add(user);
          }
        },
        error: (_) {},
      );

      return const Ok(null);
    } on Exception catch (e) {
      return Error(AuthException('プロフィールの更新に失敗しました: $e'));
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
