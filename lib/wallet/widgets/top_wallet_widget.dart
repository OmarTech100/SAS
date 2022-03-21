import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TopWalletWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Function()? addBalance;

  TopWalletWidget({this.onPressed, this.addBalance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.w.h,
            ),
          ),
          SizedBox(width: 30.w),
          Spacer(),
          Text(
            LocaleKeys.myWallet.tr(),
            style: TextStyle(
                fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 20.w),
          Text(LocaleKeys.addBalance.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              )),
          IconButton(
              onPressed: addBalance,
              icon: Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 30.w.h,
              )),
        ],
      ),
    );
  }
}
