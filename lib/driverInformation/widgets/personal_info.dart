import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kayan/constants/cities.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/nationalities.dart';
import 'package:kayan/driverInformation/widgets/drop_down_menue_widget.dart';
import 'package:kayan/driverInformation/widgets/genderButtom.dart';
import 'package:kayan/driverInformation/widgets/inputDecoration.dart';
import 'package:kayan/driverInformation/widgets/nameTextFields.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoWidget extends StatefulWidget {
  final File? image;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final void Function()? bottomSheet;
//-----------------------------------
  final TextEditingController phoneNumberController;
  final TextEditingController additionalPhonenNumberController;
  final TextEditingController idNumberController;
  final String pickedNationality;
  final String pickedCity;
  final String pickedDate;
  bool malePicked = true;
  bool femalePicked = false;
  String? gender;
  final void Function()? nationalityCupertinoPicker;
  final void Function()? cityCupertinoPicker;

  final void Function()? buildDatePicker;

  PersonalInfoWidget({
    required this.bottomSheet,
    required this.firstNameController,
    required this.lastNameController,
    required this.image,
    required this.phoneNumberController,
    required this.additionalPhonenNumberController,
    required this.idNumberController,
    this.nationalityCupertinoPicker,
    this.cityCupertinoPicker,
    this.buildDatePicker,
    required this.femalePicked,
    required this.gender,
    required this.malePicked,
    required this.pickedCity,
    required this.pickedDate,
    required this.pickedNationality,
  });

  @override
  _PersonalInfoWidgetState createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: widget.image != null
                            ? FileImage(widget.image!)
                            : null,
                        child: widget.image != null
                            ? null
                            : Icon(
                                Icons.photo_camera_front_rounded,
                                size: 50.h.w,
                                color: Colors.white,
                              ),
                        backgroundColor: Colors.grey.shade100,
                      ),
                      SizedBox(height: 15.h),
                      GestureDetector(
                        child: Text(
                          LocaleKeys.editPhoto.tr(),
                          style: TextStyle(color: blue),
                        ),
                        onTap: widget.bottomSheet,
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  NameTextFields(
                      firstNameController: widget.firstNameController,
                      lastNameController: widget.lastNameController),
                ],
              ),
              Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          if (value.length == 9) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: darkGrey),
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        controller: widget.phoneNumberController,
                        decoration: personalInfoInputDecoration(
                            labelText: LocaleKeys.phoneNumber.tr(),
                            hintText: LocaleKeys.phoneNumberHint.tr(),
                            prefixIcon: Icon(Icons.phone_iphone_outlined)),
                      ),
                      SizedBox(height: 3.h),
                      TextFormField(
                        onChanged: (value) {
                          if (value.length == 9) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        textInputAction: TextInputAction.next,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        controller: widget.additionalPhonenNumberController,
                        decoration: personalInfoInputDecoration(
                            labelText: LocaleKeys.addPhoneNumber.tr(),
                            hintText: LocaleKeys.phoneNumberHint.tr(),
                            prefixIcon: Icon(Icons.phone_iphone_outlined)),
                      ),
                      SizedBox(height: 3.h),
                      TextFormField(
                        onChanged: (value) {
                          if (value.length == 10) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: widget.idNumberController,
                        decoration: personalInfoInputDecoration(
                            labelText: LocaleKeys.idNumber.tr(),
                            hintText: LocaleKeys.idNumberHint.tr(),
                            prefixIcon: Icon(Icons.perm_identity_rounded)),
                      ),
                      SizedBox(height: 3.h),
                      DropDownMenue(
                        pickedText: widget.pickedNationality.isEmpty
                            ? context.locale.languageCode == 'en'
                                ? nationalitiesEn[0]
                                : nationalitiesAr[0]
                            : widget.pickedNationality,
                        text: LocaleKeys.nationality.tr(),
                        icon: Icons.flag,
                        onPressed: widget.nationalityCupertinoPicker,
                      ),
                      SizedBox(height: 3.h),
                      DropDownMenue(
                        pickedText: widget.pickedCity.isEmpty
                            ? context.locale.languageCode == 'en'
                                ? citiesEn[0]
                                : citiesAr[0]
                            : widget.pickedCity,
                        text: LocaleKeys.city.tr(),
                        icon: Icons.location_city_rounded,
                        onPressed: widget.cityCupertinoPicker,
                      ),
                      SizedBox(height: 3.h),
                      DropDownMenue(
                        pickedText: widget.pickedDate.isEmpty
                            ? f2.format(DateTime.now())
                            : widget.pickedDate,
                        text: LocaleKeys.dateOfBirth.tr(),
                        icon: Icons.date_range,
                        onPressed: widget.buildDatePicker,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: 100.w,
                            child: Text(
                              LocaleKeys.gender.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.malePicked = true;
                                widget.femalePicked = false;
                                widget.gender = "male";
                              });
                            },
                            child: genderButton(
                              color: widget.malePicked
                                  ? blue
                                  : Colors.grey.shade100,
                              gender: LocaleKeys.male1.tr(),
                              textColor:
                                  widget.malePicked ? Colors.white : grey,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.malePicked = false;
                                widget.femalePicked = true;
                                widget.gender = 'female';
                                // print(widget.gender);
                              });
                            },
                            child: genderButton(
                              color: widget.femalePicked
                                  ? blue
                                  : Colors.grey.shade100,
                              gender: LocaleKeys.female1.tr(),
                              textColor:
                                  widget.femalePicked ? Colors.white : grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
