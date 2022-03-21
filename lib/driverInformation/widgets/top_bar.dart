import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TopBar extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  TopBar({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: onPressed,
                    child: Text(
                      LocaleKeys.Cancel.tr(),
                      style: TextStyle(
                        color: blue,
                        fontSize: 16.sp,
                      ),
                    ),
                  )),
            ),
            Expanded(
                flex: 3,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 17.sp),
                    ))),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    ));
  }
}
