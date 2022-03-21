import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';

class DiscountBox extends StatelessWidget {
  final Function()? onPressed;
  final Color fontColor;
  final Color boxColor;
  final Color borderColor;

  DiscountBox(
      {required this.onPressed,
      required this.fontColor,
      required this.boxColor,
      required this.borderColor});
  

  BoxDecoration _buildDiscountBoxEn() {
    return BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: boxColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)));
  }

  BoxDecoration _buildDiscountBoxAr() {
    return BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: boxColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
              child: Container(
          alignment: Alignment.center,
          height: 45,
          child: Text(
            LocaleKeys.discount.tr(),
            style: TextStyle(color: fontColor, fontSize: 20),
          ),
          decoration: context.locale.languageCode == 'en'? _buildDiscountBoxEn() : _buildDiscountBoxAr(),
        ),
      ),
    );
  }
}
