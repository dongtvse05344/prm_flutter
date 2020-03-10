import 'package:flutter/foundation.dart';
import 'package:prm_flutter/model/useraddress.dart';
import 'package:prm_flutter/service/userAddress.service.dart';

class UserAddressBloc with ChangeNotifier {
  List<UserAddress> _addresses;

  List<UserAddress> get addresses => _addresses;

  void getAddresses(String token) {
    UserAddressService.getAddresses(token)
        .then((rs) => {_addresses = rs, notifyListeners()})
        .catchError((e) => {print(e)});
  }

  void createAddress(UserAddress data, String token) async {
    var rs = await UserAddressService.createOrder(data, token);
    _addresses.add(data);
  }
}
