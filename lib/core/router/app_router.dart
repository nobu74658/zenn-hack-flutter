import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ui/auth/widgets/auth_screen.dart';
import '../../ui/auth/widgets/login_screen.dart';
import '../../ui/auth/widgets/signup_screen.dart';
import '../../ui/flashcard_list/widgets/flashcard_list_screen.dart';
import '../../ui/home/home_screen.dart';
import '../../ui/shared/layouts/main_layout.dart';
import '../../ui/splash/splash_screen.dart';
import '../../ui/study/widgets/swipe_study_screen.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash screen
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splashName,
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes
      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.authName,
        builder: (context, state) => const AuthScreen(),
      ),

      // Login screen
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        builder: (context, state) => const LoginScreen(),
      ),

      // Signup screen
      GoRoute(
        path: RouteNames.signup,
        name: RouteNames.signupName,
        builder: (context, state) => const SignupScreen(),
      ),

      // Main shell routes with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          // Home
          GoRoute(
            path: RouteNames.home,
            name: RouteNames.homeName,
            builder: (context, state) => const HomeScreen(),
          ),

          // Study
          GoRoute(
            path: RouteNames.study,
            name: RouteNames.studyName,
            builder: (context, state) => const SwipeStudyScreen(),
          ),

          // Card list
          GoRoute(
            path: RouteNames.cardList,
            name: RouteNames.cardListName,
            builder: (context, state) => const FlashcardListScreen(),
          ),

          // Statistics (placeholder)
          GoRoute(
            path: RouteNames.statistics,
            name: RouteNames.statisticsName,
            builder:
                (context, state) => const _PlaceholderScreen(
                  title: '学習統計',
                  message: '統計画面は実装予定です',
                ),
          ),
        ],
      ),
    ],

    // Error page
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('エラー')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('ページが見つかりません: ${state.fullPath}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go(RouteNames.home),
                  child: const Text('ホームに戻る'),
                ),
              ],
            ),
          ),
        ),
  );
}

/// Placeholder screen for screens not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('ホームに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
