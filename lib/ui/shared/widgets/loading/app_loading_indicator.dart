import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Material 3デザインに基づいた統一ローディングインジケーター
class AppLoadingIndicator extends StatelessWidget {
  /// Creates an AppLoadingIndicator with Material 3 styling
  const AppLoadingIndicator({
    super.key,
    this.size = AppLoadingSize.medium,
    this.variant = AppLoadingVariant.circular,
    this.color,
    this.strokeWidth,
    this.value,
    this.backgroundColor,
  });

  /// Loading indicator size
  final AppLoadingSize size;

  /// Loading indicator variant
  final AppLoadingVariant variant;

  /// Primary color override
  final Color? color;

  /// Stroke width for circular indicators
  final double? strokeWidth;

  /// Progress value (0.0 to 1.0) for determinate indicators
  final double? value;

  /// Background color for linear indicators
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final indicatorSize = _getIndicatorSize(size);
    final indicatorColor = color ?? AppColors.primary;
    final indicatorStrokeWidth = strokeWidth ?? _getStrokeWidth(size);

    switch (variant) {
      case AppLoadingVariant.circular:
        return SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: indicatorStrokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
            backgroundColor: backgroundColor,
          ),
        );

      case AppLoadingVariant.linear:
        return SizedBox(
          height: indicatorStrokeWidth,
          child: LinearProgressIndicator(
            value: value,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
            backgroundColor: backgroundColor ?? AppColors.bgSecondary,
          ),
        );

      case AppLoadingVariant.dots:
        return _DotsLoadingIndicator(
          size: indicatorSize,
          color: indicatorColor,
        );

      case AppLoadingVariant.pulse:
        return _PulseLoadingIndicator(
          size: indicatorSize,
          color: indicatorColor,
        );

      case AppLoadingVariant.spinner:
        return _SpinnerLoadingIndicator(
          size: indicatorSize,
          color: indicatorColor,
          strokeWidth: indicatorStrokeWidth,
        );
    }
  }

  double _getIndicatorSize(AppLoadingSize size) {
    switch (size) {
      case AppLoadingSize.small:
        return 16;
      case AppLoadingSize.medium:
        return 24;
      case AppLoadingSize.large:
        return 32;
      case AppLoadingSize.extraLarge:
        return 48;
    }
  }

  double _getStrokeWidth(AppLoadingSize size) {
    switch (size) {
      case AppLoadingSize.small:
        return 2;
      case AppLoadingSize.medium:
        return 3;
      case AppLoadingSize.large:
        return 4;
      case AppLoadingSize.extraLarge:
        return 6;
    }
  }
}

/// Full-screen loading overlay
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.variant = AppLoadingVariant.circular,
    this.size = AppLoadingSize.large,
    this.backgroundColor,
    this.barrierDismissible = false,
  });

  final bool isLoading;
  final Widget child;
  final String? message;
  final AppLoadingVariant variant;
  final AppLoadingSize size;
  final Color? backgroundColor;
  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: GestureDetector(
              onTap: barrierDismissible ? () {} : null,
              child: ColoredBox(
                color: backgroundColor ?? Colors.black.withValues(alpha: 0.5),
                child: Center(child: _buildLoadingContent(context)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppLoadingIndicator(variant: variant, size: size),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMain),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Shimmer loading effect for content placeholders
class AppShimmerLoading extends StatefulWidget {
  const AppShimmerLoading({
    super.key,
    required this.child,
    this.isLoading = true,
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<AppShimmerLoading> createState() => _AppShimmerLoadingState();
}

class _AppShimmerLoadingState extends State<AppShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -1,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isLoading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AppShimmerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final baseColor = widget.baseColor ?? AppColors.bgSecondary;
    final highlightColor = widget.highlightColor ?? AppColors.surface;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [baseColor, highlightColor, baseColor],
              stops: [0.0, _animation.value.clamp(0.0, 1.0), 1.0],
              transform: GradientRotation(_animation.value * 3.14159),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Dots loading animation
class _DotsLoadingIndicator extends StatefulWidget {
  const _DotsLoadingIndicator({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  State<_DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<_DotsLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations =
        _controllers.map((controller) {
          return Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          );
        }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 4;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: 0.5 + (_animations[index].value * 0.5),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(
                      alpha: 0.3 + (_animations[index].value * 0.7),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Pulse loading animation
class _PulseLoadingIndicator extends StatefulWidget {
  const _PulseLoadingIndicator({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  State<_PulseLoadingIndicator> createState() => _PulseLoadingIndicatorState();
}

class _PulseLoadingIndicatorState extends State<_PulseLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color.withValues(
              alpha: 0.3 + (_animation.value * 0.7),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

/// Spinner loading animation
class _SpinnerLoadingIndicator extends StatefulWidget {
  const _SpinnerLoadingIndicator({
    required this.size,
    required this.color,
    required this.strokeWidth,
  });

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  State<_SpinnerLoadingIndicator> createState() =>
      _SpinnerLoadingIndicatorState();
}

class _SpinnerLoadingIndicatorState extends State<_SpinnerLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _SpinnerPainter(
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14159 * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Loading indicator variants
enum AppLoadingVariant { circular, linear, dots, pulse, spinner }

/// Loading indicator sizes
enum AppLoadingSize { small, medium, large, extraLarge }
