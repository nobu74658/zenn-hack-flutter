import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/constants/app_config.dart';

/// Development entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  // Set development environment
  AppConfig.environment = Environment.development;

  runApp(const ProviderScope(child: GenFlashEnglishStudyApp()));
}
