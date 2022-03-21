import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocCard extends StatefulWidget {
  final String text;
  final Widget photo;
  final Function()? onPressed;

  DocCard({required this.text, this.onPressed, required this.photo});

  @override
  _DocCardState createState() => _DocCardState();
}

class _DocCardState extends State<DocCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Stack(
        children: [
          Container(
     
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                    builder: (context, constrains) => ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r)),
                          child: Container(
                            child: Container(
                              width: double.infinity,
                              height: 200.h,
                              child: Container(
                                child: widget.photo),
                            ),
                          ),
                        )),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                      // SizedBox(width: 20),
                      IconButton(
                          onPressed: widget.onPressed,
                          icon: Icon(
                            Icons.file_upload_outlined,
                            color: Colors.blue,
                            size: 30.h.w,
                          )),
                    ],
                  ),
                ),
             
              ],
            ),
          ),
        ],
      ),
    );
  }
}
