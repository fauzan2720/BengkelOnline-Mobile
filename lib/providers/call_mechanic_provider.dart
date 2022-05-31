import 'package:bengkel_online/models/call_mechanic_model.dart';
import 'package:bengkel_online/services/call_mechanic_service.dart';
import 'package:flutter/material.dart';

class CallMechanicProvider with ChangeNotifier {
  List<CallMechanicModel> _callMechanics = [];

  List<CallMechanicModel> get callMechanics => _callMechanics;

  set callMechanics(List<CallMechanicModel> callMechanics) {
    _callMechanics = callMechanics;
    notifyListeners();
  }

  Future<void> getCallMechanic(
    String token,
  ) async {
    try {
      List<CallMechanicModel> callMechanics =
          await CallMechanicService().getCallMechanic(token);
      _callMechanics = callMechanics;
    } catch (e) {
      print(e);
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
    try {
      if (await CallMechanicService().callMechanic(
        token,
        vehicleId,
        locationId,
        typeOfWork,
        detailProblem,
        paymentMethod,
        totalPayment,
      )) {
        _callMechanics = callMechanics;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
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
    try {
      if (await CallMechanicService().callMechanicWithProduct(
        token,
        vehicleId,
        locationId,
        productId,
        typeOfWork,
        detailProblem,
        paymentMethod,
        totalPayment,
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
