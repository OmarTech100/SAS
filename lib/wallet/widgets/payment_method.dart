import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodWidgeet extends StatelessWidget {
  final Function()? onTap;

  PaymentMethodWidgeet({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 330.w,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: Offset.fromDirection(20, 4),
              color: Colors.grey.shade300,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(addPaymentIcon),
            // SizedBox(width: 15),
            Text(
              LocaleKeys.paymentMethod.tr(),
              style: TextStyle(fontSize: 23.sp),
            ),
            // Spacer(),
            SizedBox(width: 15.w),

            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
              size: 35.w.h,
            )
          ],
        ),
      ),
    );
  }
}
