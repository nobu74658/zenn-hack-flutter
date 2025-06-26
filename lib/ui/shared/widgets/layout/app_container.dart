import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Material 3デザインに基づいた統一コンテナコンポーネント
class AppContainer extends StatelessWidget {
  /// Creates an AppContainer with Material 3 styling
  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.constraints,
    this.decoration,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.gradient,
    this.alignment,
    this.clipBehavior = Clip.none,
  });

  /// Child widget content
  final Widget child;

  /// Internal padding
  final EdgeInsetsGeometry? padding;

  /// External margin
  final EdgeInsetsGeometry? margin;

  /// Fixed width
  final double? width;

  /// Fixed height
  final double? height;

  /// Size constraints
  final BoxConstraints? constraints;

  /// Custom decoration (overrides other styling properties)
  final BoxDecoration? decoration;

  /// Background color
  final Color? backgroundColor;

  /// Border radius
  final BorderRadiusGeometry? borderRadius;

  /// Border configuration
  final BoxBorder? border;

  /// Box shadow list
  final List<BoxShadow>? boxShadow;

  /// Background gradient
  final Gradient? gradient;

  /// Child alignment
  final AlignmentGeometry? alignment;

  /// Clip behavior
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      alignment: alignment,
      decoration: decoration ?? _buildDecoration(),
      clipBehavior: clipBehavior,
      child: child,
    );

    if (margin != null) {
      container = Padding(padding: margin!, child: container);
    }

    return container;
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
      gradient: gradient,
    );
  }
}

/// Responsive container that adapts to screen size
class AppResponsiveContainer extends StatelessWidget {
  const AppResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.centerContent = true,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > maxWidth ? maxWidth : screenWidth;

    return AppContainer(
      width: centerContent ? containerWidth : null,
      margin: margin,
      padding: padding,
      backgroundColor: backgroundColor,
      alignment: centerContent ? Alignment.center : null,
      child: child,
    );
  }
}

/// Section container for grouping related content
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.backgroundColor,
    this.showDivider = false,
    this.dividerColor,
    this.headerActions,
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showDivider;
  final Color? dividerColor;
  final List<Widget>? headerActions;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: margin,
      backgroundColor: backgroundColor ?? Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || headerActions != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title!,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: AppColors.textMain,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textSub),
                            ),
                          ],
                        ],
                      ),
                    ),
                  if (headerActions != null) ...headerActions!,
                ],
              ),
            ),
            if (showDivider)
              Divider(
                color: dividerColor ?? AppColors.cardBorder,
                height: 1,
                thickness: 0.5,
              ),
          ],
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Card-like container with Material 3 styling
class AppCardContainer extends StatelessWidget {
  const AppCardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.backgroundColor,
    this.elevation = 1,
    this.borderRadius = 12,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double elevation;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final container = AppContainer(
      margin: margin,
      padding: padding,
      backgroundColor: backgroundColor ?? AppColors.cardBackground,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow:
          elevation > 0
              ? [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
              : null,
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: container,
        ),
      );
    }

    return container;
  }
}

/// Animated container with smooth transitions
class AppAnimatedContainer extends StatefulWidget {
  const AppAnimatedContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;

  @override
  State<AppAnimatedContainer> createState() => _AppAnimatedContainerState();
}

class _AppAnimatedContainerState extends State<AppAnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap!();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget container = AppContainer(
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      backgroundColor: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      child: widget.child,
    );

    if (widget.onTap != null) {
      container = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: container,
      );
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: container);
      },
    );
  }
}

/// Grid container for responsive layouts
class AppGridContainer extends StatelessWidget {
  const AppGridContainer({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
    this.childAspectRatio = 1,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
