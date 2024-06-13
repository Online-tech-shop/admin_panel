import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/product_view_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/review_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/product_container.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductViewModel _productViewModel = ProductViewModel();
  final ReviewViewModel _reviewViewModel = ReviewViewModel();
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getReviews() async {
    _reviews = await _reviewViewModel.getReviews();
  }

  void onProductEdited() => setState(() {});

  @override
  Widget build(BuildContext context) {
    getReviews();
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        return Future<void>.delayed(
          const Duration(seconds: 0),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0.w,
          right: 20.0.w,
          top: 20.h,
        ),
        child: FutureBuilder(
          future: _productViewModel.fetchProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  strokeWidth: 5,
                ),
              );
            } else if (!snapshot.hasData || snapshot.hasError) {
              if (snapshot.error == 'null') {
                return const Center(
                  child: Text(
                    'Ma\'lumotlar bazasida mahsulotlar mavjud emas',
                  ),
                );
              } else {
                return Center(
                  child: Text('error in product snapshot: ${snapshot.error}'),
                );
              }
            } else {
              final List<Product> productList = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductContainer(
                    product: productList[index],
                    reviews: productList[index].getReviews(_reviews),
                    onProductEdited: onProductEdited,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
