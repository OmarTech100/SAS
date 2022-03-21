import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoursOnlineWidget extends StatelessWidget {
  final String totalOnlineHours;

  HoursOnlineWidget({required this.totalOnlineHours});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          timeIcon,
          height: 30.h,
        ),
        SizedBox(height: 5.h),
        Text(
          totalOnlineHours,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          LocaleKeys.hoursOnline.tr(),
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ],
    );
  }
}
