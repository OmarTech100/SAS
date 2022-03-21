import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownMenue extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;
  final String pickedText;

  DropDownMenue(
      {required this.text,
      required this.icon,
      required this.onPressed,
      required this.pickedText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: darkGrey,
          ),
          SizedBox(width: 20.w),
          Text(
            text,
            style: TextStyle(
              color: darkGrey,
            ),
          ),
          Spacer(),
          Text(pickedText),
          SizedBox(width: 10.w),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_drop_down,
                color: darkGrey,
              ))
        ],
      ),
    );
  }
}
