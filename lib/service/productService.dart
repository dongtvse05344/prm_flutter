import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/color.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/model/rate.dart';
import 'apiEnv.dart';


class ProductService {
  static String productPath = "api/Product/";
  static String productTopPath = "New";
  static String ImagesPath = "/Image";
  static String SizesPath = "/Size";
  static String ColorsPath = "/Color";
  static String RatesPath = "/Rate";

  static String Rating = "api/Product/Rating";

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

  static Future<List<Rate>> getRates(int id) async {
    final response = await http
        .get("${Env.endPoint}$productPath$id$RatesPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      List<dynamic> res  = json.decode(response.body);
      List<Rate> result = res.map((js)=> Rate.fromJson(js)).toList();
      return result;
    }
    else {
      throw Exception('Failed to load  Rates Color  from Internet');
    }
  }

  static Future<bool> createRating(RatingCM data) async {

    final response = await http
        .put("${Env.endPoint}$Rating",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        } ,
        body: json.encode(data.toJson())
    );
    print("${json.encode(data.toJson())}");
    if(response.statusCode ==200) {
      return true;
    }
    else {
      throw Exception('Failed to rating order ');
    }
  }
}

class RatingCM {
  int orderDetailId;
  double rate;
  String comment;

  RatingCM({this.orderDetailId, this.rate, this.comment});

  Map<String, dynamic> toJson() {
    var result =  {
      'orderDetailId': orderDetailId,
      'rate':rate,
      'comment':comment
      ,
    };
    return result;
  }
}