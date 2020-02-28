import 'dart:convert';

import 'package:prm_flutter/model/token.dart';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/user.dart';

import 'apiEnv.dart';
class AuthService {
  static String loginPath = "api/Auth/token";
  static String infoPath = "api/Auth/info";

  static Future<Token> fetchToken(String username, String password) async {

    final response = await http
        .post("${Env.endPoint}$loginPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        } ,
        body: json.encode({"username":username,"password":password})
    );
    if(response.statusCode ==200) {
      Map<String,dynamic> res  = json.decode(response.body);
      return Token.fromJson(res);
    }
    else {
      throw Exception('Failed to load Token from Internet');
    }
  }

  static Future<User> getInfo(String token) async {

    final response = await http
        .get("${Env.endPoint}$infoPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "bearer " + token
        } ,
    );

    if(response.statusCode ==200) {
      Map<String,dynamic> res  = json.decode(response.body);
      return User.fromJson(res);
    }
    else {
      throw Exception('Failed to load User from Internet');
    }
  }
}

class LoginViewModel {
  String username, password;
  LoginViewModel(this.username, this.password);
}