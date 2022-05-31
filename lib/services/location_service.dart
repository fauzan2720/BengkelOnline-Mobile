import 'dart:convert';
import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class LocationService {
  String baseUrl = AppConstants.baseUrl;

  Future<List<LocationModel>> getLocations(
    String token,
  ) async {
    var url = '$baseUrl/locations';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<LocationModel> locations = [];

      for (var item in data) {
        locations.add(LocationModel.fromJson(item));
      }

      return locations;
    } else {
      throw Exception('Gagal Get Locations!');
    }
  }

  Future<List<LocationModel>> resultLocation(
    String token,
    String id,
  ) async {
    var url = '$baseUrl/locations?id=$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<LocationModel> locations = [];

      for (var item in data) {
        locations.add(LocationModel.fromJson(item));
      }

      return locations;
    } else {
      throw Exception('Gagal Get Locations!');
    }
  }

  Future<bool> createLocation(
    String token,
    String address,
    String detailAddress,
  ) async {
    var url = '$baseUrl/locations';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'address': address,
      'detail_address': detailAddress,
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
      throw Exception('Gagal Membuat Alamat Rumah Baru');
    }
  }

  Future<bool> updateLocation(
    String token,
    String id,
    String address,
    String detailAddress,
  ) async {
    var url = '$baseUrl/locations/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'address': address,
      'detail_address': detailAddress,
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
      throw Exception('Gagal Memperbarui Alamat Rumah');
    }
  }

  Future<bool> deleteLocation(
    String token,
    String id,
  ) async {
    var url = '$baseUrl/locations/$id';
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
      throw Exception('Gagal Menghapus Alamat Rumah');
    }
  }
}
