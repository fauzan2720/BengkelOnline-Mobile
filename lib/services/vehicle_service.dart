import 'dart:convert';
import 'dart:html';
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
    File? file,
    String filename,
    String token,
    String vehicleName,
    String numberPlate,
    // String photoUrl,
  ) async {
    var url = '$baseUrl/vehicles';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    var pic = await http.MultipartFile.fromPath('photo_url', filename);

    request.files.add(pic);

    // await request.send().then((result) {

    //   http.Response.fromStream(result).then((response) {

    //     var message = jsonDecode(response.body);
    //   });
    // });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    // request.files.add(
    //   http.MultipartFile(
    //     'file',
    //     file.readAsBytes().asStream(),
    //     file.lengthSync(),
    //     filename: filename,
    //     // contentType: MediaType('image', 'jpeg'),
    //   ),
    // );
    // request.headers.addAll(headers);
    // request.fields
    //     .addAll({"name": "test", "email": "test@gmail.com", "id": "12345"});
    // print("request: " + request.toString());
    // var res = await request.send();
    // print("This is response:" + res.toString());

    var body = jsonEncode({
      'vehicle_name': vehicleName,
      'number_plate': numberPlate,
      // 'photo_url': photoUrl,
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

  // Future<int> createVehicle({
  //   File? file,
  //   String? filename,
  //   String? token,
  // }) async {
  //   var url = '$baseUrl/vehicles';

  //   ///MultiPart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(url),
  //   );
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer $token",
  //     "Content-type": "multipart/form-data"
  //   };
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       file?.readAsBytes().asStream(),
  //       file.lengthSync(),
  //       filename: filename,
  //       contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields
  //       .addAll({"name": "test", "email": "test@gmail.com", "id": "12345"});
  //   print("request: " + request.toString());
  //   var res = await request.send();
  //   print("This is response:" + res.toString());
  //   return res.statusCode;
  // }

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
