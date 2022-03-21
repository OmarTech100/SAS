import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayan/Home/screens/home_page.dart';
import 'package:kayan/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kayan/constants/predefid_api_values.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayan/service/.env.dart';

class OrderDetailsWidget extends StatefulWidget {
  final Order order;
  final bool pickUpMapPressd;
  final bool dropOffMapPressed;
  final Color deliveryStatusColor;
  final Color buttonColor;
  final Color textInBottonColor;
  final String buttonText;
  final String deliveryStatusTextEnAr;
  final String deliveryStatusTextInApi;

  final void Function()? onCall;
  final void Function()? acceptOrder;
  final void Function()? confirmPickUp;
  final void Function()? confirmDropOff;

  final void Function()? onOrderRejected;
  final void Function()? onPickUpLocationPressed;
  final void Function()? onDropOffLocationPressed;
  final void Function()? onOrderDetailsPressed;
  final void Function()? onPickUpMapPressed;
  final void Function()? onDropOffMapPressed;

  OrderDetailsWidget({
    required this.textInBottonColor,
    required this.deliveryStatusTextInApi,
    required this.deliveryStatusTextEnAr,
    required this.buttonColor,
    required this.buttonText,
    required this.deliveryStatusColor,
    required this.dropOffMapPressed,
    required this.pickUpMapPressd,
    required this.order,
    this.onCall,
    this.acceptOrder,
    this.confirmPickUp,
    this.confirmDropOff,
    this.onOrderRejected,
    this.onPickUpLocationPressed,
    this.onDropOffLocationPressed,
    this.onOrderDetailsPressed,
    this.onPickUpMapPressed,
    this.onDropOffMapPressed,
  });

