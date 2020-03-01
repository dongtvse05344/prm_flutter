
import 'package:prm_flutter/model/token.dart';
import 'package:prm_flutter/service/appEnv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareRefService {
  static ShareRefService  _shareRefService;
  static ShareRefService getInstance() {
    if(_shareRefService == null) {
      _shareRefService = new ShareRefService();
    }
    return _shareRefService;
  }
  SharedPreferences _preferences;

  ShareRefService() {
    init();
  }
  void init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setToken(Token token) async{
    return _preferences.setString(AppEnv.TOKEN, token.access_token);
  }


  Future<bool> clear() async{
    return _preferences.clear();
  }

  Future<String> getToken() async {
    if(_preferences ==null)
      {
        _preferences = await SharedPreferences.getInstance();
      }
      return _preferences.getString(AppEnv.TOKEN);
  }


}