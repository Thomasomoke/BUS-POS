import 'package:bus_pos/features/authentication/providers/session_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

String? routeGuard(BuildContext context, GoRouterState state) {
  final session = context.read<SessionProvider>();

  return !session.isLoggedIn
      ? state.uri.path != "/login"
            ? "/login"
            : null
      : null;
}
