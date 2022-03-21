import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HistoryTopWidget extends StatelessWidget {
  final void Function()? onPressed;

  HistoryTopWidget({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
             
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    Icons.arrow_back,
                    color: blue,
                    size: 30.h.w,
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.history.tr(),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
