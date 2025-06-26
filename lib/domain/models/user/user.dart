import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User domain entity
@freezed
class User with _$User {
  const factory User({
    /// Unique user identifier
    required String userId,

    /// User email address
    required String email,

    /// User display name
    required String userName,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
