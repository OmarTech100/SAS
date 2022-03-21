import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsCard extends StatefulWidget {
  final Order order;
  final String deliveryStatus;
  final Color deliverStatusColor;

  OrderDetailsCard({
    required this.deliveryStatus,
    required this.deliverStatusColor,
    required this.order,
  });

  @override
  _OrderDetailsCardState createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  String _pickUpAddress = '';
  String _dropOfAddress = '';

  Future getPickUpLocationFromCoordinates(
      {double? latitude, double? longitude}) async {
    final listOfAdresses = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude!, longitude!);
    final street = listOfAdresses.first.street;
    final destrict = listOfAdresses.first.subLocality;
    final city = listOfAdresses.first.locality;
    setState(() {
      _pickUpAddress = '$street, $destrict, $city';
    });
  }

  Future getDropOffLocationFromCoordinates(
      {double? latitude, double? longitude}) async {
    final listOfAdresses = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude!, longitude!);
    final street = listOfAdresses.first.street;
    final destrict = listOfAdresses.first.subLocality;
    final city = listOfAdresses.first.locality;
    setState(() {
      _dropOfAddress = '$street, $destrict, $city';
    });
  }

  @override
  void initState() {
    getPickUpLocationFromCoordinates(
        latitude: double.parse(widget.order.pickUpLocation!.latitude!),
        longitude: double.parse(widget.order.pickUpLocation!.longitude!));
    getDropOffLocationFromCoordinates(
      latitude: double.parse(widget.order.dropOffLocation!.latitude!),
      longitude: double.parse(widget.order.dropOffLocation!.longitude!),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundImage: NetworkImage(widget.order.brandPicture!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.order.customer!.firstName} '
                        '${widget.order.customer!.lastName}',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 130.w,
                            height: 30.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                width: 3.w,
                                color: widget.deliverStatusColor,
                              ),
                            ),
                            child: Text(
                              widget.deliveryStatus,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: widget.deliverStatusColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Spacer(),
                        ],
                      ),
                      SizedBox(height: 5.w),
                      Container(
                        width: 130.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(color: blue, width: 3.w)),
                        child: Text(
                          widget.order.paymentMethod!,
                          style: TextStyle(
                              color: blue,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(f.format(widget.order.orderTime!)),
                    ],
                  ),
                  Text(
                    '${widget.order.amount}' ' ${LocaleKeys.sar.tr()}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  )
                ],
              ),
              Divider(),
              SizedBox(height: 5.h),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                            backgroundColor: lightBlueGrey,
                            radius: 14.r,
                            child: Icon(
                              Icons.location_on,
                              size: 15.h.w,
                              color: Colors.black,
                            )),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.pickUp.tr(),
                              style: TextStyle(
                                  color: darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.h.w),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.w,
                              ),
                              child: Text(
                                _pickUpAddress,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Spacer(),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                            backgroundColor: lightBlueGrey,
                            radius: 14.r,
                            child: Icon(
                              Icons.location_on,
                              size: 15.h.w,
                              color: Colors.black,
                            )),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.dropOff.tr(),
                              style: TextStyle(
                                  color: darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.w,
                              ),
                              child: Text(
                                _dropOfAddress,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
