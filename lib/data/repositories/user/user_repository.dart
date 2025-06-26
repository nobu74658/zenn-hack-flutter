import '../../../core/utils/result.dart';
import '../../../domain/models/user/user.dart';

/// Abstract repository interface for user operations (read-only)
abstract class UserRepository {
  /// Get user by ID
  Future<Result<User>> getUser(String userId);

  /// Get cached user data locally
  Future<Result<User?>> getCachedUser();

  /// Cache user data locally
  Future<Result<void>> cacheUser(User user);

  /// Clear cached user data
  Future<Result<void>> clearCachedUser();
}
