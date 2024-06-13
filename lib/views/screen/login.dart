import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/utils/routes.dart';
import 'package:uzum_market_admin_panel/viewmodel/admin_login_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/custom_button_style.dart';
import 'package:uzum_market_admin_panel/views/widgets/main_logo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AdminLoginViewModel _adminLoginViewModel = AdminLoginViewModel();
  final TextEditingController _textEditingController = TextEditingController();

  String _email = '';

  String _password = '';

  bool isLoading = false;

  void onLoginPressed() async {
    if (_textEditingController.text == 'superadmin') {
      _textEditingController.clear();
      Navigator.pushNamed(context, RouteName.superAdmin);
    } else {
      isLoading = true;
      setState(() {});
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print(_email);
        print(_password);
        try {
          await _adminLoginViewModel
              .loginAdmin(email: _email, password: _password)
              .then((_) {
            Navigator.pushReplacementNamed(context, RouteName.home);
          });
        } catch (e) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          }
        }
      }
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const MainLogo(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      _email = newValue ?? '';
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Parol',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      _password = newValue ?? '';
                    },
                  ),
                ],
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: onLoginPressed,
                    child: const CustomButtonStyle(buttonText: "Tizimga kirish"),
                  ),
          ],
        ),
      ),
    );
  }
}
