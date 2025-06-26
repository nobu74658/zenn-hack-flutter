/// API endpoint constants for the application
class ApiEndpoints {
  // Private constructor to prevent instantiation
  const ApiEndpoints._();

  /// Base URL for development
  static const baseUrlDev = 'http://localhost:8000';

  /// Base URL for production
  static const baseUrlProd = 'https://your-cloud-run-service-url';

  /// User endpoints (read-only)
  static const userBase = '/user';
  static String userById(String userId) => '$userBase/$userId';

  /// Flashcard endpoints (read-only)
  static const flashcardBase = '/flashcard';
  static String flashcardByUserId(String userId) => '$flashcardBase/$userId';

  /// Meaning endpoints (read-only)
  static const meaningBase = '/meaning';
  static String meaningByWordId(String wordId) => '$meaningBase/$wordId';
}
