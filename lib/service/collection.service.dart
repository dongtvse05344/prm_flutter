import 'package:prm_flutter/model/collection.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prm_flutter/model/product.dart';
import 'apiEnv.dart';

class CollectionService {
  static String collectionPath = "api/Collection/";
  static String productPath = "/Product";

  static Future<List<Collection>> getCollections() async {
    final response = await http
        .get("${Env.endPoint}$collectionPath",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      } ,
    );
    if(response.statusCode ==200) {
      Iterable res  = json.decode(response.body);
      List<Collection> categories = res.map((json) => Collection.fromJson(json)).toList();
      return categories;
    }
    else {
      throw Exception('Failed to load Collection from Internet');
    }
  }

  static Future<List<Product>> getProducts(int id) async {
    final response = await http
        .get("${Env.endPoint}$collectionPath$id$productPath",
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
      throw Exception('Failed to load Product form collection id from Internet');
    }
  }
}