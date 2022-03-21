import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:kayan/deliveryTypes/widgets/order_details_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class HistoryOrderWidget extends StatefulWidget {
  final Order? order;

  HistoryOrderWidget({
    required this.order,
  });

  @override
  _HistoryOrderWidgetState createState() => _HistoryOrderWidgetState();
}

class _HistoryOrderWidgetState extends State<HistoryOrderWidget> {
  String? deliveryStatus;
  final _deliveryStatus = DeliveryStatus();
  @override
  void initState() {
    if (widget.order!.deliveryStatus == _deliveryStatus.delivered) {
      setState(() {
        deliveryStatus = LocaleKeys.delivered.tr();
      });
    } else if (widget.order!.deliveryStatus == _deliveryStatus.rejected) {
      setState(() {
        deliveryStatus = LocaleKeys.rejected.tr();
      });
    } else if (widget.order!.deliveryStatus == _deliveryStatus.cancelled) {
      setState(() {
        deliveryStatus = LocaleKeys.cancelled.tr();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<DatabaseServices>(context);
    Color properDeliveryStatusColor() {
      Color color = Colors.white;

      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order!.orderId) {
          if (order.deliveryStatus == _deliveryStatus.rejected) {
            color = red;
          } else if (order.deliveryStatus == _deliveryStatus.cancelled) {
            color = grey;
          } else if (order.deliveryStatus == _deliveryStatus.delivered) {
            color = green;
          }
        }
      });
      return color;
    }

    String propperDeliveryStatusTextArEn() {
      String deliverStatus = '';
      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order!.orderId) {
          if (order.deliveryStatus == _deliveryStatus.rejected) {
            deliverStatus = LocaleKeys.rejected.tr();
          } else if (order.deliveryStatus == _deliveryStatus.cancelled) {
            deliverStatus = LocaleKeys.cancelled.tr();
          } else if (order.deliveryStatus == _deliveryStatus.delivered) {
            deliverStatus = LocaleKeys.delivered.tr();
          }
        }
      });
      return deliverStatus;
    }

    return Stack(
      children: [
        OrderDetailsCard(
          deliverStatusColor: properDeliveryStatusColor(),
          deliveryStatus: propperDeliveryStatusTextArEn(),
          order: widget.order!,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              '${LocaleKeys.orderNumber.tr()} #${widget.order!.orderId!}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
