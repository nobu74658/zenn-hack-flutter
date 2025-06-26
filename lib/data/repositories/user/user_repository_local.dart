import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_config.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/result.dart';
import '../../../domain/models/user/user.dart';
import 'user_repository.dart';

/// Local implementation of UserRepository using SharedPreferences
class UserRepositoryLocal implements UserRepository {
  UserRepositoryLocal(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<Result<User>> getUser(String userId) {
    // Local repository only returns cached data
    return getCachedUser().then((result) {
      return switch (result) {
        Ok(data: final user) when user != null => Ok(user),
        Ok() => const Error(DataException('ローカルにユーザーデータが見つかりません')),
        Error(exception: final exception) => Error(exception),
      };
    });
  }

  @override
  Future<Result<User?>> getCachedUser() async {
    try {
      final userJson = _preferences.getString(_userCacheKey);
      if (userJson == null) {
        return const Ok(null);
      }

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(userMap);
      return Ok(user);
    } on Exception catch (e) {
      return Error(StorageException('キャッシュされたユーザーデータの読み込みに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> cacheUser(User user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _preferences.setString(_userCacheKey, userJson);

      // Also cache user ID for easy access
      await _preferences.setString(AppConfig.userIdKey, user.userId);
      await _preferences.setString(AppConfig.userEmailKey, user.email);
      await _preferences.setString(AppConfig.userNameKey, user.userName);

      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('ユーザーデータのキャッシュに失敗しました: $e'));
    }
  }

  @override
  Future<Result<void>> clearCachedUser() async {
    try {
      await _preferences.remove(_userCacheKey);
      await _preferences.remove(AppConfig.userIdKey);
      await _preferences.remove(AppConfig.userEmailKey);
      await _preferences.remove(AppConfig.userNameKey);

      return const Ok(null);
    } on Exception catch (e) {
      return Error(StorageException('キャッシュされたユーザーデータの削除に失敗しました: $e'));
    }
  }

  /// Cache key for user data
  static const _userCacheKey = 'cached_user_data';
}
