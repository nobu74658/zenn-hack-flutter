import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gen_flash_english_study/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/constants/app_config.dart';

/// Staging entry point with Firebase Authentication
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Override app config for staging (Firebase Auth)
  AppConfig.environment = Environment.production;

  runApp(const ProviderScope(child: GenFlashEnglishStudyApp()));
}
