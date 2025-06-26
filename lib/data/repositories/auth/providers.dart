import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_config.dart';
import 'auth_repository.dart';
import 'auth_repository_local.dart';
import 'auth_repository_remote.dart';

part 'providers.g.dart';

/// Firebase Auth instance provider
@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

/// Auth repository provider (switches between local/remote based on config)
@riverpod
Future<AuthRepository> authRepository(Ref ref) async {
  final logger = Logger();

  if (AppConfig.isDevelopment) {
    final preferences = await ref.read(sharedPreferencesProvider.future);
    return AuthRepositoryLocal(preferences);
  } else {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    return AuthRepositoryRemote(firebaseAuth, logger);
  }
}

/// Logger provider
@riverpod
Logger logger(Ref ref) {
  return Logger();
}

/// SharedPreferences provider
@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}
