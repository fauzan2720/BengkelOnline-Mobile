import 'package:bengkel_online/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:bengkel_online/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? fullname,
    String? phoneNumber,
    String? email,
    int? pin,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        fullname: fullname,
        phoneNumber: phoneNumber,
        email: email,
        pinNumber: pin,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
