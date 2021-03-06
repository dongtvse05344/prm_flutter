class OrderDetail {
  int id,productId,orderId;
  String size;
  String color;
  int quantity;
  String image;
  String productName;

  OrderDetail({this.id, this.productId, this.orderId, this.size, this.color,
    this.quantity,this.image,this.productName});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json["Id"],
      size: json["Size"],
      color: json["Color"],
      quantity: json["Quantity"],
      productId: json["ProductId"],
      image: json["Image"],
        productName: json["ProductName"]
    );
  }
}