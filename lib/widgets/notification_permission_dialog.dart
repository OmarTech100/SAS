import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final Function()? onAllow;
  final Function()? onDeny;
  NotificationDialog({this.onAllow, required this.onDeny});

  @override
  Widget build(BuildContext context) =>
      Platform.isIOS ? buildIosDialog() : buildAndoidDialog();

  Widget buildIosDialog() => CupertinoAlertDialog(
        title: Text('Allow notifications?'),
        content: Text('SAS would like to send notifications'),
        actions: [
          TextButton(onPressed: () => onDeny, child: Text('Deny')),
          TextButton(onPressed: () => onAllow, child: Text('Allow')),
        ],
      );
  Widget buildAndoidDialog() => AlertDialog(
        title: Text('Allow notifications?'),
        content: Text('SAS would like to send notifications'),
        actions: [
          TextButton(onPressed: () => onDeny, child: Text('Deny')),
          TextButton(onPressed: () => onAllow, child: Text('Allow')),
        ],
      );
}
