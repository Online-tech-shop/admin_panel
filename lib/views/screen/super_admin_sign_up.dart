import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/viewmodel/admin_login_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/custom_button_style.dart';
import 'package:uzum_market_admin_panel/views/widgets/main_logo.dart';

class SuperAdminSignUp extends StatefulWidget {
  const SuperAdminSignUp({super.key});

  @override
  State<SuperAdminSignUp> createState() => _SuperAdminSignUpState();
}

class _SuperAdminSignUpState extends State<SuperAdminSignUp> {
  final AdminLoginViewModel _authViewmodel = AdminLoginViewModel();

  final TextEditingController _passwordOneController = TextEditingController();

  final TextEditingController _passwordTwoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String email = '';

  String password = '';

  void onSubmitPressed(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _authViewmodel
          .registerNewAdmin(email: email, password: password)
          .then((value) {
        _emailController.clear();
        _passwordOneController.clear();
        _passwordTwoController.clear();
        email = '';
        password = '';

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Yangi admin muvaffaqiyatli qo\'shildi'),
          ),
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error.toString(),
                ),
              ],
            ),
          ),
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _passwordOneController.dispose();
    _passwordTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUPER ADMIN'),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !RegExp(
                            "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*\$",
                          ).hasMatch(value)) {
                        return 'Yaroqli elektron pochta manzilini kiriting';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      email = newValue ?? '';
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    controller: _passwordOneController,
                    decoration: const InputDecoration(
                      hintText: 'Parol',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Yaroqli parolni kiriting';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    controller: _passwordTwoController,
                    decoration: const InputDecoration(
                      hintText: 'Parol',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Yaroqli parolni kiriting';
                      } else if (_passwordOneController.text !=
                          _passwordTwoController.text) {
                        return 'Parol o\'xshash bo\'lishi kerak';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      password = newValue ?? '';
                    },
                  ),
                ],
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () => onSubmitPressed(context),
                    child: const CustomButtonStyle(
                      buttonText: 'Ro\'yxatdan o\'tish',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
