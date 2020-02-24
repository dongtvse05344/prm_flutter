import 'package:flutter/material.dart';
import 'package:prm_flutter/model/category.dart';
import 'package:prm_flutter/model/collection.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/categoryService.dart';
import 'package:prm_flutter/service/collection.service.dart';

class ProductSearchBloc with ChangeNotifier {
  Collection _collection;
  Collection get collection => _collection;

  Category _category;
  Category get category => _category;

  List<Product> _products;
  List<Product> get products => _products;

  void searchByCategory(Category category){
    _category = category;
    CategoryService.getProducts(_category.id).then((rs)  =>
    {
      _products = rs,
      notifyListeners()
    }
    ).catchError((e){
      _products = List();
    });
  }

  void searchByCollection(Collection collection){
    _collection = collection;
    CollectionService.getProducts(_collection.id).then((rs)  =>
    {
      _products = rs,
      notifyListeners()
    }
    ).catchError((e){
      _products = List();
    });
  }

}