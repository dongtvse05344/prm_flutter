import 'package:intl/intl.dart';

class OrderStatus {
  DateTime dateCreated;
  String formatDateCreated;
  String name;
  int priority;

  OrderStatus({
    this.dateCreated, this.formatDateCreated, this.name,
    this.priority
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    var _dateCreated = DateTime.parse(json["DateCreated"]);
    String formattedDate = DateFormat('hh:mm dd MMM').format(_dateCreated);

    return OrderStatus(
        dateCreated: _dateCreated,
        formatDateCreated:formattedDate,
        name: json["Name"],
        priority: json["Priority"],
    );
  }

}