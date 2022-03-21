import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kayan/models/order/order.dart';
import 'package:kayan/service/database.dart';

class OrderManager with ChangeNotifier {
  Stream<List<Order>> orderList() async* {
    yield await DatabaseServices().fetchAvilableOrders();
  }
}
