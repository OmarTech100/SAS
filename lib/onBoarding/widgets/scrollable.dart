import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> pages = [
  Padding(
    padding: EdgeInsets.only(left: 40.w, right: 40.w),
    child: SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: 80.h),
          SvgPicture.asset(
            signInLogo,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          SizedBox(height: 70.h),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.onBoarding_1stPage1.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  LocaleKeys.onBoarding_1stPage2.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
  Padding(
    padding: EdgeInsets.only(left: 40.w, right: 40.w),
    child: SafeArea(
      bottom: false,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(child: Container(height: 80.h)),
            SvgPicture.asset(
              internetLogo,
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
            SizedBox(height: 70.h),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.onBoarding_2ndPage1.tr(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    LocaleKeys.onBoarding_2ndPage2.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    ),
  ),
  Padding(
    padding: EdgeInsets.only(left: 40.w, right: 40.w),
    child: SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: 80.h),
          SvgPicture.asset(
            startUp,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          SizedBox(height: 70.h),
          Text(
            LocaleKeys.onBoarding_3rdPage1.tr(),
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            child: Text(
              LocaleKeys.onBoarding_3rdPage2.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
];
