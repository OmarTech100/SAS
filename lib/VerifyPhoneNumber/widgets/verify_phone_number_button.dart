import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onTap;
  SignInButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.red.shade200,
      splashColor: Colors.red.shade200,
      focusColor: Colors.red.shade200,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        height: 60.h,
        width: double.infinity,
        child: Text(
          LocaleKeys.next.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
