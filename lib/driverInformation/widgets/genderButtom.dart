import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget genderButton({
  required String gender,
  required Color color,
  required Color textColor,
}) {
  return Container(
    width: 80.w,
    alignment: Alignment.center,
    height: 50.h,
    // width: 100,
    child: Text(
      gender,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: color,
    ),
  );
}
