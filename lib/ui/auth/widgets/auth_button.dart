import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.enabled = true,
    this.style = AuthButtonStyle.primary,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool enabled;
  final AuthButtonStyle style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child:
          icon != null
              ? ElevatedButton.icon(
                onPressed: isEnabled ? onPressed : null,
                icon:
                    isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.onPrimary,
                            ),
                          ),
                        )
                        : Icon(icon),
                label: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: _getButtonStyle(context, style, isEnabled),
              )
              : ElevatedButton(
                onPressed: isEnabled ? onPressed : null,
                style: _getButtonStyle(context, style, isEnabled),
                child:
                    isLoading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.onPrimary,
                            ),
                          ),
                        )
                        : Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
    );
  }

  ButtonStyle _getButtonStyle(
    BuildContext context,
    AuthButtonStyle style,
    bool isEnabled,
  ) {
    switch (style) {
      case AuthButtonStyle.primary:
        return ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? AppColors.buttonPrimary : AppColors.buttonDisabled,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.buttonDisabled,
          disabledForegroundColor: AppColors.textSub,
          elevation: isEnabled ? 2 : 0,
          shadowColor: AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        );
      case AuthButtonStyle.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor:
              isEnabled ? AppColors.buttonPrimary : AppColors.textSub,
          disabledForegroundColor: AppColors.textSub,
          elevation: 0,
          side: BorderSide(
            color: isEnabled ? AppColors.buttonPrimary : AppColors.inputBorder,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        );
      case AuthButtonStyle.text:
        return TextButton.styleFrom(
          foregroundColor:
              isEnabled ? AppColors.buttonPrimary : AppColors.textSub,
          disabledForegroundColor: AppColors.textSub,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        );
    }
  }
}

enum AuthButtonStyle { primary, secondary, text }

/// Loading button variant for async operations
class AuthLoadingButton extends StatelessWidget {
  const AuthLoadingButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    this.enabled = true,
    this.style = AuthButtonStyle.primary,
    this.icon,
  });

  final Future<void> Function()? onPressed;
  final String text;
  final bool isLoading;
  final bool enabled;
  final AuthButtonStyle style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onPressed: isLoading ? null : onPressed,
      text: text,
      isLoading: isLoading,
      enabled: enabled,
      style: style,
      icon: icon,
    );
  }
}
