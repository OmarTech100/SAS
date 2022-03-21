import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/Home/widgets/home_btn.dart';
import 'package:kayan/Home/widgets/refreshWidget.dart';
import 'package:kayan/Home/widgets/top_action_bar.dart';
import 'package:kayan/Home/widgets/top_profile_info.dart';
import 'package:kayan/Home/widgets/total_jobs.dart';
import 'package:kayan/VerifyPhoneNumber/screens/verify_phone_number_screen.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:kayan/deliveryTypes/providers/delivery_types_provider.dart';
import 'package:kayan/deliveryTypes/screens/delivery_types_screen.dart';
import 'package:kayan/history/screens/history_screen.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/notifications/provider/notification_provider.dart';
import 'package:kayan/notifications/screens/notification_screen.dart';
import 'package:kayan/profile/screens/userProfile.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/support/screens/support.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/wallet/screens/wallet_screen.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _deliveryStatus = DeliveryStatus();

  final ordersCount = [];

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  List<Order> pushOrder(
      {AsyncSnapshot<List<Order>>? snapshot,
      String? deliveryType,
      int? index}) {
    List<Order> updatedOrder = [];
    Order _order = Order();
    snapshot!.data!.forEach((order) {
      if (order.type == deliveryType &&
          (order.deliveryStatus == _deliveryStatus.pending ||
              order.deliveryStatus == _deliveryStatus.pendingCollection ||
              order.deliveryStatus == _deliveryStatus.onRoute ||
              order.deliveryStatus == _deliveryStatus.pickedUp)) {
        _order = order;
        updatedOrder.add(_order);

        print(_order.orderId);
      }
    });

    return updatedOrder;
  }

  List<Order> showNotifications(
      {AsyncSnapshot<List<Order>>? snapshot, String? deliveryType}) {
    List<Order> updatedOrder = [];

    snapshot!.data!.forEach((order) {
      if (order.type == deliveryType &&
          (order.deliveryStatus == _deliveryStatus.pending ||
              order.deliveryStatus == _deliveryStatus.pendingCollection)) {
        updatedOrder.add(order);
      }
    });

    return updatedOrder;
  }

  @override
  Widget build(BuildContext context) {
    final _deliveryTypes = Provider.of<DeliveryTypesProvider>(context);
    final _dbProvider = Provider.of<DatabaseServices>(context);
    final _notificationProvider = Provider.of<NotificationProvider>(context);

    Future<void> refreshOrders() async {
      await _dbProvider.fetchAvilableOrders();
      setState(() {});
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: LayoutBuilder(
          builder: (context, constrains) => Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SvgPicture.asset(
                      panelBackGraound,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 30.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Spacer(),
                          TopDrawerProfileInfo(
                            firstName: _dbProvider.driver!.firstName!,
                            lastName: _dbProvider.driver!.lastName!,
                            memberRating: 'Golden',
                            memberShipColor: Colors.yellow,
                            profileImage: _dbProvider.driver!.personalPhoto!,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spa,
                            children: [
                              TotalJobsWidget(
                                  totalJobs:
                                      _dbProvider.driver!.totalJobs! != "0"
                                          ? _dbProvider.driver!.totalJobs!
                                              .replaceFirst("0", "")
                                          : _dbProvider.driver!.totalJobs!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SideBarButtons(
                      buttonName: LocaleKeys.home.tr(),
                      icon: homeSettingsIcon,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.myWallet.tr(),
                      icon: walletSettingsIcon,
                      onTap: () {
                        Navigator.of(context).push(fadeRoute(WalletScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.history.tr(),
                      icon: historySettingsIcon,
                      onTap: () {
                        Navigator.of(context).push(fadeRoute(HistoryScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.notifications.tr(),
                      icon: notificationsSettingIcon,
                      onTap: () {
                        Navigator.of(context)
                            .push(fadeRoute(NotificationsScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.settings.tr(),
                      icon: settingsIcon,
                      onTap: () {
                        _closeDrawer();

                        Navigator.of(context)
                            .push(fadeRoute(DriverProfileScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.logout.tr(),
                      icon: logoutIcon,
                      onTap: () {
                        Navigator.of(context).pop();
                        _dbProvider.logOut();
                        Navigator.of(context)
                            .pushReplacement(fadeRoute(VerifyPhoneScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 8.h),
                    SideBarButtons(
                      buttonName: LocaleKeys.support.tr(),
                      icon: helpIcon,
                      onTap: () {
                       _closeDrawer();

                        Navigator.of(context)
                            .push(fadeRoute(Support()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                FutureBuilder(
                    future: _dbProvider.getDriverInfo(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Platform.isIOS
                              ? CupertinoActivityIndicator()
                              : CircularProgressIndicator(),
                        );
                      }
                      return TopActionBar(
                        openDrawer: _openDrawer,
                        userName: _dbProvider.driver!.firstName!,
                        location:
                            '${_dbProvider.driver!.city}, ${LocaleKeys.saudiArabia.tr()}',
                        userImage: _dbProvider.driver!.personalPhoto!,
                        notification: notificationBell,
                        notifications: _notificationProvider.items,
                      );
                    }),
                SizedBox(height: 13.h),
                Flexible(
                  // flex: 1,
                  child: Container(
                    height: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.r),
                        topRight: Radius.circular(60.r),
                      ),
                      color: Color.fromRGBO(72, 178, 255, .1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.readyForDelivery.tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: blue,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Flexible(
                          child: StreamBuilder<List<Order>>(
                              stream:
                                  _dbProvider.fetchAvilableOrders().asStream(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: LoadingWidget());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error'));
                                }

                                return RefreshWidget(
                                  onRefresh: refreshOrders,
                                  child: GridView.builder(
                                    dragStartBehavior: DragStartBehavior.start,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                      mainAxisExtent: 130.h,
                                      childAspectRatio: 1.15.w,
                                    ),
                                    itemCount: _deliveryTypes.types().length,
                                    itemBuilder: (context, index) {
                                      final _type = _deliveryTypes
                                          .types2()[index]
                                          .keys
                                          .first;
                                      return Padding(
                                        padding: EdgeInsets.all(5.w.h),
                                        child: InkWell(
                                          onTap: () {
                                            showNotifications(
                                                    snapshot: snapshot,
                                                    deliveryType: _type)
                                                .clear();
                                            Navigator.of(context)
                                                .push(fadeRoute(
                                              DeliveryTypesScreen(
                                                numberOfOrders: pushOrder(
                                                        snapshot: snapshot,
                                                        deliveryType: _type)
                                                    .length,
                                                title: _deliveryTypes
                                                    .types()[index]
                                                    .keys
                                                    .first,
                                                order: pushOrder(
                                                    snapshot: snapshot,
                                                    deliveryType: _type),
                                              ),
                                            ));
                                          },
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.blue.shade100,
                                                      spreadRadius: 0,
                                                      blurRadius: 6,
                                                      offset: Offset.zero,
                                                    ),
                                                  ],
                                                ),
                                                child: LayoutBuilder(builder:
                                                    (context, constrains) {
                                                  return Column(
                                                    children: [
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        _deliveryTypes
                                                            .types()[index]
                                                            .keys
                                                            .first,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                            '(${pushOrder(snapshot: snapshot, deliveryType: _type).length} ${LocaleKeys.ordersAvilable.tr()})'),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                              Positioned(
                                                bottom: 0.h,
                                                left: 0.w,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: SvgPicture.asset(
                                                    _deliveryTypes
                                                        .types()[index]
                                                        .values
                                                        .first[1],
                                                    height: 40.h,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.h,
                                                right: 0.w,
                                                child: SvgPicture.asset(
                                                  _deliveryTypes
                                                      .types()[index]
                                                      .values
                                                      .first[2],
                                                  height: 50.h,
                                                ),
                                              ),
                                              showNotifications(
                                                              snapshot:
                                                                  snapshot,
                                                              deliveryType:
                                                                  _type)
                                                          .length >
                                                      0
                                                  ? Positioned(
                                                      left: -3.w,
                                                      top: -1.h,
                                                      child: Lottie.asset(
                                                        'assets/newOrder.json',
                                                        height: 30.h,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                        )
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
