import 'package:bus_pos/core/routing/route_guards.dart';
import 'package:bus_pos/features/authentication/presentation/screens/login_screen.dart';
import 'package:bus_pos/features/booking/presentation/screens/booking_screen.dart';
import 'package:bus_pos/features/dashboard/presentation/screens/dashboard.dart';
import 'package:bus_pos/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Dashboard(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (BuildContext context, GoRouterState state) =>
                    const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                builder: (context, state) => BookingScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                builder: (context, state) => Center(child: Text("Reports")),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => Center(child: Text("Profile")),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) => routeGuard(context, state),
  );
}
