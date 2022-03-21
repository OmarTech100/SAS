import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TopDrawerProfileInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String profileImage;
  final String memberRating;
  final Color memberShipColor;

  TopDrawerProfileInfo(
      {required this.firstName,
      required this.lastName,
      required this.profileImage,
      required this.memberRating,
      required this.memberShipColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30.w.h,
          backgroundImage: NetworkImage(profileImage),
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$firstName ' '$lastName',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Colors.white),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rate_rounded,
                    color: memberShipColor,
                  ),
                  Text(
                    '$memberRating ' 'member',
                    style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
