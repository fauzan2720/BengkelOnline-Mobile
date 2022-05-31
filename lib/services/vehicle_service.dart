import 'dart:convert';
import 'package:bengkel_online/models/vehicle_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  String baseUrl = AppConstants.baseUrl;

  Future<List<VehicleModel>> getVehicles(
    String token,
  ) async {
    var url = '$baseUrl/vehicles';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<VehicleModel> vehicles = [];

      for (var item in data) {
        vehicles.add(VehicleModel.fromJson(item));
      }

      return vehicles;
    } else {
      throw Exception('Gagal Get Vehicles!');
    }
  }

  Future<List<VehicleModel>> resultVehicles(
    String token,
    String id,
  ) async {
    var url = '$baseUrl/vehicles?id=$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['data'];
      List<VehicleModel> vehicles = [];

      for (var item in data) {
        vehicles.add(VehicleModel.fromJson(item));
      }

      return vehicles;
    } else {
      throw Exception('Gagal Get Vehicles!');
    }
  }

  Future<bool> createVehicle(
    String token,
    String vehicleName,
    String numberPlate,
    String photoUrl,
  ) async {
    var url = '$baseUrl/vehicles';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'vehicle_name': vehicleName,
      'number_plate': numberPlate,
      'photo_url': photoUrl,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Membuat Kendaraan Baru');
    }
  }

  Future<bool> updateVehicle(
    String token,
    String id,
    String vehicleName,
    String numberPlate,
    String photoUrl,
  ) async {
    var url = '$baseUrl/vehicles/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'vehicle_name': vehicleName,
      'number_plate': numberPlate,
      'photo_url': photoUrl,
    });

    var response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Memperbarui Kendaraan');
    }
  }

  Future<bool> deleteVehicle(
    String token,
    String id,
  ) async {
    var url = '$baseUrl/vehicles/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Menghapus Kendaraan');
    }
  }
}
