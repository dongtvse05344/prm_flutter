import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/product.dart';
import 'apiEnv.dart';


class ProductService {
  static String productPath = "api/Product/";
  static String productTopPath = "New";
  static String ImagesPath = "/Image";
  static Future<List<Product>> getTopProducts() async {
    final response = await http
        .get("${Env.endPoint}$productPath$productTopPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      Iterable res  = json.decode(response.body);
      List<Product> products = res.map((json) => Product.fromJson(json)).toList();
      return products;
    }
    else {
      throw Exception('Failed to load Top Products from Internet');
    }
  }

  static Future<List<String>> getImages(int id) async {
    final response = await http
        .get("${Env.endPoint}$productPath$id$ImagesPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      List<dynamic> res  = json.decode(response.body);
      List<String> result = res.map((js)=> js.toString()).toList();
      return result;
    }
    else {
      throw Exception('Failed to load Top Product Images from Internet');
    }
  }
}