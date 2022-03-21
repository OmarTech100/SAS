import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PlateCharField extends StatelessWidget {
  final TextEditingController plateCharController;
  PlateCharField({required this.plateCharController});
  final mask = MaskTextInputFormatter(mask: 'A A A');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.plateChar.tr(),
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 60.h,
          width: 140.w,
          child: TextField(
            inputFormatters: [
              mask,
              FilteringTextInputFormatter.singleLineFormatter
            ],
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              if (value.length == 5) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            maxLength: 5,
            controller: plateCharController,
            decoration: InputDecoration(
              counter: SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              hintText: LocaleKeys.plateCharHint.tr(),
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
