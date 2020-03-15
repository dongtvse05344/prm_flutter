import 'dart:convert';

import 'package:prm_flutter/model/token.dart';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/user.dart';

import 'apiEnv.dart';
class AuthService {
  static String loginPath = "api/Auth/token";
  static String infoPath = "api/Auth/info";
  static String registerPath = "api/Auth/Register";
  static String ggPath = "api/Auth/Google";
  static Future<Token> fetchToken(String username, String password, String deviceId) async {

    final response = await http
        .post("${Env.endPoint}$loginPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        } ,
        body: json.encode({"username":username,"password":password,"deviceId":deviceId})
    );
    if(response.statusCode ==200) {
      Map<String,dynamic> res  = json.decode(response.body);
      return Token.fromJson(res);
    }
    else {
      throw Exception('Failed to load Token from Internet');
    }
  }

  static Future<Token> googleSignIn(String username, String uid,String email,String fullname,String phonenumber) async {

    final response = await http
        .post("${Env.endPoint}$ggPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        } ,
        body: json.encode({"username":username,"uid":uid,"email":email,"fullName":fullname,"phoneNumber":phonenumber})
    );
    print("${response.body}");
    if(response.statusCode ==200) {
      Map<String,dynamic> res  = json.decode(response.body);
      return Token.fromJson(res);
    }
    else {
      throw Exception('Failed to load Token Google from Internet');
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

  static Future<void> register(String email,String username,String fullname,String phonenumber,String password) async {

    final response = await http
        .post("${Env.endPoint}$registerPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      } ,
        body: json.encode({"email":email,"username":username,"fullName":fullname,"phoneNumber":phonenumber,"password":password})
    );

    if(response.statusCode ==200) {
    }
    else {
      throw Exception('Failed to register from Internet');
    }
  }
}

