import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/color.dart';
import 'package:prm_flutter/model/product.dart';
import 'apiEnv.dart';


class ProductService {
  static String productPath = "api/Product/";
  static String productTopPath = "New";
  static String ImagesPath = "/Image";
  static String SizesPath = "/Size";
  static String ColorsPath = "/Color";

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

  static Future<List<Product>> searchProducts(String name) async {
    final response = await http
        .get("${Env.endPoint}$productPath?name=$name",
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
      throw Exception('Failed to search Products from Internet');
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
      throw Exception('Failed to load  Product Images from Internet');
    }
  }

  static Future<List<String>> getSizes(int id) async {
    final response = await http
        .get("${Env.endPoint}$productPath$id$SizesPath",
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
      throw Exception('Failed to load  Product Sizes from Internet');
    }
  }

  static Future<Product> getProduct(int id) async {
    final response = await http
        .get("${Env.endPoint}$productPath$id",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      Product result = Product.fromJson(json.decode(response.body));
      return result;
    }
    else {
      throw Exception('Failed to load  Product  from Internet');
    }
  }

  static Future<List<MColor>> getColor(int id) async {
    final response = await http
        .get("${Env.endPoint}$productPath$id$ColorsPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      List<dynamic> res  = json.decode(response.body);
      List<MColor> result = res.map((js)=> MColor.fromJson(js)).toList();
      return result;
    }
    else {
      throw Exception('Failed to load  Product Color  from Internet');
    }
  }
}