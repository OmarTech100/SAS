import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryReportWidget extends StatelessWidget {
  final int totalJops;
  final double totalEarned;

  HistoryReportWidget({required this.totalJops, required this.totalEarned});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h.w),
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constrains) => Container(
                alignment: Alignment.center,
                child: ListTile(
                  leading: SvgPicture.asset(carIcon, height: 38.h),
                  title: Text(
                    LocaleKeys.ttlJobs.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    totalJops.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r), color: blue),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constrains) => Container(
                alignment: Alignment.center,
                child: ListTile(
                  leading: SvgPicture.asset(moneyIcon, height: 45.h),
                  title: Text(
                    LocaleKeys.ttlEarn.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    '$totalEarned' ' ${LocaleKeys.sar.tr()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                height: 200.h,
                // width: 300.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
