import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';

/// Material 3デザインに基づいた統一テキストフィールドコンポーネント
class AppTextField extends StatelessWidget {
  /// Creates an AppTextField with Material 3 styling
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.errorText,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.variant = AppTextFieldVariant.outlined,
    this.size = AppTextFieldSize.medium,
  });

  /// Field label text
  final String label;

  /// Text editing controller
  final TextEditingController? controller;

  /// Initial value for the field
  final String? initialValue;

  /// Called when text changes
  final ValueChanged<String>? onChanged;

  /// Called when field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Validation function
  final String? Function(String?)? validator;

  /// Error message to display
  final String? errorText;

  /// Helper text to display
  final String? helperText;

  /// Placeholder text
  final String? hintText;

  /// Leading icon
  final Widget? prefixIcon;

  /// Trailing icon
  final Widget? suffixIcon;

  /// Obscure text for passwords
  final bool obscureText;

  /// Enable/disable the field
  final bool enabled;

  /// Read-only mode
  final bool readOnly;

  /// Auto focus on build
  final bool autofocus;

  /// Maximum number of lines
  final int maxLines;

  /// Maximum character length
  final int? maxLength;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Field style variant
  final AppTextFieldVariant variant;

  /// Field size
  final AppTextFieldSize size;

  @override
  Widget build(BuildContext context) {
    final fieldSize = _getFieldSize(size);
    final decoration = _getInputDecoration(context, variant, fieldSize);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          style: _getTextStyle(context, size, enabled),
          decoration: decoration,
          buildCounter: maxLength != null ? _buildCounter : null,
        ),
        if (helperText != null && errorText == null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: fieldSize.horizontalPadding),
            child: Text(
              helperText!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSub),
            ),
          ),
        ],
      ],
    );
  }

  InputDecoration _getInputDecoration(
    BuildContext context,
    AppTextFieldVariant variant,
    _FieldSize fieldSize,
  ) {
    switch (variant) {
      case AppTextFieldVariant.outlined:
        return InputDecoration(
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: enabled ? AppColors.inputFill : AppColors.bgSecondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(
              color: AppColors.inputFocusBorder,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: BorderSide(
              color: AppColors.inputBorder.withValues(alpha: 0.5),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: fieldSize.horizontalPadding,
            vertical: fieldSize.verticalPadding,
          ),
          labelStyle: TextStyle(
            color: enabled ? AppColors.textMain : AppColors.textSub,
          ),
          hintStyle: TextStyle(color: AppColors.textSub.withValues(alpha: 0.6)),
          errorStyle: const TextStyle(color: AppColors.error),
        );

      case AppTextFieldVariant.filled:
        return InputDecoration(
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: enabled ? AppColors.inputFill : AppColors.bgSecondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(
              color: AppColors.inputFocusBorder,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fieldSize.borderRadius),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: fieldSize.horizontalPadding,
            vertical: fieldSize.verticalPadding,
          ),
          labelStyle: TextStyle(
            color: enabled ? AppColors.textMain : AppColors.textSub,
          ),
          hintStyle: TextStyle(color: AppColors.textSub.withValues(alpha: 0.6)),
          errorStyle: const TextStyle(color: AppColors.error),
        );

      case AppTextFieldVariant.underlined:
        return InputDecoration(
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputFocusBorder, width: 2),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 2),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: fieldSize.horizontalPadding,
            vertical: fieldSize.verticalPadding,
          ),
          labelStyle: TextStyle(
            color: enabled ? AppColors.textMain : AppColors.textSub,
          ),
          hintStyle: TextStyle(color: AppColors.textSub.withValues(alpha: 0.6)),
          errorStyle: const TextStyle(color: AppColors.error),
        );
    }
  }

  TextStyle _getTextStyle(
    BuildContext context,
    AppTextFieldSize size,
    bool enabled,
  ) {
    final baseStyle = switch (size) {
      AppTextFieldSize.small => Theme.of(context).textTheme.bodySmall,
      AppTextFieldSize.medium => Theme.of(context).textTheme.bodyMedium,
      AppTextFieldSize.large => Theme.of(context).textTheme.bodyLarge,
    };

    return baseStyle?.copyWith(
          color: enabled ? AppColors.textMain : AppColors.textSub,
        ) ??
        TextStyle(
          color: enabled ? AppColors.textMain : AppColors.textSub,
          fontSize: _getFontSize(size),
        );
  }

  double _getFontSize(AppTextFieldSize size) {
    switch (size) {
      case AppTextFieldSize.small:
        return 12;
      case AppTextFieldSize.medium:
        return 14;
      case AppTextFieldSize.large:
        return 16;
    }
  }

  _FieldSize _getFieldSize(AppTextFieldSize size) {
    switch (size) {
      case AppTextFieldSize.small:
        return const _FieldSize(
          horizontalPadding: 12,
          verticalPadding: 8,
          borderRadius: 8,
        );
      case AppTextFieldSize.medium:
        return const _FieldSize(
          horizontalPadding: 16,
          verticalPadding: 12,
          borderRadius: 10,
        );
      case AppTextFieldSize.large:
        return const _FieldSize(
          horizontalPadding: 20,
          verticalPadding: 16,
          borderRadius: 12,
        );
    }
  }

  Widget? _buildCounter(
    BuildContext context, {
    required int currentLength,
    required int? maxLength,
    required bool isFocused,
  }) {
    if (maxLength == null) {
      return null;
    }

    return Text(
      '$currentLength/$maxLength',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: currentLength > maxLength ? AppColors.error : AppColors.textSub,
      ),
    );
  }
}

/// Password field with show/hide toggle
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.errorText,
    this.helperText,
    this.hintText,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.variant = AppTextFieldVariant.outlined,
    this.size = AppTextFieldSize.medium,
  });

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? helperText;
  final String? hintText;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final AppTextFieldVariant variant;
  final AppTextFieldSize size;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      errorText: widget.errorText,
      helperText: widget.helperText,
      hintText: widget.hintText,
      obscureText: _obscureText,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      variant: widget.variant,
      size: widget.size,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.textSub,
        ),
        onPressed:
            widget.enabled
                ? () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                }
                : null,
      ),
    );
  }
}

/// Search field with search icon
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = '検索...',
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
    this.variant = AppTextFieldVariant.filled,
    this.size = AppTextFieldSize.medium,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hintText;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;
  final AppTextFieldVariant variant;
  final AppTextFieldSize size;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: '',
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintText: hintText,
      enabled: enabled,
      autofocus: autofocus,
      variant: variant,
      size: size,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search, color: AppColors.textSub),
      suffixIcon:
          controller?.text.isNotEmpty == true
              ? IconButton(
                icon: const Icon(Icons.clear, color: AppColors.textSub),
                onPressed:
                    onClear ??
                    () {
                      controller?.clear();
                      onChanged?.call('');
                    },
              )
              : null,
    );
  }
}

/// Text field style variants
enum AppTextFieldVariant { outlined, filled, underlined }

/// Text field size variants
enum AppTextFieldSize { small, medium, large }

/// Internal field size configuration
class _FieldSize {
  const _FieldSize({
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
  });

  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
}
