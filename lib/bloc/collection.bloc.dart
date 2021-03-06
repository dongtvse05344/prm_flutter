import 'package:flutter/material.dart';
import 'package:prm_flutter/model/collection.dart';
import 'package:prm_flutter/service/collection.service.dart';

class CollectionBloc with ChangeNotifier {
  List<Collection> _collection;
  List<Collection> get collection => _collection;

  CollectionBloc() {
    getCollection();
  }
  void getCollection() {
      CollectionService.getCollections().then((rs)  =>
      {
        _collection = rs,
        notifyListeners()
      }
      ).catchError((e){
        print(e);
        _collection = List();
      });
  }
}
