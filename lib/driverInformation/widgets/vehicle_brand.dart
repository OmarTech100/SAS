import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleBrand extends StatelessWidget {
  final onPressed;
  final String type;
  VehicleBrand({required void Function()? this.onPressed, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        LocaleKeys.carType.tr(),
        style: TextStyle(color: Colors.grey),
      ),
      SizedBox(height: 10.h),
      GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
                Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
