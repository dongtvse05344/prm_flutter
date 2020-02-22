
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prm_flutter/model/category.dart';
import 'package:prm_flutter/service/categoryService.dart';

class CategoryBloc {
  static CategoryBloc _categoryBloc;
  static CategoryBloc getInstance() {
    if(_categoryBloc == null) _categoryBloc = CategoryBloc();
    return _categoryBloc;
  }

  List<Category> categories ;

  var _categoriesController = StreamController.broadcast();
  Stream get categoriesStream => _categoriesController.stream;

  void getCategories() {
    if(categories == null || categories.length ==0) {
      CategoryService.getCategories().then((rs) async =>
      {
        categories = rs,
        _categoriesController.sink.add(categories)
      }
      ).catchError((e){
        categories = List();
        _categoriesController.sink.add(categories);
      });
    }
    else {
      _categoriesController.sink.add(categories);
    }
  }


  Future<List<Category>> getServiceModels() async {
    List<Category> result = List();
    return result;
  }

  Future<List<String>> getCateIcon() async {
    List<String> result = new List<String>();
    result.add("assets/cate1.png");
    result.add("assets/cate2.png");
    result.add("assets/cate3.png");
    result.add("assets/cate4.png");
    result.add("assets/cate5.png");
    result.add("assets/cate6.png");
    return result;
  }

  Future<List<String>> getCarouselBanner() async {
    List<String> result = new List<String>();
    result.add("assets/pet1.jpg");
    result.add("assets/pet2.jpg");
    result.add("assets/pet3.jpg");
    result.add("assets/pet4.jpg");
    return result;
  }

  void dispose(){
    _categoriesController.close();
  }
}