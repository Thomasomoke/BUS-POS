import 'package:bus_pos/common/widgets/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const Dashboard({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final String title = navigationShell.currentIndex == 0
        ? "Dashboard"
        : navigationShell.currentIndex == 1
        ? "Bookings"
        : navigationShell.currentIndex == 2
        ? "Reports"
        : "Profile";
    return PageLayout(
      title: title,
      showBackButton: false,
      currentIndex: navigationShell.currentIndex,
      onNavTap: (int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      child: navigationShell,
    );
  }
}
