import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AddNewCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w.h),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: Row(
        children: [
          SvgPicture.asset(
            paymentIcon,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 14.w),
          Text(
            LocaleKeys.addNewCard.tr(),
            style: TextStyle(fontSize: 20.sp),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey,
            size: 30.h.w,
          )
        ],
      ),
    );
  }
}
