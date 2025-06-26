import '../../../core/utils/result.dart';
import '../../../domain/models/auth/auth_user.dart';

/// Abstract interface for authentication repository
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Result<AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out the current user
  Future<Result<void>> signOut();

  /// Get the current authenticated user
  Future<Result<AuthUser?>> getCurrentUser();

  /// Listen to authentication state changes
  Stream<AuthUser?> authStateChanges();

  /// Update user profile
  Future<Result<void>> updateProfile({String? displayName, String? photoURL});
}
