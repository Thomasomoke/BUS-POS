import 'package:bus_pos/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 

  storage = await SecureStorageService.getInstance();

  runApp(const App());
}
