import 'dart:convert';

import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/model/order.detail.dart';
import 'package:prm_flutter/model/order.status.dart';
import 'package:prm_flutter/model/token.dart';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/user.dart';
import 'package:prm_flutter/service/apiEnv.dart';

class OrderService {
  static final String orderPath = "api/Order/";
  static Future<bool> createOrder(OrderCM data,String token) async {

    final response = await http
        .post("${Env.endPoint}$orderPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "bearer " + token
        } ,
        body: json.encode(data.toJson())
    );
    if(response.statusCode ==200) {
      return true;
    }
    else {
      throw Exception('Failed to ORDER from Internet');
    }
  }
  static Future<List<Order>> getOrders(String token) async {
    final response = await http
        .get("${Env.endPoint}$orderPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "bearer " + token
        } ,
    );
    if(response.statusCode ==200) {
      Iterable res  = json.decode(response.body);
      List<Order> orders = res.map((json) => Order.fromJson(json)).toList();
      return orders;
    }
    else {
      throw Exception('Failed to load ORDER from Internet');
    }
  }

  static Future<Order> getOrder(int id, String token) async {
    final response = await http
        .get("${Env.endPoint}$orderPath$id",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "bearer " + token
      } ,
    );

    if(response.statusCode ==200) {
      Map<String, dynamic> body = json.decode(response.body);
      Order res = Order.fromJson(body);
      List<dynamic> details = json.decode(json.encode(body["OrderDetailVMs"]));
      Iterable statues = json.decode(json.encode(body["StatusVMs"]));
      var orderDetails = details.map((d)=> OrderDetail.fromJson(d)).toList();
      var orderStatues = statues.map((s)=> OrderStatus.fromJson(s)).toList();
      res.orderDetails = orderDetails;
      res.orderStatues = orderStatues;
      return res;
    }
    else {
      throw Exception('Failed to load ORDER from Internet');
    }
  }

}
class OrderCM {
  String address,note;
  List<OrderDetailCM> orderDetailCMs;

  OrderCM({this.address, this.note, this.orderDetailCMs});

  Map<String, dynamic> toJson() {
    var result =  {
      'address': address,
      'note':note,
      'orderDetailCMs':
        orderDetailCMs.map((o) =>o.toJson()).toList()
      ,
    };

    print(result);
    return result;
  }

}
class OrderDetailCM {
  int productId;
  String size,color;
  int quantity;

  OrderDetailCM({this.productId, this.size, this.color, this.quantity});
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'size':size,
      'color': color,
      'quantity': quantity,
    };
  }
}