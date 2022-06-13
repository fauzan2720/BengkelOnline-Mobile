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
    // String? pin,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        fullname: fullname,
        phoneNumber: phoneNumber,
        email: email,
        // pinNumber: pin,
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

  Future<bool> update({
    var token,
    String? fullname,
    String? phoneNumber,
    // String? pinNumber,
  }) async {
    try {
      UserModel user = await AuthService().update(
        token: token,
        fullname: fullname,
        phoneNumber: phoneNumber,
        // pinNumber: pinNumber,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePassword({
    required String token,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().updatePassword(
        token: token,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout(
    String token,
  ) async {
    try {
      if (await AuthService().logout(
        token: token,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
