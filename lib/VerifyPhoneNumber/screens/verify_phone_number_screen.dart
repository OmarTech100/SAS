import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/VerifyPhoneNumber/widgets/verify_phone_number_button.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/otp/screens/otp_screen.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:ui';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class VerifyPhoneScreen extends StatefulWidget {
  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final _controller = TextEditingController();
  String _phoneNumber = '';

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool hasInternetConnction = false;

  void validateInput() async {
    setState(() {
      _isLoading = true;
    });
    await InternetConnectionChecker().hasConnection.then((value) {
      setState(() {
        hasInternetConnction = value;
      });
    });
    setState(() {
      _isLoading = false;
    });
    final valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    } else if (hasInternetConnction == false) {
      showSimpleNotification(
        Text(
          LocaleKeys.pleaseCheckInternetConnection.tr(),
        ),
        background: red,
        context: context,
      );
      // showDialog(
      //   context: context,
      //   builder: (context) => OrderActionDialog(
      //     content: LocaleKeys.pleaseCheckInternetConnection.tr(),
      //     title: LocaleKeys.noInternet.tr(),
      //     onOk: () => Navigator.of(context).pop(),
      //     onCancel: () => Navigator.of(context).pop(),
      //   ),
      // );
    } else {
      Platform.isIOS
          ? Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => OTPScreen(_phoneNumber)))
          : Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OTPScreen(_phoneNumber)));
    }
  }

  @override
  void initState() {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.97),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300.h,
                  width: double.infinity,
                  child: Image.asset(
                    blockImage,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
            Positioned(
              top: 200.h,
              left: 20.w,
              right: 20.w,
              child: Container(
                height: 330.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '${LocaleKeys.verify.tr()} ',
                                style: TextStyle(
                                  fontSize: 29.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: '${LocaleKeys.yourPhoneNumber.tr()} ',
                                style: TextStyle(
                                  fontSize: 29.sp,
                                )),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            if (val.characters.elementAt(0) == '0') {
                              _phoneNumber = val.replaceFirst(RegExp(r'0'), '');
                              print(_phoneNumber);
                            } else {
                              _phoneNumber = val;
                            }

                            setState(() {});
                          },
                          controller: _controller,
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return LocaleKeys.err_providePhoneNumber.tr();
                            } else if (val.length < 9) {
                              return LocaleKeys.err_provideValidPhoneNumber
                                  .tr();
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            counter: SizedBox(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: lightBlueGrey,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: SvgPicture.asset(
                                      flag,
                                      height: 20.h,
                                    ),
                                  ),
                                ),
                                context.locale.languageCode == 'en'
                                    ? Text('+966')
                                    : Text('966+'),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            hintText: '5XXXXXXXX',
                            suffixIcon:
                                _phoneNumber.isNotEmpty || _phoneNumber != ''
                                    ? IconButton(
                                        onPressed: () {
                                          _controller.clear();
                                          setState(() {
                                            _phoneNumber = '';
                                          });
                                        },
                                        icon: Icon(
                                          Icons.cancel_rounded,
                                          color: lightGrey,
                                        ),
                                      )
                                    : null,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          SignInButton(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              validateInput();
                            },
                          ),
                          _isLoading
                              ? Container(
                                  child: LoadingWidget(),
                                  height: 60,
                                  width: double.infinity,
                                  color: Colors.white,
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
