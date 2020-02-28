import 'package:flutter/material.dart';
import 'package:prm_flutter/model/user.dart';
import 'package:prm_flutter/service/authService.dart';

class UserBloc  with ChangeNotifier
{
  User _user;
  User get user => _user;

  void getUserData(String token) async {
    _user  = await AuthService.getInfo(token);
    notifyListeners();
  }
}