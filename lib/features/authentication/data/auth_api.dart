import 'dart:convert';

import 'package:bus_pos/core/services/http_client.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';

class AuthApi {
  final HttpClient client;
  final String baseUrl = 'https://omtravel.com/api';

  AuthApi({required this.client});

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      '$baseUrl/users/auth/login',
      body: {"email": email, "password": password},
    );

    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<UserModel> register(String email, String name, String password) async {
    final response = await client.post(
      '$baseUrl/auth/register',
      body: {"email": email, "name": name, "password": password},
    );

    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> forgotPassword(
    String email,
    String operator,
  ) async {
    final response = await client.post(
      '$baseUrl/users/auth/forgot-password',
      body: {"email": email, "operator": operator},
    );

    return jsonDecode(response.body);
  }
}
