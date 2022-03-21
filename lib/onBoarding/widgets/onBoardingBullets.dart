import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';

class OnBoardingBullets extends StatefulWidget {
  final idx;
  OnBoardingBullets({
    this.idx,
  });

  @override
  _OnBoardingBulletsState createState() => _OnBoardingBulletsState();
}

class _OnBoardingBulletsState extends State<OnBoardingBullets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          height: widget.idx == 0 ? 16 : 10,
          width: widget.idx == 0 ? 16 : 10,
          decoration: BoxDecoration(
            color: widget.idx == 0 ? blue : greyLighter,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SizedBox(width: 10),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          height: widget.idx == 1 ? 16 : 10,
          width: widget.idx == 1 ? 16 : 10,
          decoration: BoxDecoration(
            color: widget.idx == 1 ? blue : greyLighter,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SizedBox(width: 10),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          height: widget.idx == 2 ? 16 : 10,
          width: widget.idx == 2 ? 16 : 10,
          decoration: BoxDecoration(
            color: widget.idx == 2 ? blue : greyLighter,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
