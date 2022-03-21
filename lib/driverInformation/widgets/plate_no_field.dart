import 'package:flutter/material.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlateNoField extends StatelessWidget {
  final TextEditingController plateNoController;

  PlateNoField({required this.plateNoController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.plateNo.tr(),
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 60.h,
          width: 140.w,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.length == 4) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            maxLength: 4,
            controller: plateNoController,
            decoration: InputDecoration(
              counter: SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              hintText: LocaleKeys.plateNoHint.tr(),
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
