import 'package:bengkel_online/models/product_model.dart';
import 'package:bengkel_online/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _allProduct = [];
  List<ProductModel> _productoils = [];

  List<ProductModel> get products => _products;
  List<ProductModel> get allProduct => _allProduct;
  List<ProductModel> get productoils => _productoils;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  set allProduct(List<ProductModel> allProduct) {
    _allProduct = allProduct;
    notifyListeners();
  }

  set productoils(List<ProductModel> productoils) {
    _productoils = productoils;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllProducts() async {
    try {
      List<ProductModel> allProduct = await ProductService().getAllProducts();
      _allProduct = allProduct;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProductOils() async {
    try {
      List<ProductModel> productoils = await ProductService().getProductOils();
      _productoils = productoils;
    } catch (e) {
      print(e);
    }
  }
}
