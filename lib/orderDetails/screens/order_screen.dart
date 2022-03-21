import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/orderDetails/widgets/buildOrderActiondialago.dart';
import 'package:kayan/orderDetails/widgets/orderDetails_widget.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:map_launcher/map_launcher.dart' as map;

class OrderScreen extends StatefulWidget {
  final Order order;

  OrderScreen({
    required this.order,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _deliveryStatus = DeliveryStatus();
  bool _isLoading = false;
  bool _deliveredOrRejected = false;
  bool _delivered = false;

  Future<void> goToPickUp() async {
    await map.MapLauncher.showMarker(
      mapType: map.MapType.google,
      coords: map.Coords(double.parse(widget.order.pickUpLocation!.latitude!),
          double.parse(widget.order.pickUpLocation!.longitude!)),
      title: widget.order.brandName!,
      description: widget.order.orderId,
    );
  }

  Future<void> goToDeliver() async {
    await map.MapLauncher.showMarker(
      mapType: map.MapType.google,
      coords: map.Coords(double.parse(widget.order.dropOffLocation!.latitude!),
          double.parse(widget.order.dropOffLocation!.longitude!)),
      title: widget.order.customer!.address!,
      description: widget.order.orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<DatabaseServices>(context);
    Future<void> refreshOrders() async {
      _orderProvider.fetchAvilableOrders();
      Navigator.of(context).setState(() {});
    }

    Future<void> refreshDriverStatus() async {
      _orderProvider.getDriverInfo();
      Navigator.of(context).setState(() {});
    }

    Color properDeliveryStatusColor() {
      Color color = Colors.white;
      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order.orderId) {
          if (order.deliveryStatus == _deliveryStatus.pending) {
            color = yellow;
          } else if (order.deliveryStatus ==
              _deliveryStatus.pendingCollection) {
            color = orange;
          } else if (order.deliveryStatus == _deliveryStatus.pickedUp) {
            color = orange;
          } else if (order.deliveryStatus == _deliveryStatus.delivered) {
            color = green;
          } else if (order.deliveryStatus == _deliveryStatus.onRoute) {
            color = purple;
          } else if (order.deliveryStatus == _deliveryStatus.rejected) {
            color = red;
          }
        }
      });
      return color;
    }

    String propperDeliveryStatusTextArEn() {
      String deliverStatus = '';
      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order.orderId) {
          if (order.deliveryStatus == _deliveryStatus.pending) {
            deliverStatus = LocaleKeys.pending.tr();
          } else if (order.deliveryStatus ==
              _deliveryStatus.pendingCollection) {
            deliverStatus = LocaleKeys.pendingCollection.tr();
          } else if (order.deliveryStatus == _deliveryStatus.pickedUp) {
            deliverStatus = LocaleKeys.pickedUp.tr();
          } else if (order.deliveryStatus == _deliveryStatus.onRoute) {
            deliverStatus = LocaleKeys.onRoute.tr();
          } else if (order.deliveryStatus == _deliveryStatus.delivered) {
            deliverStatus = LocaleKeys.delivered.tr();
          } else if (order.deliveryStatus == _deliveryStatus.rejected) {
            deliverStatus = LocaleKeys.rejected.tr();
          }
        }
      });
      return deliverStatus;
    }

    String propperButtonText() {
      String deliverStatus = '';
      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order.orderId) {
          if (order.deliveryStatus == _deliveryStatus.pending) {
            deliverStatus = LocaleKeys.acceptOrder.tr();
          } else if (order.deliveryStatus ==
              _deliveryStatus.pendingCollection) {
            deliverStatus = LocaleKeys.confirmPickUp.tr();
          } else if (order.deliveryStatus == _deliveryStatus.pickedUp ||
              order.deliveryStatus == _deliveryStatus.onRoute) {
            deliverStatus = LocaleKeys.confirmDropOff.tr();
          } else if (order.deliveryStatus == _deliveryStatus.delivered ||
              order.deliveryStatus == _deliveryStatus.rejected) {
            deliverStatus = LocaleKeys.goToHomePage.tr();
          }
        }
      });
      return deliverStatus;
    }

    String propperDeliveryStatusInApi() {
      String deliverStatus = '';
      _orderProvider.orderList!.forEach((order) {
        if (order.orderId == widget.order.orderId) {
          deliverStatus = order.deliveryStatus!;
        }
      });
      return deliverStatus;
    }

    return TimerBuilder.periodic(
      Duration(microseconds: 600),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: _isLoading ? Colors.black26 : Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: !_deliveredOrRejected
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: blue,
                    size: 30.h.w,
                  ))
              : Container(),
          title: Column(
            children: [
              Text(
                widget.order.brandName!,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '${LocaleKeys.orderNumber.tr()}  #${widget.order.orderId}',
                style: TextStyle(color: Colors.grey, fontSize: 15.sp),
              ),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Flexible(
                    child: OrderDetailsWidget(
                      onPickUpMapPressed: () async {
                        goToPickUp();
                      },
                      onDropOffMapPressed: () async {
                        goToDeliver();
                        refreshOrders();
                      },
                      buttonText: propperButtonText(),
                      buttonColor: green,
                      deliveryStatusColor: properDeliveryStatusColor(),
                      deliveryStatusTextEnAr: propperDeliveryStatusTextArEn(),
                      deliveryStatusTextInApi: propperDeliveryStatusInApi(),
                      textInBottonColor: Colors.white,
                      pickUpMapPressd: false,
                      dropOffMapPressed: false,
                      order: widget.order,
                      onCall: () =>
                          launch('tel:${widget.order.customer!.phoneNumber}'),
                      acceptOrder: () async {
                        refreshOrders();
                        setState(() {
                          _isLoading = true;
                        });

                        await _orderProvider.updateOrderStatus(
                            orderId: widget.order.orderId,
                            deliveryStatus: _deliveryStatus.pendingCollection);
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      confirmPickUp: () {
                        showDialog(
                          context: context,
                          builder: (context) => OrderActionDialog(
                            title: LocaleKeys.confirmPickUp.tr(),
                            content:
                                '${LocaleKeys.areUsureToConfirmPickUp.tr()} #'
                                '${widget.order.orderId}',
                            onOk: () async {
                              Navigator.of(context).pop();
                              refreshOrders();
                              refreshDriverStatus();
                              setState(() {
                                _isLoading = true;
                              });
                              await _orderProvider.updateOrderStatus(
                                  orderId: widget.order.orderId,
                                  deliveryStatus: _deliveryStatus.pickedUp);
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                      confirmDropOff: () {
                        showDialog(
                          context: context,
                          builder: (context) => OrderActionDialog(
                            title: LocaleKeys.confirmDropOff.tr(),
                            content:
                                '${LocaleKeys.areUsureToConfirmDropOff.tr()} #'
                                '${widget.order.orderId}',
                            onOk: () async {
                              Navigator.of(context).pop();
                              refreshOrders();
                              setState(() {
                                _deliveredOrRejected = true;

                                _isLoading = true;
                              });

                              await _orderProvider.updateOrderStatus(
                                  orderId: widget.order.orderId,
                                  deliveryStatus: _deliveryStatus.delivered);
                              await _orderProvider.updateDriverTotalJops(
                                  uid: int.parse(_orderProvider.driverId!),
                                  totalJobs: int.parse(
                                          _orderProvider.driver!.totalJobs!) +
                                      1);
                              setState(() {
                                _isLoading = false;
                                _delivered = true;
                              });
                              FlutterRingtonePlayer.play(
                                android: AndroidSounds.notification,
                                ios: IosSounds.bell,
                                looping: false,
                                volume: 0.1,
                                asAlarm: false,
                              );
                              Timer(Duration(seconds: 2), () {
                                setState(() {
                                  _delivered = false;
                                });
                              });

                              // Navigator.of(context).pushAndRemoveUntil(
                              //     fadeRoute(HomePage()), (route) => false);
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                      onOrderRejected: () {
                        showDialog(
                          context: context,
                          builder: (context) => OrderActionDialog(
                            title: LocaleKeys.rejectOrder.tr(),
                            content:
                                '${LocaleKeys.areUsureUwantToCancelOrder.tr()} #'
                                '${widget.order.orderId}',
                            onOk: () async {
                              Navigator.of(context).pop();
                              refreshOrders();
                              setState(() {
                                _deliveredOrRejected = true;
                                _isLoading = true;
                              });

                              await _orderProvider.updateOrderStatus(
                                  orderId: widget.order.orderId,
                                  deliveryStatus: _deliveryStatus.rejected);

                              setState(() {
                                _isLoading = false;
                              });
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black26,
                    child: LoadingWidget(),
                  )
                : Container(),
            _delivered
                ? Lottie.asset('assets/completed.json',
                    repeat: false, alignment: Alignment.center)
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
