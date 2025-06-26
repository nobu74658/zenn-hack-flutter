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

  /// Environment
  static const Environment environment = Environment.development;

  /// Debug mode flag
  static const isDebug = true;

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
        return 'http://localhost:8000';
      case Environment.staging:
        return 'https://staging-api-url';
      case Environment.production:
        return 'https://your-cloud-run-service-url';
    }
  }

  bool get isProduction => this == Environment.production;
  bool get isDevelopment => this == Environment.development;
}
