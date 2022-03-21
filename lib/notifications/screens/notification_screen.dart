import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocaleKeys.notifications.tr(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: blue,
              size: 30.h.w,
            )),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              // child: ListView.builder(
              //     physics: BouncingScrollPhysics(),
              //     itemCount: 0,
              //     itemBuilder: (context, i) {
              //       // return Column(
              //       //   mainAxisAlignment: MainAxisAlignment.start,
              //       //   children: [
              //       //     Container(
              //       //       decoration: BoxDecoration(
              //       //         color: Colors.white,
              //       //       ),
              //       //       child: ListTile(
              //       //         leading: CircleAvatar(
              //       //           radius: 30,
              //       //         ),
              //       //         title: Text(
              //       //           'System',
              //       //           style: TextStyle(
              //       //             fontWeight: FontWeight.bold,
              //       //             fontSize: 18,
              //       //           ),
              //       //         ),
              //       //         subtitle: Text(
              //       //           'Booking #1234',
              //       //           style: TextStyle(
              //       //             fontSize: 16,
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //     Divider(
              //       //       height: 0,
              //       //       color: Colors.grey.shade400,
              //       //     ),
              //       //   ],
              //       // );

              //     }),
              child: Center(
                  child: Icon(
                Icons.notifications_off_outlined,
                color: blue.withOpacity(.3),
                size: 100.h.w,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
