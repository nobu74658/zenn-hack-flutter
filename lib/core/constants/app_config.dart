import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration constants
class AppConfig {
  // Private constructor to prevent instantiation
  const AppConfig._();

  /// Application name
  static const appName = 'GenFlash English Study';

  /// Application version
  static const version = '1.0.0';

  /// Package name
  static const packageName = 'com.example.gen_flash_english_study';

  /// Environment (can be overridden at runtime)
  static Environment environment = Environment.development;

  /// Debug mode flag
  static const isDebug = true;

  /// Development mode flag
  static bool get isDevelopment => environment.isDevelopment;

  /// Animation durations
  static const shortAnimation = Duration(milliseconds: 300);
  static const mediumAnimation = Duration(milliseconds: 500);
  static const longAnimation = Duration(milliseconds: 800);

  /// Swipe thresholds for card interactions
  static const swipeThreshold = 0.3;
  static const cardRotationAngle = 0.3;

  /// Local storage keys
  static const userIdKey = 'user_id';
  static const userEmailKey = 'user_email';
  static const userNameKey = 'user_name';
  static const authTokenKey = 'auth_token';
  static const studyProgressKey = 'study_progress';
}

/// Application environment enum
enum Environment { development, staging, production }

/// Environment configuration
extension EnvironmentConfig on Environment {
  String get baseUrl {
    switch (this) {
      case Environment.development:
        return dotenv.env['API_BASE_URL_DEVELOPMENT'] ?? 'http://10.0.2.2:8000';
      case Environment.staging:
        return dotenv.env['API_BASE_URL_STAGING'] ?? 'http://10.0.2.2:8000';
      case Environment.production:
        return dotenv.env['API_BASE_URL_PRODUCTION'] ?? '';
    }
  }

  bool get isProduction => this == Environment.production;
  bool get isDevelopment => this == Environment.development;
}
