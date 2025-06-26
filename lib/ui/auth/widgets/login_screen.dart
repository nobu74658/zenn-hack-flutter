import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/route_names.dart';
import '../notifiers/auth_form_notifier.dart';
import '../notifiers/auth_notifier.dart';
import 'auth_button.dart';
import 'auth_text_field.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final formNotifier = ref.watch(authFormNotifierProvider.notifier);
    final formState = ref.watch(authFormNotifierProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          // Navigate to home on successful login
          context.go(RouteNames.home);
        },
        unauthenticated: () {},
        error: (message) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // App logo and title
                _buildHeader(context),

                const SizedBox(height: 48),

                // Login form
                _buildLoginForm(context, ref, formNotifier, formState),

                const SizedBox(height: 32),

                // Login button
                _buildLoginButton(context, ref, authState, formState),

                const SizedBox(height: 24),

                // Sign up link
                _buildSignUpLink(context),

                const SizedBox(height: 16),

                // Info text
                _buildInfoText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.school, size: 40, color: AppColors.onPrimary),
        ),
        const SizedBox(height: 20),
        Text(
          'ログイン',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'GenFlash English Studyにサインイン',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSub),
        ),
      ],
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    WidgetRef ref,
    AuthFormNotifier formNotifier,
    FormValidationState formState,
  ) {
    return Column(
      children: [
        // User ID field
        AuthTextField(
          label: 'ユーザーID',
          onChanged: formNotifier.updateUserId,
          errorText: formNotifier.getErrorFor('userId'),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          autofocus: true,
        ),

        const SizedBox(height: 20),

        // Email field
        AuthTextField(
          label: 'メールアドレス',
          onChanged: formNotifier.updateEmail,
          errorText: formNotifier.getErrorFor('email'),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),

        const SizedBox(height: 20),

        // User name field
        AuthTextField(
          label: 'ユーザー名',
          onChanged: formNotifier.updateUserName,
          errorText: formNotifier.getErrorFor('userName'),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _handleLogin(context, ref, formState),
        ),
      ],
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    WidgetRef ref,
    AuthState authState,
    FormValidationState formState,
  ) {
    final isLoading = authState.whenOrNull(loading: () => true) ?? false;
    final formNotifier = ref.read(authFormNotifierProvider.notifier);
    final isValid = formNotifier.validateForLogin();

    return AuthButton(
      onPressed:
          isValid && !isLoading
              ? () => _handleLogin(context, ref, formState)
              : null,
      text: 'ログイン',
      isLoading: isLoading,
      icon: Icons.login,
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'アカウントをお持ちでない方は ',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSub),
        ),
        TextButton(
          onPressed: () => context.go(RouteNames.signup),
          child: Text(
            'サインアップ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 0.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.textSub, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '読み取り専用アプリ - データの編集・削除は行いません',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSub),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin(
    BuildContext context,
    WidgetRef ref,
    FormValidationState formState,
  ) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final formNotifier = ref.read(authFormNotifierProvider.notifier);

    if (formNotifier.validateForLogin()) {
      authNotifier.login(formState.userId, formState.email, formState.userName);
    }
  }
}
