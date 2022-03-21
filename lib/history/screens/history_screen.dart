import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:kayan/history/widgets/history_date_widget.dart';
import 'package:kayan/history/widgets/history_orders_widget.dart';
import 'package:kayan/history/widgets/history_report_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _deliveryStatus = DeliveryStatus();

  List<Order> showOrders({
    AsyncSnapshot<List<Order>>? snapshot,
  }) {
    List<Order> updatedOrder = [];

    snapshot!.data!.forEach((order) {
      if ((order.deliveryStatus == _deliveryStatus.delivered ||
          order.deliveryStatus == _deliveryStatus.rejected ||
          order.deliveryStatus == _deliveryStatus.cancelled)) {
        updatedOrder.add(order);
        // setState(() {});
      }
    });

    return updatedOrder;
  }

  double totaEarned({
    AsyncSnapshot<List<Order>>? snapshot,
  }) {
    double total = 0.0;
    List<Order> updatedOrder = [];
    snapshot!.data!.forEach((order) {
      if ((order.deliveryStatus == _deliveryStatus.delivered)) {
        updatedOrder.add(order);
      }
    });
    snapshot.data!.forEach((order) {
      if (order.deliveryStatus == _deliveryStatus.delivered) {
        for (int i = 0; i < updatedOrder.length; i++) {
          if (i < updatedOrder.length) {
            total = double.parse(updatedOrder[i].orderTotal!) +
                double.parse(updatedOrder[i + 1].orderTotal!);
          }
        }
      }
    });

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<DatabaseServices>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocaleKeys.history.tr(),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blue,
            size: 30.h.w,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                HistoryDateWidget(),
                Flexible(
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Container(
                          height: 100.h,
                          child: HistoryReportWidget(
                            totalJops:
                                int.parse(_dbProvider.driver!.totalJobs!),
                            totalEarned: 0.0,
                          ),
                        ),
                        Flexible(
                          child: FutureBuilder<List<Order>>(
                              future: _dbProvider.fetchAvilableOrders(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return LoadingWidget();
                                } else if (showOrders(snapshot: snapshot)
                                        .length !=
                                    0) {
                                  return ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount:
                                        showOrders(snapshot: snapshot).length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final orders =
                                          showOrders(snapshot: snapshot)[index];
                                      return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          child: HistoryOrderWidget(
                                            order: Order(
                                              pickUpLocation:
                                                  orders.pickUpLocation,
                                              dropOffLocation:
                                                  orders.dropOffLocation,
                                              invoiceStatus:
                                                  orders.invoiceStatus,
                                              orderId: orders.orderId,
                                              userId: _dbProvider.driverId,
                                              type: orders.type,
                                              amount: orders.amount,
                                              brandName: orders.brandName,
                                              brandPicture: orders.brandPicture,
                                              discount: orders.discount,
                                              orderTotal: orders.orderTotal,
                                              orderItems: [
                                                OrderItem(
                                                  description: orders
                                                      .orderItems!
                                                      .first
                                                      .description,
                                                  quantity: orders.orderItems!
                                                      .first.quantity,
                                                ),
                                              ],
                                              customer: Customer(
                                                firstName:
                                                    orders.customer!.firstName,
                                                lastName:
                                                    orders.customer!.lastName,
                                                address:
                                                    orders.customer!.address,
                                              ),
                                              paymentMethod:
                                                  orders.paymentMethod,
                                              orderTime: orders.orderTime,
                                              deliveryStatus:
                                                  orders.deliveryStatus,
                                            ),
                                          ));
                                    },
                                  );
                                }
                                return Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.history,
                                        color: blue,
                                        size: 100.h.w,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'NO HISTORY',
                                        style: TextStyle(
                                          color: blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
