import 'package:flutter/material.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/service/order.service.dart';

class OrderBloc with ChangeNotifier {
  List<Order> _orders;
  List<Order> get orders => _orders;
  Order _order;
  Order get order => _order;
  Future<bool> createOrder(OrderCM data,String token) async {
    try{
      return OrderService.createOrder(data,token);
    }catch(e) {
      print(e);
      return false;
    }
  }

  void getOrders(String token) async {
    OrderService.getOrders(token)
        .then((rs)=> {
          _orders = rs,
          notifyListeners()
        })
        .catchError((e)=>print(e));
  }

  void getOrder(int id, String token) async {
    OrderService.getOrder(id, token)
        .then((rs)=> {
      _order = rs,
      notifyListeners()
    }).catchError((e)=>print(e));
  }
}