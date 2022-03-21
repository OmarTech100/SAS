import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kayan/constants/cars.dart';
import 'package:kayan/constants/vehicles_colors.dart';
import 'package:kayan/driverInformation/widgets/car_photos.dart';
import 'package:kayan/driverInformation/widgets/plate_char_field.dart';
import 'package:kayan/driverInformation/widgets/plate_no_field.dart';
import 'package:kayan/driverInformation/widgets/vehicle_brand.dart';
import 'package:kayan/driverInformation/widgets/vehicle_year.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVehicleWidget extends StatefulWidget {
  final TextEditingController plateCharController;
  final TextEditingController plateNoController;
  final void Function()? vehicleTypePicker;
  final void Function()? vehicleDatePicker;
  final void Function()? vehicleColorPicker;

  final void Function()? imageRightPickerFunction;
  final void Function()? imageLeftPickerFunction;
  final void Function()? imageFrontPickerFunction;
  final void Function()? imageBackPickerFunction;

  final String pickedType;
  final String pickedDate;
  final String pickedColor;

  final File? imageLeft;
  final File? imageRight;
  final File? imageFront;
  final File? imageBack;

  AddVehicleWidget({
    required this.pickedColor,
    required this.pickedDate,
    required this.pickedType,
    required this.plateCharController,
    required this.plateNoController,
    this.vehicleTypePicker,
    this.vehicleDatePicker,
    this.vehicleColorPicker,
    required this.imageRight,
    required this.imageLeft,
    required this.imageFront,
    required this.imageBack,
    required this.imageBackPickerFunction,
    required this.imageFrontPickerFunction,
    required this.imageLeftPickerFunction,
    required this.imageRightPickerFunction,
  });

  @override
  _AddVehicleWidgetState createState() => _AddVehicleWidgetState();
}

class _AddVehicleWidgetState extends State<AddVehicleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              VehicleBrand(
                onPressed: widget.vehicleTypePicker,
                type: widget.pickedType.isEmpty
                    ? context.locale.languageCode == 'en'
                        ? carsEn[0]
                        : carsAr[0]
                    : widget.pickedType,
              ),
              SizedBox(height: 20.h),
              VehicleYear(
                onPressed: widget.vehicleDatePicker,
                year: widget.pickedDate,
              ),
              SizedBox(height: 20.h),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: PlateCharField(
                          plateCharController: widget.plateCharController),
                    ),
                    Spacer(),
                    PlateNoField(plateNoController: widget.plateNoController),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                alignment: context.locale == Locale('en')
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  LocaleKeys.color.tr(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: widget.vehicleColorPicker,
                child: Container(
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
                          widget.pickedColor.isEmpty
                              ? context.locale.languageCode == 'en'
                                  ? vehicleColorEn[0]
                                  : vehicleColorAr[0]
                              : widget.pickedColor,
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
              CarPhotosCard(
                imageBack: widget.imageBack,
                imageFront: widget.imageFront,
                imageLeft: widget.imageLeft,
                imageRight: widget.imageRight,
                leftSide: widget.imageLeftPickerFunction,
                rightSide: widget.imageRightPickerFunction,
                frontSide: widget.imageFrontPickerFunction,
                backSide: widget.imageBackPickerFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
