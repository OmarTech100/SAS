import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NextOrSubmitButton extends StatelessWidget {
final String text;
final void Function()? onPressed;

NextOrSubmitButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Container(
          child: customButton(
              onPressed: onPressed, text: text, width: double.infinity),
          // color: Colors.blue,
        ),
      ),
    );
  }
}
