import 'package:bengkel_online/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? productName;
  double? price;
  int? trends;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.productName,
    this.price,
    this.trends,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = double.parse(json['price'].toString());
    trends = json['trends'];
    galleries = json['galleries']
        .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'trends': trends,
      'galleries': galleries?.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
