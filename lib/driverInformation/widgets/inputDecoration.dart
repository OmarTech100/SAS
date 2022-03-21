import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration personalInfoInputDecoration(
    {required String hintText, Widget? prefixIcon, String? labelText}) {
  return InputDecoration(
  
    counter: Container(),
    alignLabelWithHint: true,
    labelText: labelText,
    hintText: hintText,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey.shade100,
    prefixIcon: prefixIcon,
  );
}
