import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Material 3デザインに基づいた統一カードコンポーネント
class AppCard extends StatelessWidget {
  /// Creates an AppCard with Material 3 styling
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.elevation = AppCardElevation.level1,
    this.shape = AppCardShape.rounded,
    this.variant = AppCardVariant.elevated,
    this.borderColor,
    this.backgroundColor,
    this.width,
    this.height,
    this.constraints,
  });

  /// Child widget content
  final Widget child;

  /// Tap callback for interactive cards
  final VoidCallback? onTap;

  /// External margin
  final EdgeInsetsGeometry? margin;

  /// Internal padding
  final EdgeInsetsGeometry? padding;

  /// Card elevation level
  final AppCardElevation elevation;

  /// Card shape style
  final AppCardShape shape;

  /// Card variant
  final AppCardVariant variant;

  /// Border color (for outlined variant)
  final Color? borderColor;

  /// Background color override
  final Color? backgroundColor;

  /// Fixed width
  final double? width;

  /// Fixed height
  final double? height;

  /// Size constraints
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    var card = _buildCard(context);

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    if (width != null || height != null || constraints != null) {
      card = ConstrainedBox(
        constraints:
            constraints ??
            BoxConstraints(
              minWidth: width ?? 0,
              maxWidth: width ?? double.infinity,
              minHeight: height ?? 0,
              maxHeight: height ?? double.infinity,
            ),
        child: card,
      );
    }

    return card;
  }

  Widget _buildCard(BuildContext context) {
    final cardStyle = _getCardStyle(context);
    final content =
        padding != null ? Padding(padding: padding!, child: child) : child;

    if (onTap != null) {
      return Material(
        elevation: cardStyle.elevation,
        shadowColor: cardStyle.shadowColor,
        color: cardStyle.backgroundColor,
        shape: cardStyle.shape,
        child: InkWell(
          onTap: onTap,
          borderRadius: _getBorderRadius(),
          splashColor: AppColors.primary.withValues(alpha: 0.1),
          highlightColor: AppColors.primary.withValues(alpha: 0.05),
          child: content,
        ),
      );
    } else {
      return Material(
        elevation: cardStyle.elevation,
        shadowColor: cardStyle.shadowColor,
        color: cardStyle.backgroundColor,
        shape: cardStyle.shape,
        child: content,
      );
    }
  }

  _CardStyle _getCardStyle(BuildContext context) {
    final elevationValue = _getElevationValue(elevation);
    final shapeValue = _getShapeBorder();
    final bgColor = backgroundColor ?? _getBackgroundColor(context, variant);

    return _CardStyle(
      elevation: elevationValue,
      shadowColor: AppColors.cardShadow,
      backgroundColor: bgColor,
      shape: shapeValue,
    );
  }

  double _getElevationValue(AppCardElevation elevation) {
    switch (elevation) {
      case AppCardElevation.none:
        return 0;
      case AppCardElevation.level1:
        return 1;
      case AppCardElevation.level2:
        return 3;
      case AppCardElevation.level3:
        return 6;
      case AppCardElevation.level4:
        return 8;
      case AppCardElevation.level5:
        return 12;
    }
  }

  ShapeBorder _getShapeBorder() {
    final radius = _getBorderRadius();
    final border =
        variant == AppCardVariant.outlined
            ? BorderSide(color: borderColor ?? AppColors.cardBorder)
            : BorderSide.none;

    switch (shape) {
      case AppCardShape.rounded:
        return RoundedRectangleBorder(borderRadius: radius, side: border);
      case AppCardShape.circular:
        return CircleBorder(side: border);
      case AppCardShape.stadium:
        return StadiumBorder(side: border);
      case AppCardShape.square:
        return RoundedRectangleBorder(side: border);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (shape) {
      case AppCardShape.rounded:
        return BorderRadius.circular(12);
      case AppCardShape.circular:
      case AppCardShape.stadium:
        return BorderRadius.circular(1000);
      case AppCardShape.square:
        return BorderRadius.zero;
    }
  }

  Color _getBackgroundColor(BuildContext context, AppCardVariant variant) {
    switch (variant) {
      case AppCardVariant.elevated:
        return AppColors.cardBackground;
      case AppCardVariant.filled:
        return AppColors.surface;
      case AppCardVariant.outlined:
        return Colors.transparent;
    }
  }
}

/// Compact card variant for lists
class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.enabled = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: enabled ? onTap : null,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      backgroundColor:
          selected ? AppColors.primary.withValues(alpha: 0.1) : null,
      elevation: selected ? AppCardElevation.level2 : AppCardElevation.level1,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 16)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: enabled ? AppColors.textMain : AppColors.textSub,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          enabled
                              ? AppColors.textSub
                              : AppColors.textSub.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 16), trailing!],
        ],
      ),
    );
  }
}

/// Image card with overlay content
class AppImageCard extends StatelessWidget {
  const AppImageCard({
    super.key,
    required this.imageProvider,
    this.title,
    this.subtitle,
    this.overlay,
    this.onTap,
    this.aspectRatio = 16 / 9,
    this.fit = BoxFit.cover,
    this.elevation = AppCardElevation.level2,
    this.shape = AppCardShape.rounded,
  });

  final ImageProvider imageProvider;
  final String? title;
  final String? subtitle;
  final Widget? overlay;
  final VoidCallback? onTap;
  final double aspectRatio;
  final BoxFit fit;
  final AppCardElevation elevation;
  final AppCardShape shape;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      elevation: elevation,
      shape: shape,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: _getBorderRadius(),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(image: imageProvider, fit: fit),
              if (title != null || subtitle != null || overlay != null)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              if (overlay != null)
                overlay!
              else if (title != null || subtitle != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    switch (shape) {
      case AppCardShape.rounded:
        return BorderRadius.circular(12);
      case AppCardShape.circular:
        return BorderRadius.circular(1000);
      case AppCardShape.stadium:
        return BorderRadius.circular(1000);
      case AppCardShape.square:
        return BorderRadius.zero;
    }
  }
}

/// Card elevation levels
enum AppCardElevation { none, level1, level2, level3, level4, level5 }

/// Card shape variants
enum AppCardShape { rounded, circular, stadium, square }

/// Card style variants
enum AppCardVariant { elevated, filled, outlined }

/// Internal card style configuration
class _CardStyle {
  const _CardStyle({
    required this.elevation,
    required this.shadowColor,
    required this.backgroundColor,
    required this.shape,
  });

  final double elevation;
  final Color shadowColor;
  final Color backgroundColor;
  final ShapeBorder shape;
}
