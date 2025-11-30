import 'package:bus_pos/core/routing/route_guards.dart';
import 'package:bus_pos/features/authentication/presentation/screens/login_screen.dart';
import 'package:bus_pos/features/booking/presentation/screens/booking_screen.dart';
import 'package:bus_pos/features/dashboard/presentation/screens/dashboard.dart';
import 'package:bus_pos/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:bus_pos/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:bus_pos/features/payments/presentation/screens/payment_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      // Public routes (outside the main shell)
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // Main app shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Dashboard(navigationShell: navigationShell);
        },
        branches: [
          // Tab 1: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (BuildContext context, GoRouterState state) =>
                    const DashboardScreen(),
              ),
            ],
          ),
          // Tab 2: Bookings & Payments
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                builder: (context, state) => BookingScreen(),
              ),
              GoRoute(
                path: '/payment-confirmation',
                builder: (context, state) {
                  final paymentId =
                      state.uri.queryParameters['paymentId'] ?? '';
                  final transactionId =
                      state.uri.queryParameters['transactionId'] ?? '';
                  return PaymentConfirmationPage(
                    paymentId: paymentId,
                    initialTransactionId: transactionId,
                  );
                },
              ),
            ],
          ),
          // Tab 3: Reports
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                builder: (context, state) => Center(child: Text("Reports")),
              ),
            ],
          ),
          // Tab 4: Profile
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
