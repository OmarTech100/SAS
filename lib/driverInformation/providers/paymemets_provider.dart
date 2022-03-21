import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String _svgName = '';
  String _paymentNumber = '';
  String _paymentMethod = '';
  bool _paymentAdedd = false;

  String get svgName => _svgName;
  String get paymentNumber => _paymentNumber;
  String get paymentMethod => _paymentMethod;
  bool get paymentAdded => _paymentAdedd;

  void setPyment(String svg, String paymentNo, String payMethod) {
    _svgName = svg;
    _paymentNumber = paymentNo;
    _paymentMethod = payMethod;
    _paymentAdedd = true;
    notifyListeners();
  }
}
