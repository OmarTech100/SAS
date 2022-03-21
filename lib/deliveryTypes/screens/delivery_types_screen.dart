import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:kayan/deliveryTypes/widgets/order_details_card.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/orderDetails/screens/order_screen.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryTypesScreen extends StatefulWidget {
  final int numberOfOrders;
  final String title;
  final List<Order>? order;

  DeliveryTypesScreen(
      {required this.title, required this.numberOfOrders, required this.order});

  @override
  _DeliveryTypesScreenState createState() => _DeliveryTypesScreenState();
}

class _DeliveryTypesScreenState extends State<DeliveryTypesScreen> {
  final _deliverStatus = DeliveryStatus();

  @override
  Widget build(BuildContext context) {
    Color properDeliveryStatusColor(int index) {
      Color color = Colors.white;

      if (widget.order![index].deliveryStatus == _deliverStatus.pending) {
        color = yellow;
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.pendingCollection) {
        color = orange;
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.pickedUp) {
        color = orange;
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.delivered) {
        color = green;
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.onRoute) {
        color = purple;
      }

      return color;
    }

    String propperDeliveryStatusTextArEn(int index) {
      String deliverStatus = '';

      if (widget.order![index].deliveryStatus == _deliverStatus.pending) {
        deliverStatus = LocaleKeys.pending.tr();
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.pendingCollection) {
        deliverStatus = LocaleKeys.pendingCollection.tr();
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.pickedUp) {
        deliverStatus = LocaleKeys.pickedUp.tr();
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.onRoute) {
        deliverStatus = LocaleKeys.onRoute.tr();
      } else if (widget.order![index].deliveryStatus ==
          _deliverStatus.delivered) {
        deliverStatus = LocaleKeys.delivered.tr();
      }

      return deliverStatus;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          SizedBox(width: 10.w),
          IconButton(
              highlightColor: Colors.black12,
              splashColor: Colors.white,
              onPressed: () => showMenu(
                    context: context,
                    position: context.locale.languageCode == 'en'
                        ? RelativeRect.fromLTRB(double.infinity, 0, 20.w, 0)
                        : RelativeRect.fromLTRB(0, 0, 20.w, double.infinity),
                    items: [
                      PopupMenuItem(
                        textStyle: TextStyle(
                          color: blue,
                        ),
                        value: 0,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5.r,
                              backgroundColor: green,
                            ),
                            SizedBox(width: 5.w),
                            Row(
                              children: [
                                Text(LocaleKeys.avilableOrders.tr()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5.r,
                              backgroundColor: yellow,
                            ),
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.AcceptedOrders.tr()),
                          ],
                        ),
                        textStyle: TextStyle(
                          color: blue,
                        ),
                      ),
                    ],
                  ),
              icon: Icon(
                Icons.filter_list_outlined,
                color: blue,
                size: 27.w.h,
              )),
          SizedBox(width: 10.w),
        ],
        shadowColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: blue,
              size: 30.h.w,
            )),
        title: Container(
          child: Column(
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.numberOfOrders}' +
                    ' ${LocaleKeys.ordersAvilable.tr()}',
                style: TextStyle(color: lightGrey, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.r),
            topRight: Radius.circular(60.r),
          ),
          color: Color.fromRGBO(72, 178, 255, .1),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: widget.order!.isNotEmpty
              ? ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: widget.numberOfOrders,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(fadeRoute(OrderScreen(
                            order: widget.order![index],
                          )));
                        },
                        child: OrderDetailsCard(
                          deliveryStatus: propperDeliveryStatusTextArEn(index),
                          deliverStatusColor: properDeliveryStatusColor(index),
                          order: widget.order![index],
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ordersIcon,
                      color: blue.withOpacity(.3),
                      height: 100.h,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      LocaleKeys.noOrders.tr(),
                      style: TextStyle(color: grey, fontSize: 20.sp),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
