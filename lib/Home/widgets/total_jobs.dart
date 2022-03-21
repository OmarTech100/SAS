import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalJobsWidget extends StatelessWidget {
  final String totalJobs;

  TotalJobsWidget({required this.totalJobs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            ordersIcon,
            height: 30.h,
          ),
          Text(
            LocaleKeys.ttlJobs.tr(),
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          // SizedBox(width: 20.w),
          Text(
            totalJobs,
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          // SizedBox(width: 5),
        ],
      ),
    );
  }
}
