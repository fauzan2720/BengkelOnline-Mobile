import 'dart:convert';
import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/util/app_constants.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = AppConstants.baseUrl;

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products?current_page=1&limit=6';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<List<ProductModel>> getProductOils() async {
    var url = '$baseUrl/products?product_category=Oli';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
