import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCards extends StatelessWidget {
  final String assetName;
  final Widget child1;
  final Widget child2;

  CreditCards(
      {required this.assetName, required this.child1, required this.child2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: 27,
          child: SvgPicture.asset(assetName),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child1,
            child2,
          ],
        ),
      ],
    );
  }
}
