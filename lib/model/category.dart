import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  String logo;

  Category({this.id,this.name, this.logo});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json["Id"],
        name: json["Name"],
        logo: json["Logo"],
    );
  }
}


