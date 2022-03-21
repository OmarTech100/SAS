import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? onOk;
  final void Function()? onCancel;

  OrderActionDialog(
      {required this.title, required this.content, this.onOk, this.onCancel});

  @override
  Widget build(BuildContext context) =>
      Platform.isIOS ? _buildIosDialog() : _buildAndroidDialog();

  Widget _buildIosDialog() => CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: onOk,
              icon: Icon(
                Icons.check_circle_outline,
                color: green,
              ),
              label: Text(LocaleKeys.ok.tr())),
          TextButton.icon(
              onPressed: onCancel,
              icon: Icon(
                Icons.cancel_outlined,
                color: red,
              ),
              label: Text(LocaleKeys.cancel.tr()))
        ],
      );

  Widget _buildAndroidDialog() => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: onOk,
              icon: Icon(
                Icons.check_circle_outline,
                color: green,
              ),
              label: Text(LocaleKeys.ok.tr())),
          TextButton.icon(
              onPressed: onCancel,
              icon: Icon(
                Icons.cancel_outlined,
                color: red,
              ),
              label: Text(LocaleKeys.cancel.tr()))
        ],
      );
}
