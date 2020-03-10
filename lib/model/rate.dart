class Rate {
  String fullname;
  double rate;
  String comment;

  Rate({this.fullname, this.rate, this.comment});

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      fullname: json["FullName"],
      rate: json["Rate"],
      comment: json["Comment"],
    );
  }

}