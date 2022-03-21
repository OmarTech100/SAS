import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarPhotosCard extends StatefulWidget {
  final Function()? leftSide;
  final Function()? rightSide;
  final Function()? frontSide;
  final Function()? backSide;
  final File? imageLeft;
  final File? imageRight;
  final File? imageFront;
  final File? imageBack;

  CarPhotosCard(
      {required this.leftSide,
      required this.rightSide,
      required this.frontSide,
      required this.backSide,
      required this.imageBack,
      required this.imageFront,
      required this.imageLeft,
      required this.imageRight});

  @override
  _CarPhotosCardState createState() => _CarPhotosCardState();
}

class _CarPhotosCardState extends State<CarPhotosCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    width: 150.w,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10.r)),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.w.h),
                                child: Text(
                                  LocaleKeys.carImageFront.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.white,
                                height: .5.h,
                              ),
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 90.h,
                                      width: 150.w,
                                      child: widget.imageFront == null
                                          ? SvgPicture.asset(
                                              carFrontSide,
                                              color: Colors.black26,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.r),
                                                  bottomRight:
                                                      Radius.circular(10.r)),
                                              child: Image.file(
                                                  widget.imageFront!,
                                                  fit: BoxFit.fitWidth)),
                                    ),
                                    Container(
                                      // padding: EdgeInsets.all(8),
                                      height: 90.h,
                                      width: 150.w,
                                      child: Icon(
                                        Icons.file_upload_outlined,
                                        size: 40.h.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: widget.frontSide,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.r)),
                        width: 150.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.h.w),
                              child: Text(
                                LocaleKeys.carImageRight.tr(),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              height: .5.h,
                            ),
                            GestureDetector(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 90.h,
                                    width: 150.w,
                                    child: widget.imageRight == null
                                        ? SvgPicture.asset(
                                            carRightSide,
                                            color: Colors.black26,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r)),
                                            child: Image.file(
                                                widget.imageRight!,
                                                fit: BoxFit.fitWidth),
                                          ),
                                  ),
                                  Container(
                                    height: 90.h,
                                    width: 150.w,
                                    child: Icon(
                                      Icons.file_upload_outlined,
                                      size: 40.h.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: widget.rightSide,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              // Spacer(),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10.r)),
                    alignment: Alignment.center,
                    width: 150.w,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h.w),
                          child: Text(
                            LocaleKeys.carImageBack.tr(),
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          height: .5.h,
                        ),
                        GestureDetector(
                            child: Stack(
                              children: [
                                Container(
                                  height: 90.h,
                                  width: 150.w,
                                  child: widget.imageBack == null
                                      ? SvgPicture.asset(
                                          carBackSide,
                                          color: Colors.black26,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r)),
                                          child: Image.file(
                                            widget.imageBack!,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                  decoration: BoxDecoration(),
                                ),
                                Container(
                                  height: 90.h,
                                  width: 150.w,
                                  child: Icon(
                                    Icons.file_upload_outlined,
                                    size: 40.h.w,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onTap: widget.backSide),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.r)),
                        alignment: Alignment.center,
                        width: 150.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.h.w),
                              child: Text(
                                LocaleKeys.carImageLeft.tr(),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              height: .5.h,
                            ),
                            GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 90.h,
                                      width: 150.w,
                                      child: widget.imageLeft == null
                                          ? SvgPicture.asset(
                                              carLeftSide,
                                              color: Colors.black26,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.r),
                                                  bottomRight:
                                                      Radius.circular(10.r)),
                                              child: Image.file(
                                                widget.imageLeft!,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                    ),
                                    Container(
                                      height: 90.h,
                                      width: 150.w,
                                      child: Icon(
                                        Icons.file_upload_outlined,
                                        size: 40.h.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: widget.leftSide),
                            // SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ],
      ),
    );
  }
}
