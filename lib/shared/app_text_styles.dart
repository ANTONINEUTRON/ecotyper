import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle heading1(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        // color: const Color(0XFF1F1F1F),
      );

  static TextStyle heading2(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
        // color: const Color(0XFF1F1F1F),
  );

  static TextStyle heading3(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
        // color: const Color(0XFF1F1F1F),
  );

  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
        // color: const Color(0XFF1F1F1F),
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
        // color: const Color(0XFF1F1F1F),
  );

}
