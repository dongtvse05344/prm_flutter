import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/product.dart';
import 'apiEnv.dart';

import 'package:prm_flutter/model/category.dart';


class CategoryService {
  static String categoryPath = "api/Category/";
  static String productPath = "/Product";

  static Future<List<Category>> getCategories() async {
    final response = await http
        .get("${Env.endPoint}$categoryPath",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        } ,
    );
    if(response.statusCode ==200) {
      Iterable res  = json.decode(response.body);
      List<Category> categories = res.map((json) => Category.fromJson(json)).toList();
      return categories;
    }
    else {
      throw Exception('Failed to load Categories from Internet');
    }
  }
  static Future<List<Product>> getProducts(int id) async {
    final response = await http
        .get("${Env.endPoint}$categoryPath$id$productPath",
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
      throw Exception('Failed to load Product form Categories id from Internet');
    }
  }
}