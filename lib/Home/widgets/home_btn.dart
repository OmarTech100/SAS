import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SideBarButtons extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;
  final String icon;

  SideBarButtons({this.onTap, required this.buttonName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            icon,
            width: 30.w,
            color: Color.fromRGBO(190, 194, 206, 1),
          ),
          SizedBox(width: 30),
          Text(
            buttonName,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 19.sp,
            ),
          ),
        ],
      ),
    );
  }
}
