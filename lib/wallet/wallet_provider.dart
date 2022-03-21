import 'package:flutter/material.dart';

class WalletProvider with ChangeNotifier {
  bool _cashBoxSelected = true;
  bool _balanceBoxSelected = false;
  bool _discountBoxSelected = false;


  bool get cashBoxSelected => _cashBoxSelected;
  bool get balanceBoxSelected => _balanceBoxSelected;
  bool get discountBoxSelected => _discountBoxSelected;


  void inCashBoxSelect() {
    _cashBoxSelected = true;
    _balanceBoxSelected = false;
    _discountBoxSelected = false;
    notifyListeners();
  }

  void inBalanceBoxSelect() {
      _cashBoxSelected = false;
    _balanceBoxSelected = true;
    _discountBoxSelected = false;
    
    notifyListeners();
  }
  void inDiscountBoxSelect() {
      _cashBoxSelected = false;
    _balanceBoxSelected = false;
    _discountBoxSelected = true;
    notifyListeners();
  }
}
