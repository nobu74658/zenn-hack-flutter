import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/route_names.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final currentLocation = GoRouterState.of(context).fullPath;

    return BottomNavigationBar(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSub,
      type: BottomNavigationBarType.fixed,
      currentIndex: _getCurrentIndex(currentLocation),
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: '学習'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: '単語帳'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: '統計'),
      ],
    );
  }

  int _getCurrentIndex(String? location) {
    if (location == null) {
      return 0;
    }

    if (location.startsWith(RouteNames.study)) {
      return 1;
    }
    if (location.startsWith(RouteNames.cardList)) {
      return 2;
    }
    if (location.startsWith(RouteNames.statistics)) {
      return 3;
    }
    return 0; // Default to home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
      case 1:
        context.go(RouteNames.study);
      case 2:
        context.go(RouteNames.cardList);
      case 3:
        context.go(RouteNames.statistics);
    }
  }
}
