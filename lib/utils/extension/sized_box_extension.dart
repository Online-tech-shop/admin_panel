import 'package:flutter/material.dart';

extension SizedBoxExtension on int {
  Widget height() => SizedBox(height: this.toDouble());
  Widget width() => SizedBox(width: this.toDouble());
}
