import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prm_flutter/model/token.dart';
import 'package:prm_flutter/service/appEnv.dart';
import 'package:prm_flutter/service/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc  with ChangeNotifier {
  static const String START = "start";
  static const String ERROR = "error";
  static const String OK = "ok";
  Token _token;
  Token get token => _token;

  SharedPreferences prefs;
  var _statusController = StreamController.broadcast();
  Stream get statusStream => _statusController.stream;
  Future<String>  isLogin() async{
    try{
      prefs = await SharedPreferences.getInstance();
      var tokenString = prefs.get(AppEnv.TOKEN);
      if(tokenString != null) {
        print("get data ok ");
        return AuthBloc.OK;
        _token = json.decode(tokenString);
      }
      print("data empty");
      return AuthBloc.START;
    }catch(e){
      print(e);
      return AuthBloc.START;
    }
  }
  void fetchToken(String username,String password, listenData) async {
    prefs = await SharedPreferences.getInstance();
    listenData(AuthBloc.START);
    AuthService.fetchToken(username,password).then((rs) async =>
    {
        _token = rs,
        prefs.setString(AppEnv.TOKEN, token.toString()).then((res)=>
        {
          if(res)print("--- save data ok")
        } )
        ,
        listenData(AuthBloc.OK)
    }
    ).catchError((e){
      print(e);
      listenData(AuthBloc.ERROR);
    });
  }

  void dispose() {
    _statusController.close();
    super.dispose();
  }
}