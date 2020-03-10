import 'package:flutter/material.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/service/order.service.dart';
import 'package:prm_flutter/service/productService.dart';

class OrderBloc with ChangeNotifier {
  List<Order> _orders;
  List<Order> get orders => _orders;
  List<Order> _ordersD;
  List<Order> get ordersD => _ordersD;
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

  Future<bool> createRate(RatingCM data) async {
    try{
      return ProductService.createRating(data);
    }catch(e) {
      print(e);
      return false;
    }
  }

  void getOrders(String token)  {
    OrderService.getOrders(false,token)
        .then((rs)=> {
      _orders = rs,
      notifyListeners()
    })
        .catchError((e)=>print(e));
  }

  void getOrdersDone(String token)  {
    OrderService.getOrders(true,token)
        .then((rs)=> {
      _ordersD = rs,
      notifyListeners()
    })
        .catchError((e)=>print(e));
  }

  void getOrder(int id, String token)  {
    OrderService.getOrder(id, token)
        .then((rs)=> {
      _order = rs,
      notifyListeners()
    }).catchError((e)=>print(e));
  }

  Future<bool> cancelOrder(int id, String token) async {
    try{
      await OrderService.cancelOrder(id, token);
      getOrdersDone(token);
      getOrders(token);
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }
}