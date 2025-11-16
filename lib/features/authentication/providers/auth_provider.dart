import 'package:bus_pos/core/services/http_client.dart';
import 'package:bus_pos/core/services/secure_storage_service.dart';
import 'package:bus_pos/core/utils/toaster.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';
import 'package:bus_pos/features/authentication/providers/session_provider.dart';
import 'package:bus_pos/features/authentication/data/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  // State variables
  bool _isLoading = false;
  String? _successMessage;
  String? _errorMessage;
  UserModel? user;

  // Dependencies
  final HttpClient client = HttpClient();
  late SecureStorageService storage;

  // Getters
  bool get isLoading => _isLoading;
  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;

  // Initialize storage
  Future<void> init() async {
    storage = await SecureStorageService.getInstance();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      user = await _repository.login(email, password);

      if (user != null) {
        client.setAuthToken(user!.token);
        await storage.setJson("user", user!.toJson());
        SessionProvider().setUser(user!);
      } else {
        if (context.mounted) {
          showToast(context, isError: true, "Invalid credentials");
        }
      }
    } catch (e) {
      debugPrint("Login failed: $e");
      if (context.mounted) {
        showToast(context, isError: true, "An error occured, please try again");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String name, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      user = await _repository.register(email, name, password);
      if (user != null) {
        client.setAuthToken(user!.token);
        await storage.setJson("user", user!.toJson());
      }
    } catch (e) {
      debugPrint("Registration failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email, String operator) async {
    _isLoading = true;
    _successMessage = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _repository.forgotPassword(email, operator);
      if (success) {
        _successMessage = 'Password reset instructions sent to your email.';
      } else {
        _errorMessage = 'Failed to send reset instructions.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
