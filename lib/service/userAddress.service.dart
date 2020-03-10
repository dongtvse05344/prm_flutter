import 'package:prm_flutter/model/useraddress.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apiEnv.dart';
class UserAddressService {
  static String userAddressPath = "api/UserAddress/";
  static Future<List<UserAddress>> getAddresses(String token) async {
    final response = await http
        .get("${Env.endPoint}$userAddressPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "bearer " + token
      } ,
    );
    if(response.statusCode ==200) {
      Iterable res  = json.decode(response.body);
      List<UserAddress> products = res.map((json) => UserAddress.fromJson(json)).toList();
      return products;
    }
    else {
      throw Exception('Failed to load UserAddress from Internet');
    }
  }

  static Future<bool> createOrder(UserAddress data,String token) async {

    final response = await http
        .post("${Env.endPoint}$userAddressPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "bearer " + token
        } ,
        body: json.encode(data.toJson())
    );
    print("${json.encode(data.toJson())}");
    if(response.statusCode ==200) {
      return true;
    }
    else {
      throw Exception('Failed to Create UserAddress from Internet');
    }
  }

}