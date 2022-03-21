import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/Home/widgets/notification_bubble.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/notifications/provider/notification_provider.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TopActionBar extends StatelessWidget {
  final Function()? openDrawer;
  final String userName;
  final String location;
  final String userImage;
  final String notification;
  final int? notifications;

  TopActionBar(
      {required this.openDrawer,
      required this.userName,
      required this.location,
      required this.userImage,
      required this.notification,
      this.notifications});

  @override
  Widget build(BuildContext context) {
    final _notificationprovider = Provider.of<NotificationProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: openDrawer,
            child: SvgPicture.asset(
              menuIcon,
              height: 30.h,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocaleKeys.hello.tr()} ' '$userName',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              Container(
                // height: 10.h,
                width: 170.w,
                child: Text(
                  location,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
                ),
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: [
              Container(
                height: 30.h,
                width: 50.w,
                child: SvgPicture.asset(
                  notification,
                  height: 30.h,
                ),
              ),
              _notificationprovider.items != 0
                  ? Positioned(
                      bottom: 1,
                      right: 7,
                      child: NotificationBubble(
                        numberOfNotifications: notifications,
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(width: 10.w),
          CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 30.r,
          ),
        ],
      ),
    );
  }
}
