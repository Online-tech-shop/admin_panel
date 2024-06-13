import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/service/http/product_http_service.dart';

class ProductViewModel {
  final ProductHttpService _productHttpService = ProductHttpService();

  Future<List<Product>> fetchProducts() async {
    try {
      return await _productHttpService.getProducts();
    } catch (e) {
      debugPrint('error: ProductViewModel().fetchProducts(): $e');
      rethrow;
    }
  }

  Future<void> addNewProduct({
    required String name,
    required int price,
    required int category,
    required List<String> images,
    required String seller,
    required String aboutProduct,
    required List<int> saleType,
    required List<String> brieflyAboutProduct,
  }) async {
    try {
      _productHttpService.addProduct(
        name: name,
        price: price,
        category: category,
        images: images,
        seller: seller,
        aboutProduct: aboutProduct,
        saleType: saleType,
        brieflyAboutProduct: brieflyAboutProduct,
      );
    } catch (e) {
      debugPrint('error: ProductViewModel().addNewProduct(): $e');
      rethrow;
    }
  }

  Future<void> editProduct({
    required String id,
    required String name,
    required int price,
    required int category,
    required List<String> images,
    required String seller,
    required int orderAmount,
    required int boughtAmountThisWeek,
    required String aboutProduct,
    required List<int> saleType,
    required List<String> brieflyAboutProduct,
  }) async {
    try {
      await _productHttpService.editProduct(
        id: id,
        name: name,
        price: price,
        category: category,
        images: images,
        seller: seller,
        orderAmount: orderAmount,
        boughtAmountThisWeek: boughtAmountThisWeek,
        aboutProduct: aboutProduct,
        saleType: saleType,
        brieflyAboutProduct: brieflyAboutProduct,
      );
    } catch (e) {
      debugPrint('error: ProductViewModel().editProduct(): $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productHttpService.deleteProduct(id: id);
    } catch (e) {
      debugPrint('error: ProductViewModel().deleteProduct(): $e');

      rethrow;
    }
  }
}
