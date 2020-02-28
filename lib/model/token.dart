import 'dart:convert';

class Token {
  List<String> role;
  String fullname;
  String access_token;
  int expires_in;
  Token({
    this.role,
    this.fullname,
    this.access_token,
    this.expires_in
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      fullname: json["fullname"],
      access_token: json["access_token"],
      expires_in: json["expires_in"]
    );
  }




}

