import 'package:flutter/material.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class BalanceBox extends StatelessWidget {
  final Function()? onPressed;
  final Color fontColor;
  final Color boxColor;
  final Color borderColor;

  BalanceBox(
      {required this.onPressed,
      required this.fontColor,
      required this.boxColor,
      required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
              child: Container(
          alignment: Alignment.center,
          height: 45,
           decoration: BoxDecoration(
             color: boxColor,
             border: Border.all(color: borderColor, width: 1 )
           ),
          child: Text(
            LocaleKeys.balance.tr(),
            style: TextStyle(color: fontColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
