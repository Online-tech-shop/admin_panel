import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on int {
  Widget height() => SizedBox(height: h);
  Widget width() => SizedBox(width: w);
}
