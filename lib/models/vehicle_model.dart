import 'package:bengkel_online/models/user_model.dart';

class VehicleModel {
  int? id;
  String? vehicleName;
  String? numberPlate;
  String? photoUrl;
  late UserModel? user;
  DateTime? createdAt;
  DateTime? updatedAt;

  VehicleModel({
    this.id,
    this.vehicleName,
    this.numberPlate,
    this.photoUrl,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicle_name'];
    numberPlate = json['number_plate'];
    photoUrl = json['photo_url'];
    user = UserModel.fromJson(json['user']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_name': vehicleName,
      'number_plate': numberPlate,
      'photo_url': photoUrl,
      'user': user?.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
