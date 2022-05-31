import 'dart:convert';

import 'package:bengkel_online/models/user_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = AppConstants.baseUrl;

  Future<UserModel> register({
    String? fullname,
    String? phoneNumber,
    String? email,
    String? pinNumber,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'fullname': fullname,
      'phone_number': phoneNumber,
      'email': email,
      'pin_number': pinNumber,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> update({
    required String token,
    required String fullname,
    required String phoneNumber,
    required String pinNumber,
  }) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'fullname': fullname,
      'phone_number': phoneNumber,
      'pin_number': pinNumber,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      // AuthService().logout(token: token);

      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      // user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Update');
    }
  }

  Future<UserModel> updatePassword({
    required String token,
    required String password,
  }) async {
    var url = '$baseUrl/update-password';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      // AuthService().logout(token: token);

      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      // user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Update');
    }
  }

  Future<bool> logout({
    required String token,
  }) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Logout');
    }
  }
}
