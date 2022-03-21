import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayan/Home/screens/home_page.dart';
import 'package:kayan/VerifyPhoneNumber/screens/verify_phone_number_screen.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/driverInformation/screens/congratulations_scree.dart';
import 'package:kayan/driverInformation/screens/driver_info_screen.dart';
import 'package:kayan/models/driver/driver.dart';
import 'package:http/http.dart' as http;
import 'package:kayan/models/order/order.dart';
import '.env.dart';

class DatabaseServices with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  bool? driverhasData;
  bool? customerHasData;

//checks if user has data in database
  Future<Map<String, dynamic>> checkIfDataHasCompleted2() async {
    final _phoneNumber = _auth.currentUser!.phoneNumber!.substring(1, 13);
    final http.Response response = await http.get(
      Uri.parse(driverGetUrl + _phoneNumber),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  // check the user reg proccess.
  Future<bool> checkUserStatus2(BuildContext context) async {
    final _phoneNumber = _auth.currentUser!.phoneNumber!.substring(1, 13);
    bool _isActivated = false;
    try {
      final http.Response response = await http.get(
        Uri.parse(driverGetUrl + _phoneNumber),
      );
      if (response.body.isEmpty) {
        Navigator.of(context).pushReplacement(fadeRoute(VerifyPhoneScreen()));
      } else {
        final fields = jsonDecode(response.body);
        if (fields.isEmpty)
          Navigator.of(context).push(fadeRoute(DriverInfoScreen()));
        if (fields['hasCompletedRegForm'] == '1' && fields['status'] == '1') {
          Navigator.of(context).pushReplacement(fadeRoute(HomePage()));
          _isActivated = true;
        } else if (fields['hasCompletedRegForm'] == '0' &&
            fields['status'] == '0') {
          Navigator.of(context).pushReplacement(fadeRoute(DriverInfoScreen()));
        } else if (fields['hasCompletedRegForm'] == '1' &&
            fields['status'] == '0') {
          _isActivated = false;
          Navigator.of(context).pushReplacement(fadeRoute(CongartsScreen()));
        }
      }
    } catch (e) {
      print("------------------->" + e.toString());
    }
    return _isActivated;
  }

  // POST METHOD / POST DRIVER INFO TO THE DATABASE
  Future<void> postDriver(Driver driver) async {
    try {
      final Map<String, dynamic> driverMap = driver.toMap();
      final String body = jsonEncode(driverMap);
      final http.Response response = await http.post(
        Uri.parse(driverPostUrl),
        body: body,
      );

      print(response.body);
    } catch (e) {
      print("------------------->" + e.toString());
    }
    // notifyListeners();
  }

  // FETCH METHOD / POST DRIVER INFO TO THE D ATABASE
  Driver? _driver;
  Driver? get driver => _driver;
  String? _driverId;
  String? get driverId => _driverId;
  Future<Driver> getDriverInfo() async {
    final _phoneNumber = _auth.currentUser!.phoneNumber!.substring(1, 13);

    final response = await http.get(
      Uri.parse(driverGetUrl + _phoneNumber),
    );

    final driverMap = jsonDecode(response.body);
    _driverId = driverMap['uid'];
    final thisDriver = Driver.fromMap(driverMap);
    _driver = thisDriver;
    // print(driverMap);
    // notifyListeners();

    return thisDriver;
  }

  // UPDATE METHOD / POST DRIVER INFO TO THE DATABASE
  Future<void> updateDriverTotalJops({int? uid, int? totalJobs}) {
    return http.patch(
      Uri.parse(driverUpdateUrl),
      body: jsonEncode(
        <String?, int?>{
          "uid": uid,
          "totalJobs": totalJobs,
        },
      ),
    );
  }

  Future<void> updateDriverPhoto({String? uid, File? personalPhoto}) async {
    final _personalImageFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('${driver!.firstName}' ' ${driver!.lastName}')
        .child('Personal Files Images')
        .child('Profile picture')
        .putFile(personalPhoto!);
    _personalImage = await _personalImageFile.ref.getDownloadURL();
    http.patch(
      Uri.parse(driverUpdateUrl),
      body: jsonEncode(
        <String?, String>{
          "uid": uid!,
          "personalPhoto": _personalImage!,
        },
      ),
    );
  }

  Order? _order;
  Order? get order => _order;

  List<Order>? _orderList;
  List<Order>? get orderList => _orderList;

  // fetch orders by userId
  Future<List<Order>> fetchAvilableOrders() async {
    // getting all orders based on the driverId ...
    final _phoneNumber = _auth.currentUser!.phoneNumber!.substring(1, 13);
    final response = await http.get(
      Uri.parse(driverGetUrl + _phoneNumber),
    );
    final driverMap = jsonDecode(response.body);
    final driverId = driverMap['uid'];
    final orderResponse = await http.get(Uri.parse(orderGetUrl + driverId!));
    final List parsedOrder = jsonDecode(orderResponse.body);
    final List<Order> tempList =
        parsedOrder.map((e) => Order.fromJson(e)).toList();
    List<Order> tempList2 = [];
    tempList.forEach((order) {
      tempList2.add(order);
      _order = order;
      print('called');
    });

    _orderList = tempList2;
    return tempList2;
  }

  Future<void> updateOrderStatus({String? orderId, String? deliveryStatus}) {
    return http.patch(
      Uri.parse(orderUpdateUrl),
      body: jsonEncode(
        <String?, String?>{
          "orderId": orderId,
          "deliveryStatus": deliveryStatus,
        },
      ),
    );
  }

  String? _personalImage,
      _carFrontImage,
      _carBackImage,
      _carLeftImage,
      _carRightImage,
      _idCardImage,
      _drivingLicenseImage,
      _carRegImage;

  String? get personalImage => _personalImage;
  String? get carFrontImage => _carFrontImage;
  String? get carBackImage => _carBackImage;
  String? get carLeftImage => _carLeftImage;
  String? get carRightImage => _carRightImage;
  String? get idCardImage => _idCardImage;
  String? get drivingLicenseImage => _drivingLicenseImage;
  String? get carRegImage => _carRegImage;

  // update driver photo
  Future<void> updateDriverPersonalPic(File? personalImage) async {
    final _personalImageFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('${driver!.lastName}' ' ${driver!.firstName}')
        .child('Personal Files Images')
        .child('Profile picture')
        .putFile(personalImage!);
    _personalImage = await _personalImageFile.ref.getDownloadURL();
  }
  // upload photo to firestorage

  Future<void> uploadDriverPictures(
      {File? personalImage,
      File? carFrontImage,
      File? carBackImage,
      File? carLeftImage,
      File? carRightImage,
      File? idCardImage,
      File? driverLicenseImage,
      File? carRegImage,
      required String firstName,
      required String lastName}) async {
    final _personalImageFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Personal Files Images')
        .child('Profile picture')
        .putFile(personalImage!);
    _personalImage = await _personalImageFile.ref.getDownloadURL();
    //-----------

    final _carFrontFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Car Images')
        .child('Car front side image')
        .putFile(carFrontImage!);
    _carFrontImage = await _carFrontFile.ref.getDownloadURL();

    ///-----------
    final _carBackFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Car Images')
        .child('Car back side image')
        .putFile(carBackImage!);
    _carBackImage = await _carBackFile.ref.getDownloadURL();
    //---------------------------------------
    final _carLeftFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Car Images')
        .child('Car left side image')
        .putFile(carLeftImage!);
    _carLeftImage = await _carLeftFile.ref.getDownloadURL();
    //----------------------------
    final _carRightFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Car Images')
        .child('Car right side image')
        .putFile(carRightImage!);
    _carRightImage = await _carRightFile.ref.getDownloadURL();
    //-----------------------------------
    final _idCardFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Personal Files Images')
        .child('Id Card')
        .putFile(idCardImage!);
    _idCardImage = await _idCardFile.ref.getDownloadURL();

    //------------------------------
    final _drivingLicenseFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Personal Files Images')
        .child('Driving License')
        .putFile(driverLicenseImage!);
    _drivingLicenseImage = await _drivingLicenseFile.ref.getDownloadURL();
    //-----------------------------------
    final _carRegFile = await _storage
        .ref('drivers')
        .child(_auth.currentUser!.uid)
        .child('$firstName' ' $lastName')
        .child('Personal Files Images')
        .child('Car registration')
        .putFile(carRegImage!);
    _carRegImage = await _carRegFile.ref.getDownloadURL();
  }

  void logOut() {
    _auth.signOut();
  }
}