  @override
  _OrderDetailsWidgetState createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget>
    with SingleTickerProviderStateMixin {
  final _deliveryStatus = DeliveryStatus();
  Color deliveryStatusColor = green;
  String _pickUpAddress = '';
  String _dropOfAddress = '';
  AnimationController? _animationController;
  Animation? _animation;
  final String googleApiKey = gApiKey;
  GoogleMapController? mapController;
  Marker? _pickUpMarker;
  Marker? _dropOffMarker;

  //-----------------------------

  void _onMapCreated(GoogleMapController controller) async {
    try {
      mapController = controller;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _setMarker() async {
    _pickUpMarker = Marker(
      markerId: MarkerId(LocaleKeys.pickUp.tr()),
      infoWindow: InfoWindow(title: LocaleKeys.pickUp.tr()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(double.parse(widget.order.pickUpLocation!.latitude!),
          double.parse(widget.order.pickUpLocation!.longitude!)),
    );
    _dropOffMarker = Marker(
      markerId: MarkerId(LocaleKeys.dropOff.tr()),
      infoWindow: InfoWindow(title: LocaleKeys.dropOff.tr()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(double.parse(widget.order.dropOffLocation!.latitude!),
          double.parse(widget.order.dropOffLocation!.longitude!)),
    );
  }

  Widget buildPickUpDirectionMap() {
    return ClipRRect(
      child: GoogleMap(
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        onMapCreated: _onMapCreated,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.order.pickUpLocation!.latitude!),
              double.parse(widget.order.pickUpLocation!.longitude!)),
          zoom: 18,
        ),
        markers: {
          _pickUpMarker!,
        },
      ),
    );
  }

  Widget buildDropOffDirectionMap() {
    return ClipRRect(
      child: GoogleMap(
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        onMapCreated: _onMapCreated,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.order.dropOffLocation!.latitude!),
              double.parse(widget.order.dropOffLocation!.longitude!)),
          zoom: 18,
        ),
        markers: {
          _dropOffMarker!,
        },
      ),
    );
  }

  Widget _buildPickUpMap() {
    return InkWell(
      onTap: widget.onPickUpMapPressed,
      child: Container(
        height: 80.h,
        width: 200.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: blue, width: 3.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_rounded, color: blue, size: 28.h.w),
            SizedBox(height: 3.h),
            Text(
              LocaleKeys.goToPickUp.tr(),
              style: TextStyle(
                color: blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropOffMap() {
    return InkWell(
      onTap: widget.onDropOffMapPressed,
      child: Container(
        height: 80.h,
        width: 200.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: blue, width: 3.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_rounded, color: blue, size: 28.h.w),
            SizedBox(height: 3.h),
            Text(
              LocaleKeys.goToDropOff.tr(),
              style: TextStyle(color: blue),
            )
          ],
        ),
      ),
    );
  }

  builOrderDetailsSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r))),
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                        size: 30.h.w,
                      )),
                  Text(
                    LocaleKeys.orderDetails.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  clipBehavior: Clip.antiAlias,
                  itemCount: widget.order.orderItems!.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: blue,
                      child: Text(
                        double.parse(widget.order.orderItems![index].quantity!)
                            .floor()
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ),
                    title: Text(
                      widget.order.orderItems![index].description!,
                      style: TextStyle(color: blue),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        height: 300.h,
        decoration: BoxDecoration(),
      ),
    );
  }

  buildPickUpBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r))),
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                        size: 30.h.w,
                      )),
                  Text(
                    LocaleKeys.pickUp.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: buildPickUpDirectionMap(),
            ),
          ],
        ),
        height: 300.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r))),
      ),
    );
  }

  buildDropOffBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r))),
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                        size: 30.h.w,
                      )),
                  Text(
                    LocaleKeys.dropOff.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: buildDropOffDirectionMap(),
            ),
          ],
        ),
        height: 300.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r))),
      ),
    );
  }

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
    _setMarker();

    getPickUpLocationFromCoordinates(
        latitude: double.parse(widget.order.pickUpLocation!.latitude!),
        longitude: double.parse(widget.order.pickUpLocation!.longitude!));
    getDropOffLocationFromCoordinates(
      latitude: double.parse(widget.order.dropOffLocation!.latitude!),
      longitude: double.parse(widget.order.dropOffLocation!.longitude!),
    );

    setState(() {});

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      lowerBound: .7,
    );
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _animationController!.forward();
    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController!.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _animationController!.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    if (mapController != null) {
      mapController!.dispose();
    }
    _animationController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundImage: NetworkImage(widget.order.brandPicture!),
              ),
              Column(
                children: [
                  Text(
                    '${widget.order.customer!.firstName}'
                    ' ${widget.order.customer!.lastName}',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 110.w,
                        height: 30.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            width: 3.w,
                            color: widget.deliveryStatusColor,
                          ),
                        ),
                        child: Text(
                          widget.deliveryStatusTextEnAr,
                          style: TextStyle(
                              color: widget.deliveryStatusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp),
                        ),
                      ),
                      SizedBox(height: 5.w),
                      Container(
                        width: 110.w,
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
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(f.format(widget.order.orderTime!)),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${widget.order.amount} ${LocaleKeys.sar.tr()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.h),
                ],
              )
            ],
          ),

          Divider(),
          // SizedBox(height: 3),
          Column(
            children: [
              InkWell(
                onTap: buildPickUpBottomSheet,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: lightBlueGrey,
                        radius: 15.r,
                        child: Icon(
                          Icons.location_on,
                          size: 14.h.w,
                          color: Colors.black,
                        )),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.pickUp.tr(),
                          style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Text(
                            _pickUpAddress,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 3),
              Divider(),
              // SizedBox(height: 3),
              InkWell(
                onTap: buildDropOffBottomSheet,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: lightBlueGrey,
                      radius: 15.r,
                      child: Icon(
                        Icons.location_on,
                        size: 14.h.w,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.dropOff.tr(),
                          style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Text(
                            _dropOfAddress,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 3),
          Divider(),
          // SizedBox(height: 3),
          Expanded(
            child: InkWell(
              onTap: builOrderDetailsSheet,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.orderDetails.tr(),
                    style: TextStyle(color: grey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3.h),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.order.orderItems!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.order.orderItems![index].description!,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.order.orderItems![index].quantity! + 'x',
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(height: 3),
          Divider(),
          // SizedBox(height: 3),
          Text(
            LocaleKeys.tripFare.tr(),
            style: TextStyle(color: grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.order.paymentMethod!,
                      style: TextStyle(fontSize: 15.sp)),
                  Text('${widget.order.amount} ${LocaleKeys.sar.tr()}',
                      style: TextStyle(fontSize: 15.sp)),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${LocaleKeys.discount.tr()}',
                      style: TextStyle(fontSize: 15.sp)),
                  Text('${widget.order.discount}',
                      style: TextStyle(fontSize: 15.sp)),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${LocaleKeys.payedAmount.tr()}',
                      style: TextStyle(fontSize: 15.sp)),
                  Text('${widget.order.orderTotal} ${LocaleKeys.sar.tr()}',
                      style: TextStyle(fontSize: 15.sp)),
                ],
              ),
            ],
          ),
          Flexible(child: SizedBox(height: 20.h)),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [],
          // ),
          // SizedBox(height: 60.h),
          widget.deliveryStatusTextInApi == _deliveryStatus.pending
              ? InkWell(
                  highlightColor: Colors.red.shade200,
                  splashColor: Colors.red.shade200,
                  focusColor: Colors.red.shade200,
                  onTap: widget.onOrderRejected,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: red, width: 3.w),
                    ),
                    height: 60.h,
                    width: 325.w,
                    child: Text(
                      LocaleKeys.rejectOrder.tr(),
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                )
              : widget.deliveryStatusTextInApi != _deliveryStatus.rejected
                  ? Container(
                      // width: double.infinity,
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: widget.onCall,
                            child: Container(
                              height: 80.h,
                              width: widget.deliveryStatusTextInApi ==
                                          _deliveryStatus.delivered ||
                                      widget.deliveryStatusTextInApi ==
                                          _deliveryStatus.rejected
                                  ? 325.w
                                  : 108.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: green,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    color: Colors.white,
                                    size: 28.h.w,
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    LocaleKeys.call.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: widget.deliveryStatusTextInApi ==
                                                    _deliveryStatus.delivered ||
                                                widget.deliveryStatusTextInApi ==
                                                    _deliveryStatus.rejected
                                            ? 20.sp
                                            : 15.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          widget.deliveryStatusTextInApi ==
                                  _deliveryStatus.pendingCollection
                              ? _buildPickUpMap()
                              : widget.deliveryStatusTextInApi ==
                                          _deliveryStatus.pickedUp ||
                                      widget.deliveryStatusTextInApi ==
                                          _deliveryStatus.onRoute
                                  ? _buildDropOffMap()
                                  : SizedBox(),
                        ],
                      ),
                    )
                  : SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              if (widget.deliveryStatusTextInApi == _deliveryStatus.pending) {
                widget.acceptOrder!();
              }
              if (widget.deliveryStatusTextInApi ==
                  _deliveryStatus.pendingCollection) {
                widget.confirmPickUp!();
              }
              if (widget.deliveryStatusTextInApi == _deliveryStatus.pickedUp) {
                widget.confirmDropOff!();
              }
              if (widget.deliveryStatusTextInApi == _deliveryStatus.delivered) {
                Navigator.of(context).pushAndRemoveUntil(
                    fadeRoute(HomePage()), (route) => false);
              }
              if (widget.deliveryStatusTextInApi == _deliveryStatus.rejected) {
                Navigator.of(context).pushAndRemoveUntil(
                    fadeRoute(HomePage()), (route) => false);
              }
            },
            child: AnimatedBuilder(
                animation: _animationController!,
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.deliveryStatusTextInApi ==
                              _deliveryStatus.pending
                          ? darkgreen.withOpacity(_animation!.value)
                          : widget.buttonColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: widget.deliveryStatusTextInApi ==
                                  _deliveryStatus.pending
                              ? darkgreen
                              : widget.buttonColor,
                          width: 3.w),
                    ),
                    height: 80.h,
                    width: 325.w,
                    child: Text(
                      widget.buttonText,
                      style: TextStyle(
                        color: widget.textInBottonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
