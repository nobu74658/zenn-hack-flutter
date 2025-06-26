import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/route_names.dart';
import '../notifiers/auth_form_notifier.dart';
import '../notifiers/auth_notifier.dart';
import 'auth_button.dart';
import 'auth_text_field.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

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
          // Navigate to home on successful signup
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => context.go(RouteNames.auth),
        ),
      ),
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
                const SizedBox(height: 20),

                // Header
                _buildHeader(context),

                const SizedBox(height: 40),

                // Signup form
                _buildSignupForm(context, formNotifier, formState),

                const SizedBox(height: 24),

                // Terms agreement
                _buildTermsAgreement(context, formNotifier, formState),

                const SizedBox(height: 32),

                // Signup button
                _buildSignupButton(context, ref, authState, formState),

                const SizedBox(height: 24),

                // Login link
                _buildLoginLink(context),
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
          child: const Icon(
            Icons.person_add,
            size: 40,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'アカウント作成',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '学習を始めるためのアカウントを作成しましょう',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSub),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignupForm(
    BuildContext context,
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
        ),
      ],
    );
  }

  Widget _buildTermsAgreement(
    BuildContext context,
    AuthFormNotifier formNotifier,
    FormValidationState formState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: formState.agreeTerms,
              onChanged:
                  (value) =>
                      formNotifier.updateAgreeTerms(value: value ?? false),
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap:
                    () => formNotifier.updateAgreeTerms(
                      value: !formState.agreeTerms,
                    ),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.textMain),
                    children: const [
                      TextSpan(text: ''),
                      TextSpan(
                        text: '利用規約',
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: 'と'),
                      TextSpan(
                        text: 'プライバシーポリシー',
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: 'に同意します'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (formNotifier.hasErrorFor('agreeTerms'))
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              formNotifier.getErrorFor('agreeTerms') ?? '',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }

  Widget _buildSignupButton(
    BuildContext context,
    WidgetRef ref,
    AuthState authState,
    FormValidationState formState,
  ) {
    final isLoading = authState.whenOrNull(loading: () => true) ?? false;
    final formNotifier = ref.read(authFormNotifierProvider.notifier);
    final isValid = formNotifier.validateForSignup();

    return AuthButton(
      onPressed:
          isValid && !isLoading
              ? () => _handleSignup(context, ref, formState)
              : null,
      text: 'アカウント作成',
      isLoading: isLoading,
      icon: Icons.person_add,
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'すでにアカウントをお持ちの方は ',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSub),
        ),
        TextButton(
          onPressed: () => context.go(RouteNames.auth),
          child: Text(
            'ログイン',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignup(
    BuildContext context,
    WidgetRef ref,
    FormValidationState formState,
  ) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final formNotifier = ref.read(authFormNotifierProvider.notifier);

    if (formNotifier.validateForSignup()) {
      authNotifier.login(formState.userId, formState.email, formState.userName);

      // Clear form after successful signup
      formNotifier.clear();
    }
  }
}
