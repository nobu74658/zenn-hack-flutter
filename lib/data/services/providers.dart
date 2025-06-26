import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flashcard_api_service.dart';
import 'http_client.dart';
import 'meaning_api_service.dart';
import 'user_api_service.dart';

/// SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

/// HTTP client provider
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

/// User API service provider
final userApiServiceProvider = Provider<UserApiService>((ref) {
  return UserApiService(ref.watch(httpClientProvider));
});

/// Flashcard API service provider
final flashcardApiServiceProvider = Provider<FlashcardApiService>((ref) {
  return FlashcardApiService(ref.watch(httpClientProvider));
});

/// Meaning API service provider
final meaningApiServiceProvider = Provider<MeaningApiService>((ref) {
  return MeaningApiService(ref.watch(httpClientProvider));
});
