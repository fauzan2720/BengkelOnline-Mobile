import 'package:bengkel_online/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? productName;
  String? productCategory;
  double? price;
  String? stock;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.productName,
    this.productCategory,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productCategory = json['product_category'];
    price = double.parse(json['price'].toString());
    stock = json['stock'];
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
      'product_category': productCategory,
      'price': price,
      'stock': stock,
      'galleries': galleries?.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
