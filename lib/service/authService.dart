import 'dart:convert';

import 'package:prm_flutter/model/token.dart';
import 'package:http/http.dart' as http;

import 'apiEnv.dart';
class AuthService {
  static String loginPath = "api/Auth/token";

  static Future<Token> fetchToken(String username, String password) async {

    final response = await http
        .post("${Env.endPoint}$loginPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        } ,
        body: json.encode({"username":username,"password":password}));
    if(response.statusCode ==200) {
      Map<String,dynamic> res  = json.decode(response.body);
      return Token.fromJson(res);
    }
    else {
      throw Exception('Failed to load Token from Internet');
    }
  }
}

class LoginViewModel {
  String username, password;

  LoginViewModel(this.username, this.password);

}