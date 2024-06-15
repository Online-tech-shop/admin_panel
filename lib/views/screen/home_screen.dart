import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:uzum_market_admin_panel/service/http/review_http_service.dart';
import 'package:uzum_market_admin_panel/service/http/user_http_service.dart';
import 'package:uzum_market_admin_panel/views/screen/add_product_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/all_products_screen.dart';
import 'package:uzum_market_admin_panel/views/screen/manage_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages =  [
    ProductsScreen(),
    AddProductScreen(),
    ManageUserScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    ReviewHttpService().addReview();
    // UserHttpService().addUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin panel',
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset('assets/images/uzum_logo.jpeg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Foydalanuvchilarni boshqarish'),
            selectedColor: Colors.deepOrangeAccent,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int value) => setState(() => _currentIndex = value),
      ),
    );
  }
}
