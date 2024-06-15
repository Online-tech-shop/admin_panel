import 'package:flutter/material.dart';

class CustomButtonStyle extends StatelessWidget {
  final String buttonText;

  const CustomButtonStyle({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(buttonText),
        ],
      ),
    );
  }
}
