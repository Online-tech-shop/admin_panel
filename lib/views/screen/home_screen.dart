import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:uzum_market_admin_panel/service/http/product_http_service.dart';
import 'package:uzum_market_admin_panel/service/http/review_http_service.dart';
import 'package:uzum_market_admin_panel/views/screen/add_product_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/all_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = const [
    ProductsScreen(),
    AddProductScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    ReviewHttpService().addReview();
    // ProductHttpService().addProduct(
    //   name: 'name',
    //   price: 100,
    //   category: 0,
    //   images: ['https://images.uzum.uz/cbuusacff5b729kv6udg/original.jpg'],
    //   seller: 'seller',
    //   aboutProduct: 'aboutProduct',
    //   saleType: [0],
    //   brieflyAboutProduct: ['brieflyAboutProduct'],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin panel',
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        items: <SalomonBottomBarItem>[
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('Barcha mahsulotlar'),
            selectedColor: Theme.of(context).colorScheme.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add),
            title: const Text('Mahsulot qo\'shish'),
            selectedColor: const Color(0xFF6F00FF),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int value) => setState(() => _currentIndex = value),
      ),
    );
  }
}
