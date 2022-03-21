import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kayan/VerifyPhoneNumber/screens/verify_phone_number_screen.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/onBoarding/widgets/onBoardingBullets.dart';
import 'package:kayan/onBoarding/widgets/scrollable.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

int _idx = 0;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: PageView.builder(
              clipBehavior: Clip.antiAlias,
              onPageChanged: (index) {
                setState(() {
                  _idx = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) => Container(child: pages[index]),
            ),
          ),
          _idx == 2
              ? InkWell(
                  child: _getStartedContainer(LocaleKeys.getStarted.tr()),
                  onTap: () {
                    Platform.isAndroid
                        ? _buildAlertDialog(context)
                        : Navigator.of(context)
                            .pushReplacement(fadeRoute(VerifyPhoneScreen()));
                  },
                )
              : Container(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Platform.isAndroid
                          ? _buildAlertDialog(context)
                          : Navigator.of(context)
                              .pushReplacement(fadeRoute(VerifyPhoneScreen()));
                    },
                    child: Text(
                      LocaleKeys.skip.tr(),
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          SizedBox(height: 50),
          OnBoardingBullets(
            idx: _idx,
          ),
        ],
      ),
    );
  }
}

_buildAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        LocaleKeys.lcoationDataCollection.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        LocaleKeys.locationDataCollectionContent.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacement(fadeRoute(VerifyPhoneScreen())),
            child: Text(LocaleKeys.ok.tr())),
      ],
    ),
  );
}

Widget _getStartedContainer(String text) {
  return AnimatedContainer(
    alignment: Alignment.center,
    duration: Duration(seconds: 3),
    height: 50,
    curve: Curves.bounceIn,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: blue,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
