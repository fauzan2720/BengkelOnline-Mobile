// import 'dart:html';

import 'package:bengkel_online/models/vehicle_model.dart';
import 'package:bengkel_online/services/vehicle_service.dart';
import 'package:flutter/material.dart';

class VehicleProvider with ChangeNotifier {
  List<VehicleModel> _vehicles = [];

  List<VehicleModel> get vehicles => _vehicles;

  set vehicles(List<VehicleModel> vehicles) {
    _vehicles = vehicles;
    notifyListeners();
  }

  Future<void> getVehicles(
    String token,
  ) async {
    try {
      List<VehicleModel> vehicles = await VehicleService().getVehicles(token);
      _vehicles = vehicles;
    } catch (e) {
      print(e);
    }
  }

  Future<void> resultVehicles(
    String token,
    String id,
  ) async {
    try {
      List<VehicleModel> vehicles =
          await VehicleService().resultVehicles(token, id);
      _vehicles = vehicles;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createVehicle(
    // File? file,
    // String filename,
    String token,
    String vehicleName,
    String numberPlate,
    String photoUrl,
  ) async {
    try {
      if (await VehicleService().createVehicle(
        // file,
        // filename,
        token,
        vehicleName,
        numberPlate,
        photoUrl,
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

  Future<bool> updateVehicle(
    String token,
    String id,
    String vehicleName,
    String numberPlate,
    String photoUrl,
  ) async {
    try {
      if (await VehicleService().updateVehicle(
        token,
        id,
        vehicleName,
        numberPlate,
        photoUrl,
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

  Future<bool> deleteVehicle(
    String token,
    String id,
  ) async {
    try {
      if (await VehicleService().deleteVehicle(
        token,
        id,
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
