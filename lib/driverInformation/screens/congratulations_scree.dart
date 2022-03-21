import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CongartsScreen extends StatefulWidget {
  const CongartsScreen({Key? key}) : super(key: key);

  @override
  _CongartsScreenState createState() => _CongartsScreenState();
}

class _CongartsScreenState extends State<CongartsScreen> {
  bool _isLoading = false;
  bool _isActivated = false;
  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<DatabaseServices>(context);
    Future<bool> checkDriverStatus() async {
      await Future.delayed(Duration(seconds: 2));
      _dbProvider.checkUserStatus2(context);
      if (await _dbProvider.checkUserStatus2(context)) {
        _isActivated = true;
      }
      setState(() {});
      return _isActivated;
    }

    return Scaffold(
      body: SafeArea(
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 40.h),
                      LottieBuilder.asset(dataReview),
                      SizedBox(height: 40.h),
                      Text(
                        LocaleKeys.congrats1.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Text(
                        LocaleKeys.congrats2.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 70.w,
                  child: _isLoading ? LoadingWidget() : Container(),
                ),
                SizedBox(
                  height: 40.h,
                ),
                customButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await checkDriverStatus();
                    _isLoading = false;
                  },
                  text: LocaleKeys.checkYourStatus.tr(),
                  width: double.infinity,
                ),
              ],
            ),
          )),
    );
  }
}
