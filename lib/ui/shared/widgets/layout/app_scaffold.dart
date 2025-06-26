import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../loading/app_loading_indicator.dart';

/// Material 3デザインに基づいた統一Scaffoldコンポーネント
class AppScaffold extends StatelessWidget {
  /// Creates an AppScaffold with Material 3 styling
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.isLoading = false,
    this.loadingMessage,
    this.keyboardDismissMode = AppKeyboardDismissMode.onTap,
    this.safeAreaBottom = true,
    this.safeAreaTop = true,
    this.padding,
  });

  /// App bar widget
  final PreferredSizeWidget? appBar;

  /// Main body content
  final Widget? body;

  /// Floating action button
  final Widget? floatingActionButton;

  /// FAB location
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Left drawer
  final Widget? drawer;

  /// Right drawer
  final Widget? endDrawer;

  /// Background color override
  final Color? backgroundColor;

  /// Resize to avoid keyboard
  final bool? resizeToAvoidBottomInset;

  /// Extend body behind bottom widget
  final bool extendBody;

  /// Extend body behind app bar
  final bool extendBodyBehindAppBar;

  /// Show loading overlay
  final bool isLoading;

  /// Loading message
  final String? loadingMessage;

  /// Keyboard dismiss behavior
  final AppKeyboardDismissMode keyboardDismissMode;

  /// Apply safe area to bottom
  final bool safeAreaBottom;

  /// Apply safe area to top
  final bool safeAreaTop;

  /// Global padding for body content
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Scaffold(
      appBar: appBar,
      body: _buildBody(context),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );

    if (keyboardDismissMode != AppKeyboardDismissMode.none) {
      scaffold = GestureDetector(onTap: _dismissKeyboard, child: scaffold);
    }

    return AppLoadingOverlay(
      isLoading: isLoading,
      message: loadingMessage,
      child: scaffold,
    );
  }

  Widget? _buildBody(BuildContext context) {
    if (body == null) {
      return null;
    }

    var bodyWidget = body!;

    // Apply safe area
    if (safeAreaTop || safeAreaBottom) {
      bodyWidget = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: bodyWidget,
      );
    }

    // Apply global padding
    if (padding != null) {
      bodyWidget = Padding(padding: padding!, child: bodyWidget);
    }

    return bodyWidget;
  }

  void _dismissKeyboard() {
    if (keyboardDismissMode == AppKeyboardDismissMode.onTap) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

/// Enhanced scaffold with refresh capability
class AppRefreshScaffold extends StatelessWidget {
  const AppRefreshScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.onRefresh,
    this.refreshIndicatorColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.isLoading = false,
    this.loadingMessage,
    this.keyboardDismissMode = AppKeyboardDismissMode.onTap,
    this.safeAreaBottom = true,
    this.safeAreaTop = true,
    this.padding,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Future<void> Function()? onRefresh;
  final Color? refreshIndicatorColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool isLoading;
  final String? loadingMessage;
  final AppKeyboardDismissMode keyboardDismissMode;
  final bool safeAreaBottom;
  final bool safeAreaTop;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var bodyWidget = body;

    if (onRefresh != null) {
      bodyWidget = RefreshIndicator(
        onRefresh: onRefresh!,
        color: refreshIndicatorColor ?? AppColors.primary,
        backgroundColor: AppColors.surface,
        child: bodyWidget,
      );
    }

    return AppScaffold(
      appBar: appBar,
      body: bodyWidget,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      isLoading: isLoading,
      loadingMessage: loadingMessage,
      keyboardDismissMode: keyboardDismissMode,
      safeAreaBottom: safeAreaBottom,
      safeAreaTop: safeAreaTop,
      padding: padding,
    );
  }
}

/// Scaffold with nested scroll view for complex layouts
class AppNestedScrollScaffold extends StatelessWidget {
  const AppNestedScrollScaffold({
    super.key,
    this.headerSliverBuilder,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.isLoading = false,
    this.loadingMessage,
    this.keyboardDismissMode = AppKeyboardDismissMode.onTap,
    this.padding,
  });

  final List<Widget> Function(
    BuildContext context, {
    required bool innerBoxIsScrolled,
  })?
  headerSliverBuilder;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool isLoading;
  final String? loadingMessage;
  final AppKeyboardDismissMode keyboardDismissMode;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Widget bodyWidget = NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        final slivers = headerSliverBuilder?.call(
          context,
          innerBoxIsScrolled: innerBoxIsScrolled,
        );
        return slivers ?? <Widget>[];
      },
      body: padding != null ? Padding(padding: padding!, child: body) : body,
    );

    return AppScaffold(
      body: bodyWidget,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      isLoading: isLoading,
      loadingMessage: loadingMessage,
      keyboardDismissMode: keyboardDismissMode,
      safeAreaBottom: false, // Handled by NestedScrollView
      safeAreaTop: false, // Handled by SliverAppBar
    );
  }
}

/// Page wrapper with consistent styling
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    this.title,
    this.actions,
    this.leading,
    required this.child,
    this.centerTitle = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.isLoading = false,
    this.loadingMessage,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget child;
  final bool centerTitle;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final bool isLoading;
  final String? loadingMessage;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar:
          title != null
              ? AppBar(
                title: Text(title!),
                centerTitle: centerTitle,
                actions: actions,
                leading: leading,
                automaticallyImplyLeading: showBackButton,
                backgroundColor: appBarBackgroundColor ?? AppColors.bgWhole,
                foregroundColor: AppColors.textMain,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              )
              : null,
      body: child,
      backgroundColor: backgroundColor,
      isLoading: isLoading,
      loadingMessage: loadingMessage,
      padding: padding,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// Error page with retry functionality
class AppErrorPage extends StatelessWidget {
  const AppErrorPage({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryButtonText = '再試行',
    this.showAppBar = true,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryButtonText;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: showAppBar ? 'エラー' : null,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textSub),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(retryButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Keyboard dismiss modes
enum AppKeyboardDismissMode { none, onTap }
