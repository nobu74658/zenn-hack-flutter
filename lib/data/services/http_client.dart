import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/constants/app_config.dart';
import '../../core/exceptions/app_exception.dart';

/// HTTP client service using Dio
class HttpClient {
  HttpClient() {
    _logger = Logger(
      printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.environment.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }
  late final Dio _dio;
  late final Logger _logger;

  /// Setup request/response interceptors
  void _setupInterceptors() {
    if (AppConfig.isDebug) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          logPrint: (obj) => _logger.d(obj),
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('Request: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            'Response: ${response.statusCode} ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
            'Error: ${error.response?.statusCode} ${error.requestOptions.path}',
          );
          handler.next(error);
        },
      ),
    );
  }

  /// Perform GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Perform POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Perform PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Perform DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Handle Dio exceptions and convert to app exceptions
  AppException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException('接続がタイムアウトしました');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        final message =
            (data is Map<String, dynamic>)
                ? (data['detail'] as String? ??
                    data['message'] as String? ??
                    'サーバーエラーが発生しました')
                : 'サーバーエラーが発生しました';

        if (statusCode == 401) {
          return AuthException(message, statusCode?.toString());
        } else if (statusCode == 422) {
          return ValidationException(message, statusCode?.toString());
        } else {
          return ApiException(message, statusCode?.toString());
        }

      case DioExceptionType.cancel:
        return const NetworkException('リクエストがキャンセルされました');

      case DioExceptionType.connectionError:
        return const NetworkException('ネットワーク接続エラーが発生しました');

      case DioExceptionType.badCertificate:
        return const NetworkException('証明書エラーが発生しました');

      case DioExceptionType.unknown:
        return NetworkException('不明なエラーが発生しました: ${e.message}');
    }
  }
}
