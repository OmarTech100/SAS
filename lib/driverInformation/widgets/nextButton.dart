import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              offset: Offset.fromDirection(1.0, 2.0),
              blurRadius: 1.0,
              color: grey,
            ),
          ],
        ),
        child: Text(
          'NEXT',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
