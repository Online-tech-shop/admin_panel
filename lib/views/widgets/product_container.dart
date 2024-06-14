import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/utils/extension/sized_box_extension.dart';
import 'package:uzum_market_admin_panel/utils/routes.dart';

class ProductContainer extends StatefulWidget {
  final Product product;
  List<Review> reviews;
  final Function() onProductEdited;

  ProductContainer({
    super.key,
    required this.product,
    required this.reviews,
    required this.onProductEdited,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final List<Review>? data =
            await Navigator.pushNamed(context, RouteName.product, arguments: {
          'product': widget.product,
          'product-reviews': widget.reviews,
          'is-edit-product': true,
          'on-product-edited': widget.onProductEdited,
        });

        if (data != null) {
          widget.reviews = data;
          setState(() {});
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.product.images[0],
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
            widget.product.name[0],
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${widget.product.price} so\'m',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text('${widget.reviews.length} sharhlar'),
        ],
      ),
    );
  }
}
