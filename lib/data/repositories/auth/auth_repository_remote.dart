import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/result.dart';
import '../../../domain/models/auth/auth_user.dart';
import 'auth_repository.dart';

/// Firebase Authentication repository implementation
class AuthRepositoryRemote implements AuthRepository {
  AuthRepositoryRemote(this._firebaseAuth, this._logger);

  final FirebaseAuth _firebaseAuth;
  final Logger _logger;

  @override
  Future<Result<AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _logger.d('Attempting to sign in with email: $email');

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        _logger.e('Firebase user is null after sign in');
        return const Error(AuthException('サインインに失敗しました'));
      }

      final authUser = _mapFirebaseUserToAuthUser(user);
      _logger.i('Successfully signed in user: ${authUser.uid}');

      return Ok(authUser);
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase auth error: ${e.code} - ${e.message}');
      return Error(_mapFirebaseAuthException(e));
    } on Exception catch (e) {
      _logger.e('Unexpected error during sign in: $e');
      return Error(AuthException('サインインに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      _logger.d('Attempting to sign out');
      await _firebaseAuth.signOut();
      _logger.i('Successfully signed out');
      return const Ok(null);
    } on Exception catch (e) {
      _logger.e('Error during sign out: $e');
      return Error(AuthException('サインアウトに失敗しました: $e'));
    }
  }

  @override
  Future<Result<AuthUser?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        _logger.d('No current user');
        return const Ok(null);
      }

      final authUser = _mapFirebaseUserToAuthUser(user);
      _logger.d('Current user: ${authUser.uid}');

      return Ok(authUser);
    } on Exception catch (e) {
      _logger.e('Error getting current user: $e');
      return Error(AuthException('ユーザー情報の取得に失敗しました: $e'));
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        _logger.d('Auth state changed: user signed out');
        return null;
      }

      _logger.d('Auth state changed: user signed in (${user.uid})');
      return _mapFirebaseUserToAuthUser(user);
    });
  }

  @override
  Future<Result<void>> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Error(AuthException('ユーザーがサインインしていません'));
      }

      _logger.d('Updating user profile: displayName=$displayName');

      await user.updateDisplayName(displayName);
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }

      _logger.i('Successfully updated user profile');
      return const Ok(null);
    } on Exception catch (e) {
      _logger.e('Error updating user profile: $e');
      return Error(AuthException('プロフィールの更新に失敗しました: $e'));
    }
  }

  /// Map Firebase User to AuthUser domain model
  AuthUser _mapFirebaseUserToAuthUser(User user) {
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      emailVerified: user.emailVerified,
      photoURL: user.photoURL,
    );
  }

  /// Map Firebase Auth Exception to AppException
  AppException _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthException('このメールアドレスに関連付けられたアカウントが見つかりません');
      case 'wrong-password':
        return const AuthException('パスワードが間違っています');
      case 'invalid-email':
        return const ValidationException('無効なメールアドレスです');
      case 'user-disabled':
        return const AuthException('このアカウントは無効化されています');
      case 'too-many-requests':
        return const AuthException('リクエストが多すぎます。しばらく待ってから再試行してください');
      case 'network-request-failed':
        return const NetworkException('ネットワークエラーが発生しました');
      default:
        return AuthException('認証エラー: ${e.message}');
    }
  }
}
