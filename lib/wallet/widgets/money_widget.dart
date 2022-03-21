import 'package:flutter/material.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MoneyWidget extends StatelessWidget {
  final String money;
 

  MoneyWidget({required this.money});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Text(
      '${LocaleKeys.sar.tr()} ''$money',
      style: TextStyle(
          fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    SizedBox(height: 10.h),
    
      ],
    );
  }
}
