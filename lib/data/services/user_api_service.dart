import '../../core/constants/api_endpoints.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/models/user/user.dart';
import 'http_client.dart';

/// User API service for handling user-related HTTP requests (read-only)
class UserApiService {
  UserApiService(this._httpClient);

  final HttpClient _httpClient;

  /// Get user by ID
  Future<Result<User>> getUser(String userId) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        ApiEndpoints.userById(userId),
      );

      if (response.data == null) {
        return const Error(ApiException('ユーザーデータの取得に失敗しました'));
      }

      // Assume direct User object in response
      final user = User.fromJson(response.data!);
      return Ok(user);
    } on AppException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(ApiException('ユーザー取得時に予期しないエラーが発生しました: $e'));
    }
  }
}
