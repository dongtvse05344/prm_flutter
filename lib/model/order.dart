import 'package:intl/intl.dart';

import 'order.detail.dart';
import 'order.status.dart';

class Order {
  int id;
  String address,note;
  double totalAmount;
  DateTime dateCreated;
  String formatDate;
  int currentStatus;
  List<OrderDetail> orderDetails;
  List<OrderStatus> orderStatues;
  Order({this.id, this.address, this.note,this.totalAmount,this.dateCreated,this.formatDate,this.currentStatus});

  factory Order.fromJson(Map<String, dynamic> json) {
    var _dateCreated = DateTime.parse(json["DateCreated"]);
    String formattedDate = DateFormat('hh:mm dd MMM').format(_dateCreated);
    return Order(
      id: json["Id"],
      address: json["Address"],
      note: json["Note"],
      totalAmount: json["TotalAmount"],
      dateCreated: _dateCreated,
      formatDate: formattedDate,
      currentStatus: json["CurrentStatus"]
    );
  }
}
