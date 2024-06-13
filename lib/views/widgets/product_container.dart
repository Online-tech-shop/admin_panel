import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/utils/extension/sized_box_extension.dart';
import 'package:uzum_market_admin_panel/utils/routes.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  final List<Review> reviews;

  const ProductContainer({
    super.key,
    required this.product,
    required this.reviews,
  });
  @override
  Widget build(BuildContext context) {
    List<Review> productReviews = product.getReviews(reviews);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: {
          'product': product,
          'product-reviews': productReviews,
          'is-edit-product': true,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.images[0],
            width: 150.w,
            height: 200.h,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return SizedBox(
                  width: 150.w,
                  height: 200.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              }
            },
          ),
          8.height(),
          Text(
            product.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${product.price} so\'m',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text('${productReviews.length} sharhlar'),
        ],
      ),
    );
  }
}
