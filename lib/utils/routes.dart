import 'package:flutter/cupertino.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/views/screen/edit_product_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/home_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/login.dart';
import 'package:uzum_market_admin_panel/views/screen/super_admin_sign_up.dart';

class RouteName {
  static const String home = '/home';
  static const String allProducts = '/allProductsScreen';
  static const String product = '/manageProductScreen';
  static const String superAdmin = '/superAdminScreen';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.product:
      Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
      return CupertinoPageRoute<List<Review>>(
        builder: (BuildContext context) => ManageProductScreen(
          product: data['product'] as Product,
          productReviews: data['product-reviews'] as List<Review>,
          onProductEdited: data['on-product-edited'] as Function(),
        ),
      );
    case RouteName.home:
      return CupertinoPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      );
    case RouteName.superAdmin:
      return CupertinoPageRoute(
        builder: (BuildContext context) => const SuperAdminSignUp(),
      );
    default:
      return CupertinoPageRoute(
        builder: (BuildContext context) => const Login(),
      );
  }
}
