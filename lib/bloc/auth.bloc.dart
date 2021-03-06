import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prm_flutter/model/token.dart';
import 'package:prm_flutter/model/user.dart';
import 'package:prm_flutter/service/appEnv.dart';
import 'package:prm_flutter/service/authService.dart';
import 'package:prm_flutter/service/share.ref.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc  with ChangeNotifier {
  ShareRefService shareRefService = ShareRefService.getInstance();
  static const String START = "start";
  static const String ERROR = "error";
  static const String OK = "ok";


  String _token;
  String get token => _token;

  var _statusController = StreamController.broadcast();
  Stream get statusStream => _statusController.stream;
  Future<String>  isLogin() async{
    try{
      if(token == null) _token = await shareRefService.getToken();
      if(_token != null) {
        return AuthBloc.OK;
      }
      return AuthBloc.START;
    }catch(e){
      print(e);
      return AuthBloc.START;
    }
  }
  void fetchToken(String username,String password, String deviceId, listenData) async {
    listenData(AuthBloc.START);
    AuthService.fetchToken(username,password,deviceId).then((rs) async =>
    {
        _token = rs.access_token,
        shareRefService.setToken(rs),
        listenData(AuthBloc.OK)
    }
    ).catchError((e){
      print(e);
      listenData(AuthBloc.ERROR);
    });
  }

  void googleSignin(String username, String uid,String email,String fullname,String phonenumber, listenData) async {
    listenData(AuthBloc.START);
    AuthService.googleSignIn(username, uid, email, fullname, phonenumber).then((rs) async =>
    {
      _token = rs.access_token,
      shareRefService.setToken(rs),
      listenData(AuthBloc.OK)
    }
    ).catchError((e){
      print(e);
      listenData(AuthBloc.ERROR);
    });
  }

  void register(String username,String password, String email,String phoneNumber,String fullname, listenData) async {
    listenData(AuthBloc.START);
    AuthService.register(email,username,fullname,phoneNumber, password).then((rs) async =>
    {
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

  Future<bool> logOut(){
    _token = null;
    notifyListeners();
    return shareRefService.clear();
  }
}