import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String? Function(String?) validator;
  final Function(String?) onSaved;

  const CustomTextFormField({
    super.key,
    required this.initialValue,
    required this.labelText,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: TextFormField(
        initialValue: initialValue,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
