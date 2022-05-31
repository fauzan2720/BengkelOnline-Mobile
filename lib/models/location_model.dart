import 'package:bengkel_online/models/user_model.dart';

class LocationModel {
  int? id;
  String? address;
  String? detailAddress;
  late UserModel? user;
  DateTime? createdAt;
  DateTime? updatedAt;

  LocationModel({
    this.id,
    this.address,
    this.detailAddress,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    detailAddress = json['detail_address'];
    user = UserModel.fromJson(json['user']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'detail_address': detailAddress,
      'user': user?.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
