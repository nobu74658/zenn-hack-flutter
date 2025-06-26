import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/router/route_names.dart';
import '../auth/notifiers/auth_notifier.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Check authentication state and navigate accordingly
      Future<void>.delayed(const Duration(seconds: 2)).then((_) {
        if (!context.mounted) {
          return;
        }

        // Use Future to delay provider access after build cycle
        Future(() {
          if (!context.mounted) {
            return;
          }

          ref
              .read(authNotifierProvider)
              .when(
                data: (state) {
                  if (state.isAuthenticated) {
                    context.go(RouteNames.home);
                  } else {
                    context.go(RouteNames.login);
                  }
                },
                loading: () {
                  // If still loading, default to login screen
                  context.go(RouteNames.login);
                },
                error: (error, stackTrace) {
                  // On error, go to login screen
                  context.go(RouteNames.login);
                },
              );
        });
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgPrimary, AppColors.bgSecondary],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  size: 64,
                  color: AppColors.onPrimary,
                ),
              ),

              const SizedBox(height: 32),

              // App Name
              Text(
                'GenFlash',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'English Study',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.textSub),
              ),

              const SizedBox(height: 48),

              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
