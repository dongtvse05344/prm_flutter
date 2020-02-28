class User {
  String fullname,email,homeAddress,companyAddress;

  User({this.fullname, this.email, this.homeAddress, this.companyAddress});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        fullname: json["FullName"],
        email: json["Email"],
        homeAddress: json["HomeAddress"],
        companyAddress: json["CompanyAddress"],
    );
  }

}