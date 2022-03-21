import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/driverInformation/widgets/card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UploadDocsWidget extends StatefulWidget {
  final File? idCardPic;
  final File? drivingLicensesPic;
  final File? carRegPic;

  final Function()? idCardFunction;
  final Function()? drivingLicensesFunction;
  final Function()? carRegFunction;

  const UploadDocsWidget(
      {this.carRegFunction,
      this.carRegPic,
      this.drivingLicensesFunction,
      this.drivingLicensesPic,
      this.idCardFunction,
      this.idCardPic});

  @override
  _UploadDocsWidgetState createState() => _UploadDocsWidgetState();
}

class _UploadDocsWidgetState extends State<UploadDocsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: false,
                children: [
                  Column(
                    children: [
                      DocCard(
                        text: LocaleKeys.idCardPhoto.tr(),
                        photo: widget.idCardPic == null
                            ? Image.asset(
                                car_drivingLicense,
                                width: 100.w,
                                height: 100.h,
                              )
                            : Image.file(
                                widget.idCardPic!,
                                fit: BoxFit.fitWidth,
                              ),
                        onPressed: widget.idCardFunction,
                      ),
                      SizedBox(height: 10.h),
                      DocCard(
                        text: LocaleKeys.drivingLicensePhoto.tr(),
                        photo: widget.drivingLicensesPic == null
                            ? Image.asset(car_drivingLicense)
                            : Image.file(widget.drivingLicensesPic!,
                                fit: BoxFit.fitWidth),
                        onPressed: widget.drivingLicensesFunction,
                      ),
                      SizedBox(height: 10.h),
                      DocCard(
                        text: LocaleKeys.carRegPhoto.tr(),
                        photo: widget.carRegPic == null
                            ? Image.asset(
                                car_drivingLicense,
                                width: 100.w,
                                height: 100.h,
                              )
                            : Image.file(widget.carRegPic!,
                                fit: BoxFit.fitWidth),
                        onPressed: widget.carRegFunction,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
