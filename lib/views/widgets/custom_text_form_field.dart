// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   final String initialValue;
//   final String labelText;
//   final String? Function(String?) validator;
//   final  Function(String?) onSaved;
//
//
//   const CustomTextFormField({
//     super.key,
//     required this.initialValue,
//     required this.labelText,
//     required this.validator,
//     required this.onSaved,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20.0.w,
//         right: 20.0.w,
//       ),
//       child: TextFormField(
//         initialValue: initialValue,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.r),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.primary,
//               width: 1.5.sp,
//             ),borderRadius: BorderRadius.all(
//             Radius.circular(10.r),
//           ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.primary,
//               width: 1.5.sp,
//             ),borderRadius: BorderRadius.all(
//             Radius.circular(10.r),
//           ),
//           ),
//         ),
//         validator: validator,
//         onSaved: onSaved,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.only(
        left: 20.0.w,
        right: 20.0.w,
      ),
      child: TextFormField(
        initialValue: initialValue,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5.sp,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5.sp,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
