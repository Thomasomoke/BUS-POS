import 'package:bus_pos/core/config/size_config.dart';
import 'package:bus_pos/core/routing/app_router.dart';
import 'package:bus_pos/core/services/secure_storage_service.dart';
import 'package:bus_pos/core/theme/app_theme.dart';
import 'package:bus_pos/features/authentication/providers/auth_provider.dart';
import 'package:bus_pos/features/authentication/providers/session_provider.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:bus_pos/features/dashboard/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        SizeConfig().init(context);

        return MultiProvider(
          providers: [
            Provider<SecureStorageService>.value(value: storage),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => SessionProvider()),
            ChangeNotifierProvider(create: (_) => DashboardProvider()),
            ChangeNotifierProvider(create: (_) => BookingProvider()),
          ],
          child: MaterialApp.router(
            title: "BusPos",
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            routerConfig: _router,
          ),
        );
      },
    );
  }
}
