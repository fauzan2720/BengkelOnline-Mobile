import 'dart:convert';

import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class CallMechanicService {
  String baseUrl = AppConstants.baseUrl;

  Future<List<CallMechanicModel>> getCallMechanic(
    String token,
    // int id,
  ) async {
    var url = '$baseUrl/call?id=1';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CallMechanicModel> callMechanic = [];

      for (var item in data) {
        callMechanic.add(CallMechanicModel.fromJson(item));
      }

      return callMechanic;
    } else {
      throw Exception('Gagal Get Mechanic!');
    }
  }

  Future<bool> callMechanic(
    String token,
    String vehicleId,
    String locationId,
    String typeOfWork,
    String detailProblem,
    String paymentMethod,
    double totalPayment,
  ) async {
    var url = '$baseUrl/call';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer' + token,
    };
    var body = jsonEncode({
      'vehicle_id': vehicleId,
      'location_id': locationId,
      'type_of_work': typeOfWork,
      'detail_problem': detailProblem,
      'payment_method': paymentMethod,
      'total_payment': totalPayment,
      'status': 'perjalanan',
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Memanggil Mekanik');
    }
  }

  Future<bool> callMechanicWithProduct(
    String token,
    String vehicleId,
    String locationId,
    String productId,
    String typeOfWork,
    String detailProblem,
    String paymentMethod,
    double totalPayment,
  ) async {
    var url = '$baseUrl/call';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer' + token,
    };
    var body = jsonEncode({
      'vehicle_id': vehicleId,
      'location_id': locationId,
      'product_id': productId,
      'type_of_work': typeOfWork,
      'detail_problem': detailProblem,
      'payment_method': paymentMethod,
      'total_payment': totalPayment,
      'status': 'perjalanan',
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Memanggil Mekanik');
    }
  }
}
