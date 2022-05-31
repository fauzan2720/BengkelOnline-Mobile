import 'package:bengkel_online/models/location_model.dart';
import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/models/vehicle_model.dart';

class CallMechanicModel {
  int? id;
  String? typeOfWork;
  String? detailProblem;
  String? paymentMethod;
  double? totalPayment;
  String? status;
  late VehicleModel? vehicle;
  late LocationModel? location;
  late ProductModel? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  CallMechanicModel({
    this.id,
    this.typeOfWork,
    this.detailProblem,
    this.paymentMethod,
    this.totalPayment,
    this.status,
    this.vehicle,
    this.location,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  CallMechanicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfWork = json['type_of_work'];
    detailProblem = json['detail_problem'];
    paymentMethod = json['payment_method'];
    totalPayment = json['total_payment'];
    status = json['status'];
    vehicle = VehicleModel.fromJson(json['vehicle']);
    location = LocationModel.fromJson(json['location']);
    product = ProductModel.fromJson(json['location']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_of_work': typeOfWork,
      'detail_problem': detailProblem,
      'payment_method': paymentMethod,
      'total_payment': totalPayment,
      'status': status,
      'vehicle': vehicle?.toJson(),
      'location': location?.toJson(),
      'product': product?.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
