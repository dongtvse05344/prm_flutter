class UserAddress {
  int id;
  String name,address,phoneNumber;
  bool isHome;

  UserAddress({this.id, this.name, this.address, this.phoneNumber, this.isHome});

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
        id: json["Id"],
        name: json["Name"],
        address: json["Address"],
        phoneNumber: json["PhoneNumber"],
        isHome: json["IsHome"],
    );
  }

  Map<String, dynamic> toJson() {
    var result =  {
      'id': id,
      'name':name,
      'address': address,
      'phonenumber':phoneNumber,
      'isHome':isHome != null ? isHome : true,
    };
    return result;
  }
}