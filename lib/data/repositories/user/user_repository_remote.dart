import '../../../core/utils/result.dart';
import '../../../domain/models/user/user.dart';
import '../../services/user_api_service.dart';
import 'user_repository.dart';

/// Remote implementation of UserRepository using API calls
class UserRepositoryRemote implements UserRepository {
  UserRepositoryRemote(this._apiService);

  final UserApiService _apiService;

  @override
  Future<Result<User>> getUser(String userId) => _apiService.getUser(userId);

  @override
  Future<Result<User?>> getCachedUser() async {
    // Remote repository doesn't handle caching
    return const Ok(null);
  }

  @override
  Future<Result<void>> cacheUser(User user) async {
    // Remote repository doesn't handle caching
    return const Ok(null);
  }

  @override
  Future<Result<void>> clearCachedUser() async {
    // Remote repository doesn't handle caching
    return const Ok(null);
  }
}
