import 'package:uzum_market_admin_panel/models/review_model.dart';

class Product {
  final String id;
  String name;
  int price;
  int category;
  List<String> images;
  final String seller;
  int orderAmount;
  int boughtAmountThisWeek;
  String aboutProduct;
  List<int> saleType;
  List<String> brieflyAboutProduct;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.images,
    required this.seller,
    required this.orderAmount,
    required this.boughtAmountThisWeek,
    required this.aboutProduct,
    required this.saleType,
    required this.brieflyAboutProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      images: List<String>.from(json['images']),
      seller: json['seller'],
      orderAmount: json['order-amount'],
      boughtAmountThisWeek: json['bought-amount-this-week'],
      aboutProduct: json['about-product'],
      saleType: List<int>.from(
        json['sale-type'].map((item) => item as int),
      ),
      brieflyAboutProduct: List<String>.from(
        json['briefly-about-product'],
      ),
    );
  }

  List<Review> getReviews(List<Review> reviews) {
    return reviews.where((Review review) => review.productId == id).toList();
  }
}
