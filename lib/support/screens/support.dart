import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocaleKeys.support.tr(),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        actions: [],
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: blue,
              size: 30.w.h,
            )),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Image.asset(
                'assets/images/support.png',
                color: blue,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(20.w.h),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.supportPherase.tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Container(
                    height: 80.h,
                    width: 100.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue),
                      ),
                      onPressed: () {
                        launch(
                            'mailto:info@kayanintellignce.com?subject=&body=');
                      },
                      child: Icon(
                        Icons.email_outlined,
                        size: 40.w.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
