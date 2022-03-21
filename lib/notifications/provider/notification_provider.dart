import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  bool _notificationPageVisited = false;
  bool _listIsEmpty = false;
  int _items = 0;

  bool get notificationPageVisited => _notificationPageVisited;
  bool get listIsEmpty => _listIsEmpty;
  int get items => _items;

  void listInNotifacationPage() {
    _items = items;

    notifyListeners();
  }

  void getAllItems(int item) {
    _items = item;
    notifyListeners();
  }

  void triggerNotificationPage() {
    _notificationPageVisited = !notificationPageVisited;
    _listIsEmpty = true;
    _items = 0;
    notifyListeners();
  }
}
