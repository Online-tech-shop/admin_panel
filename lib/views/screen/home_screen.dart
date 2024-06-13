import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin panel',
        ),
        leading: Padding(
          padding: EdgeInsets.all(5.0.sp),
          child: Image.asset('assets/images/uzum_logo.jpeg'),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
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
        ],
        currentIndex: _currentIndex,
        onTap: (int value) => setState(() => _currentIndex = value),
      ),
    );
  }
}
