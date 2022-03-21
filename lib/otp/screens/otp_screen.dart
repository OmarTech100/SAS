import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  OTPScreen(
    this.phoneNumber,
  );
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var maskFormatter =
      new MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'0-9')});
  bool? _isLoading = false;
  String _otpCode = '';
  String _verificationId = '';
  final _auth = FirebaseAuth.instance;
  int _timerText = 60;
  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (_timer) {
      if (_timerText > 0) {
        _timerText--;
      } else {
        _timer.cancel();
      }
    });
  }
  // final _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });
    await _auth.verifyPhoneNumber(
        phoneNumber: '+966' + widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        codeSent: (String verificationId, [int? forceSendCode]) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
              context: context,
              builder: (context) {
                if (Platform.isIOS) {
                  return CupertinoAlertDialog(
                    title: Text('Error'),
                    content: e.message!.contains('network error')
                        ? Text('Please check your network connection')
                        : Text(e.message.toString()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'))
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: Text('Error'),
                    content: e.message!.contains('quota')
                        ? Text('Unknown error')
                        : Text(e.message.toString()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'))
                    ],
                  );
                }
              });
        },
        codeAutoRetrievalTimeout: (String autoRet) {});
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    verifyPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<DatabaseServices>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 70.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(LocaleKeys.backToPhoneAuth.tr())),
                    SizedBox(height: 30.h),
                    Text(
                      LocaleKeys.phoneVir.tr(),
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(height: 5.h),
                    Text(
                      '${LocaleKeys.enterOtpSentTo.tr()} '
                      '0${widget.phoneNumber}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constrains) => TextField(
                          obscureText: false,
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: lightBlueGrey,
                            counter: Container(),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              _otpCode = val;
                            });
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                        child: OTPButton(),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _isLoading = true;
                          });
                          final credential = PhoneAuthProvider.credential(
                              verificationId: _verificationId,
                              smsCode: _otpCode);
                          try {
                            await _auth.signInWithCredential(credential);
                            await _provider.checkUserStatus2(context);
                          } on FirebaseAuthException catch (e) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  if (Platform.isIOS) {
                                    return CupertinoAlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Ok'))
                                      ],
                                      title: Text('Error'),
                                      content: e.message!.contains('empty')
                                          ? Text('Please enter the code!')
                                          : e.message!.contains('invalid')
                                              ? Text('Invalid code!')
                                              : Text('Unkown error!'),
                                    );
                                  } else
                                    return AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Ok'))
                                      ],
                                      title: Text('Error'),
                                      content: e.message!.contains('empty')
                                          ? Text('Please enter the code!')
                                          : e.message!.contains('invalid')
                                              ? Text('Invalid code!')
                                              : Text('Unkown error!'),
                                    );
                                });
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        }),
                    SizedBox(height: 20.h),
                    _isLoading == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 80.h,
                                width: 80.w,
                                child: LoadingWidget(),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPButton extends StatelessWidget {
  const OTPButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.h),
      height: 73.h,
      width: 300.w,
      child: Text(
        LocaleKeys.verifyCode.tr(),
        style: TextStyle(
            fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: blue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset.infinite,
            spreadRadius: 0.6,
            blurRadius: 0.9,
          ),
        ],
      ),
    );
  }
}
