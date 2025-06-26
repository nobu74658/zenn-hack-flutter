import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user/user.dart';
import '../constants/app_config.dart';
import '../exceptions/app_exception.dart';
import '../utils/result.dart';

/// Authentication service for managing user sessions
class AuthService {
  AuthService(this._preferences);

  final SharedPreferences _preferences;

  /// Check if user is currently logged in
  Future<bool> isLoggedIn() async {
    final userId = _preferences.getString(AppConfig.userIdKey);
    return userId != null && userId.isNotEmpty;
  }

  /// Get current user ID
  Future<String?> getCurrentUserId() async {
    return _preferences.getString(AppConfig.userIdKey);
  }

  /// Get current user info from local storage
  Future<Result<User?>> getCurrentUser() async {
    try {
      final userId = _preferences.getString(AppConfig.userIdKey);
      final email = _preferences.getString(AppConfig.userEmailKey);
      final userName = _preferences.getString(AppConfig.userNameKey);

      if (userId == null || email == null || userName == null) {
        return const Ok(null);
      }

      final user = User(userId: userId, email: email, userName: userName);

      return Ok(user);
    } on Exception catch (e) {
      return Error(StorageException('ユーザー情報の取得に失敗しました: $e'));
    }
  }

  /// Login user (save user info locally)
  Future<Result<void>> login(User user) async {
    try {
      await _preferences.setString(AppConfig.userIdKey, user.userId);
      await _preferences.setString(AppConfig.userEmailKey, user.email);
      await _preferences.setString(AppConfig.userNameKey, user.userName);

      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('ログイン情報の保存に失敗しました: $e'));
    }
  }

  /// Logout user (clear local data)
  Future<Result<void>> logout() async {
    try {
      await _preferences.remove(AppConfig.userIdKey);
      await _preferences.remove(AppConfig.userEmailKey);
      await _preferences.remove(AppConfig.userNameKey);
      await _preferences.remove(AppConfig.authTokenKey);

      // Clear other user-related data
      final keys = _preferences.getKeys().where(
        (key) => key.startsWith('flashcards_') || key.startsWith('cached_'),
      );

      for (final key in keys) {
        await _preferences.remove(key);
      }

      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('ログアウト処理に失敗しました: $e'));
    }
  }
}
