import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationBubble extends StatelessWidget {
  final int? numberOfNotifications;
  NotificationBubble({this.numberOfNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 18.h,
      width: 18.w,
      padding: EdgeInsets.all(2.h.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.red,
      ),
      child: FittedBox(
        child: Text(
          '$numberOfNotifications',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
