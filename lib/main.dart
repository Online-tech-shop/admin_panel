import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/utils/routes.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6F00FF),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6F00FF),
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
