import 'package:flutter/material.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NameTextFields extends StatelessWidget {
  const NameTextFields({
    Key? key,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
  })  : _firstNameController = firstNameController,
        _lastNameController = lastNameController,
        super(key: key);

  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 200.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Column(
            children: [
              TextField(
                maxLength: 15,
                controller: _firstNameController,
                decoration: InputDecoration(
                    counter: Container(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w),
                    labelText: LocaleKeys.firstName.tr(),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100),
              ),
              SizedBox(height: 5.h),
              TextField(
                maxLength: 15,
                controller: _lastNameController,
                decoration: InputDecoration(
                  counter: Container(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w),
                  labelText: LocaleKeys.lastName.tr(),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
