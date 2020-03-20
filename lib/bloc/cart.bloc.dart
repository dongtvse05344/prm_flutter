import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/model/useraddress.dart';

class CartBloc with ChangeNotifier {
  Map<int, Product> _cart = {};
  Map<int, Product> get cart => _cart;

  Order _order = Order();
  Order get order => _order;

  double totalAmount (){
    double res = 0;
    _cart.forEach((i,p){
      res += p.quantity *p.currentPrice;
    });
    return res;
  }

  void setAddress(UserAddress userAddress) {
    _order = Order();
    _order.address = userAddress.address;
    _order.receiver = userAddress.name;
    _order.phoneNumber = userAddress.phoneNumber;
    notifyListeners();
  }

  void setNote(String note) {
    _order.address = note;
  }

  void addToCart(Product product) {
    if (_cart.containsKey(product.id)) {
    } else {
      _cart[product.id] = product;
    }
    notifyListeners();
  }

  void clear(product) {
    if (_cart.containsKey(product.id)) {
      _cart.remove(product.id);
      notifyListeners();
      print("-- cart remove");
    }
  }
  void clearAll() {
    _cart.clear();
    _order = Order();
  }
}