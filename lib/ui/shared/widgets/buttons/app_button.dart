import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Material 3デザインに基づいた統一ボタンコンポーネント
class AppButton extends StatelessWidget {
  /// Creates an AppButton with Material 3 styling
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.fullWidth = false,
  });

  /// Button press callback
  final VoidCallback? onPressed;

  /// Button text label
  final String text;

  /// Button style variant
  final AppButtonVariant variant;

  /// Button size
  final AppButtonSize size;

  /// Loading state indicator
  final bool isLoading;

  /// Enabled state
  final bool isEnabled;

  /// Optional leading icon
  final IconData? icon;

  /// Expand to full width
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final isInteractive = isEnabled && !isLoading && onPressed != null;

    final buttonStyle = _getButtonStyle(context, variant, size);
    final buttonSize = _getButtonSize(size);

    Widget button;

    if (icon != null) {
      button = ElevatedButton.icon(
        onPressed: isInteractive ? onPressed : null,
        style: buttonStyle,
        icon: _buildIcon(),
        label: _buildLabel(context),
      );
    } else {
      button = ElevatedButton(
        onPressed: isInteractive ? onPressed : null,
        style: buttonStyle,
        child: _buildContent(context),
      );
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: buttonSize.height,
        child: button,
      );
    }

    return SizedBox(height: buttonSize.height, child: button);
  }

  Widget _buildIcon() {
    if (isLoading) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getContentColor(variant)),
        ),
      );
    }
    return Icon(icon, size: 18);
  }

  Widget _buildLabel(BuildContext context) {
    return Text(text, style: _getTextStyle(context, size));
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getContentColor(variant),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(text, style: _getTextStyle(context, size)),
        ],
      );
    }

    return Text(text, style: _getTextStyle(context, size));
  }

  ButtonStyle _getButtonStyle(
    BuildContext context,
    AppButtonVariant variant,
    AppButtonSize size,
  ) {
    final buttonSize = _getButtonSize(size);

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.buttonDisabled,
          disabledForegroundColor: AppColors.textSub,
          elevation: 2,
          shadowColor: AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.horizontalPadding,
            vertical: buttonSize.verticalPadding,
          ),
        );

      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.bgSecondary,
          disabledForegroundColor: AppColors.textSub,
          elevation: 1,
          shadowColor: AppColors.cardShadow.withValues(alpha: 0.5),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.horizontalPadding,
            vertical: buttonSize.verticalPadding,
          ),
        );

      case AppButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textSub,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.horizontalPadding,
            vertical: buttonSize.verticalPadding,
          ),
        );

      case AppButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textSub,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.horizontalPadding,
            vertical: buttonSize.verticalPadding,
          ),
        );

      case AppButtonVariant.destructive:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.buttonDisabled,
          disabledForegroundColor: AppColors.textSub,
          elevation: 2,
          shadowColor: AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.horizontalPadding,
            vertical: buttonSize.verticalPadding,
          ),
        );
    }
  }

  TextStyle _getTextStyle(BuildContext context, AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

      case AppButtonSize.medium:
        return Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

      case AppButtonSize.large:
        return Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    }
  }

  Color _getContentColor(AppButtonVariant variant) {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.destructive:
        return Colors.white;
      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
      case AppButtonVariant.text:
        return AppColors.primary;
    }
  }

  _ButtonSize _getButtonSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return const _ButtonSize(
          height: 32,
          horizontalPadding: 12,
          verticalPadding: 6,
          borderRadius: 8,
        );
      case AppButtonSize.medium:
        return const _ButtonSize(
          height: 40,
          horizontalPadding: 16,
          verticalPadding: 8,
          borderRadius: 10,
        );
      case AppButtonSize.large:
        return const _ButtonSize(
          height: 48,
          horizontalPadding: 24,
          verticalPadding: 12,
          borderRadius: 12,
        );
    }
  }
}

/// Button style variants
enum AppButtonVariant { primary, secondary, outlined, text, destructive }

/// Button size variants
enum AppButtonSize { small, medium, large }

/// Internal button size configuration
class _ButtonSize {
  const _ButtonSize({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
  });

  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
}

/// Icon button variant for actions
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = AppButtonSize.medium,
    this.variant = AppIconButtonVariant.standard,
    this.isEnabled = true,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final AppButtonSize size;
  final AppIconButtonVariant variant;
  final bool isEnabled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final iconSize = _getIconSize(size);
    final buttonSize = _getButtonSize(size);

    Widget button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: _getDecoration(variant),
      child: IconButton(
        onPressed: isEnabled ? onPressed : null,
        icon: Icon(icon, size: iconSize),
        color: _getIconColor(variant),
        disabledColor: AppColors.textSub,
        splashRadius: buttonSize / 2,
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    return button;
  }

  double _getIconSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _getButtonSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  BoxDecoration? _getDecoration(AppIconButtonVariant variant) {
    switch (variant) {
      case AppIconButtonVariant.standard:
        return null;
      case AppIconButtonVariant.filled:
        return BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        );
      case AppIconButtonVariant.outlined:
        return BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        );
    }
  }

  Color _getIconColor(AppIconButtonVariant variant) {
    switch (variant) {
      case AppIconButtonVariant.standard:
      case AppIconButtonVariant.outlined:
        return AppColors.primary;
      case AppIconButtonVariant.filled:
        return AppColors.onPrimary;
    }
  }
}

/// Icon button variants
enum AppIconButtonVariant { standard, filled, outlined }
