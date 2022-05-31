import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/services/location_service.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  List<LocationModel> _locations = [];

  List<LocationModel> get locations => _locations;

  set locations(List<LocationModel> locations) {
    _locations = locations;
    notifyListeners();
  }

  Future<void> getLocations(
    String token,
  ) async {
    try {
      List<LocationModel> locations =
          await LocationService().getLocations(token);
      _locations = locations;
    } catch (e) {
      print(e);
    }
  }

  Future<void> resultLocation(
    String token,
    String id,
  ) async {
    try {
      List<LocationModel> locations =
          await LocationService().resultLocation(token, id);
      _locations = locations;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createLocation(
    String token,
    String address,
    String detailAddress,
  ) async {
    try {
      if (await LocationService().createLocation(
        token,
        address,
        detailAddress,
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

  Future<bool> updateLocation(
    String token,
    String id,
    String address,
    String detailAddress,
  ) async {
    try {
      if (await LocationService().updateLocation(
        token,
        id,
        address,
        detailAddress,
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

  Future<bool> deleteLocation(
    String token,
    String id,
  ) async {
    try {
      if (await LocationService().deleteLocation(
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
