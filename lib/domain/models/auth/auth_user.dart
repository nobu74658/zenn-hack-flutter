import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Authentication user entity for Firebase Auth
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    /// Firebase user ID
    required String uid,

    /// User email address
    required String email,

    /// User display name (optional)
    String? displayName,

    /// Whether email is verified
    @Default(false) bool emailVerified,

    /// User photo URL (optional)
    String? photoURL,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, Object?> json) =>
      _$AuthUserFromJson(json);
}
