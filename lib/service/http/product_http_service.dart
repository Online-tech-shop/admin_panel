import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uzum_market_admin_panel/models/product_model.dart';

class ProductHttpService {
  final Uri _url = Uri.parse(
      'https://uzum-market-81608-default-rtdb.firebaseio.com/product.json');

  Future<List<Product>> getProducts() async {
    try {
      final http.Response response = await http.get(_url);
      if (response.body == 'null') {
        throw 'null';
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<Product> loadedProducts = [];
        data.forEach(
          (key, value) {
            value['id'] = key;
            loadedProducts.add(Product.fromJson(value));
          },
        );
        for(var each in loadedProducts){
          print(each.id + ' bu id');
        }
        return loadedProducts;
      }
      throw Exception('error: ProductHttpService().getProduct()');
    } catch (e) {
      debugPrint('error: ProductHttpService().getProduct(): $e');
      rethrow;
    }
  }

  Future<Product> addProduct({
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
      Map<String, dynamic> productData = {
        'name': name,
        'images': images,
        'price': price,
        'category': category,
        'seller': seller,
        'order-amount': 0,
        'bought-amount-this-week': 0,
        'about-product': aboutProduct,
        'sale-type': saleType,
        'briefly-about-product': brieflyAboutProduct,
      };
      final http.Response response = await http.post(
        _url,
        body: jsonEncode(productData),
      );
      productData['id'] = jsonDecode(response.body)['name'];
      return Product.fromJson(productData);
    } catch (e) {
      debugPrint('error: ProductHttpService().addProduct(): $e');
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
      Map<String, dynamic> updatedData = {
        'name': name,
        'price': price,
        'category': category,
        'images': images,
        'seller': seller,
        'order-amount': orderAmount,
        'bought-amount-this-week': boughtAmountThisWeek,
        'about-product': aboutProduct,
        'sale-type': saleType,
        'briefly-about-product': brieflyAboutProduct,
      };

      final Uri editUrl = Uri.parse(
          'https://uzum-market-81608-default-rtdb.firebaseio.com/product/$id.json');
      final http.Response response = await http.patch(
        editUrl,
        body: jsonEncode(updatedData),
      );

      if (response.statusCode != 200) {
        throw Exception('error: ProductHttpService().editProduct()');
      }
    } catch (e) {
      debugPrint('error: ProductHttpService().editProduct(): $e');
      rethrow;
    }
  }

  Future<void> deleteProduct({required String id}) async {
    try {
      final Uri deleteUrl = Uri.parse(
        'https://uzum-market-81608-default-rtdb.firebaseio.com/product/$id.json',
      );
      final response = await http.delete(deleteUrl);
      debugPrint(response.body);
    } catch (e) {
      debugPrint('error: ProductHttpService().deleteProduct(): $e');
      rethrow;
    }
  }
}
