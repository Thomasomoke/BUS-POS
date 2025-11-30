import 'package:bus_pos/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:bus_pos/features/payments/providers/payment_provider.dart';
import 'package:bus_pos/features/payments/data/payments_repository.dart';
import 'package:bus_pos/features/payments/data/payments_api.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  storage = await SecureStorageService.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PaymentsApi>(create: (_) => PaymentsApi()),
        Provider<PaymentsRepository>(create: (context) => PaymentsRepository()),
        ChangeNotifierProvider<PaymentProvider>(
          create: (context) =>
              PaymentProvider(repository: context.read<PaymentsRepository>()),
        ),
      ],
      child: const App(),
    );
  }
}
