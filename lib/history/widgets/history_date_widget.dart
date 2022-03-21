import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryDateWidget extends StatefulWidget {
  const HistoryDateWidget({Key? key}) : super(key: key);

  @override
  _HistoryDateWidgetState createState() => _HistoryDateWidgetState();
}

class _HistoryDateWidgetState extends State<HistoryDateWidget> {
  bool isSelected = false;
  int currentIndex = 0;

  Map<String, dynamic> days = {
    'today': DateFormat('dd').format(DateTime.now()),
    'day6': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 1))),
    'day5': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 2))),
    'day4': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 3))),
    'day3': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 4))),
    'day2': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 5))),
    'day1': DateFormat('dd').format(DateTime.now().subtract(Duration(days: 6))),
  };
  Map<String, dynamic> daysChar = {
    'today': DateFormat('EE').format(DateTime.now()),
    'day6': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 1)).toLocal()),
    'day5': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 2)).toLocal()),
    'day4': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 3)).toLocal()),
    'day3': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 4)).toLocal()),
    'day2': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 5)).toLocal()),
    'day1': DateFormat('EE')
        .format(DateTime.now().subtract(Duration(days: 6)).toLocal()),
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        ),
        Container(
          height: 75.h,
          child: ListView.builder(
            reverse: false,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                    currentIndex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    border: index == currentIndex
                        ? Border.all(color: blue, width: 2.w)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                    color: index == currentIndex
                        ? Colors.white
                        : Colors.grey.shade200,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          daysChar.values.toList()[index],
                          style: TextStyle(
                            color: index == currentIndex ? blue : greyLighter,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        days.values.toList()[index],
                        style: TextStyle(
                            color: index == currentIndex ? blue : greyLighter,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
