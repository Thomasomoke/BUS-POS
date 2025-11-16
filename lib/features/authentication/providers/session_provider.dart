import 'package:bus_pos/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  UserModel? user;

  bool get isLoggedIn => user != null;

  void setUser(UserModel u) {
    user = u;
    notifyListeners();
  }
}
