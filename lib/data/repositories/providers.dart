import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/providers.dart';
import 'flashcard/flashcard_repository.dart';
import 'flashcard/flashcard_repository_local.dart';
import 'flashcard/flashcard_repository_remote.dart';
import 'meaning/meaning_repository.dart';
import 'user/user_repository.dart';
import 'user/user_repository_local.dart';
import 'user/user_repository_remote.dart';

/// SharedPreferences provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

/// User repository provider (remote implementation)
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryRemote(ref.watch(userApiServiceProvider));
});

/// User repository local provider
final userRepositoryLocalProvider = FutureProvider<UserRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return UserRepositoryLocal(prefs);
});

/// Flashcard repository provider (remote implementation)
final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  return FlashcardRepositoryRemote(ref.watch(flashcardApiServiceProvider));
});

/// Flashcard repository local provider
final flashcardRepositoryLocalProvider = FutureProvider<FlashcardRepository>((
  ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return FlashcardRepositoryLocal(prefs);
});

/// Meaning repository provider (remote implementation)
final meaningRepositoryProvider = Provider<MeaningRepository>((ref) {
  // For now, only remote implementation exists
  // Will add local implementation later if needed
  throw UnimplementedError('Meaning repository not yet implemented');
});
