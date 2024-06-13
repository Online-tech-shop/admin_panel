import 'package:flutter/cupertino.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/views/screen/edit_product_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/home_screen.dart';

class RouteName {
  static const String home = '/home';
  static const String allProducts = '/allProductsScreen';
  static const String product = '/manageProductScreen';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.product:
      Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (BuildContext context) => ManageProductScreen(
          product: data['product'] as Product,
          productReviews: data['product-reviews'] as List<Review>,
          onProductEdited: data['on-product-edited'] as Function(),
        ),
      );
    default:
      return CupertinoPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      );
  }
}
