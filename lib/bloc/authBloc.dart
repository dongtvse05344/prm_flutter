import 'dart:async';

import 'package:prm_flutter/service/appEnv.dart';
import 'package:prm_flutter/service/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  static const String START = "start";
  static const String ERROR = "error";
  static const String OK = "ok";

  static AuthBloc _authBloc;
  static AuthBloc getInstance() {
    if(_authBloc == null) _authBloc = AuthBloc();
    return _authBloc;
  }

  var _statusController = StreamController();
  Stream get statusStream => _statusController.stream;

  var _tokenController = StreamController();
  Stream get tokenStream => _tokenController.stream;

  void fetchToken(String username,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _statusController.sink.add(AuthBloc.START);
    AuthService.fetchToken(username,password).then((rs) async =>
    {
        prefs.setString(AppEnv.TOKEN, rs.access_token),
        _statusController.sink.add(AuthBloc.OK)
    }
    ).catchError((e){
      _statusController.sink.add(AuthBloc.ERROR);
    });
  }

  void dispose() {
    _tokenController.close();
    _statusController.close();
  }
}