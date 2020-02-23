import 'dart:async';

import 'package:prm_flutter/model/color.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/productService.dart';

class ProductDetailBloc {

  static ProductDetailBloc _productDetailBloc;
  static ProductDetailBloc getInstance() {
    if(_productDetailBloc == null) _productDetailBloc = ProductDetailBloc();
    return _productDetailBloc;
  }

  static void setInstance(ProductDetailBloc _bloc) {
    _productDetailBloc = _bloc;
  }

  Product product;
  List<String> images;
  List<String> sizes;
  List<MColor> colors;
  var _productController = StreamController();
  Stream get productStream => _productController.stream;

  var _imagesController = StreamController();
  Stream get imagesStream => _imagesController.stream;

  var _sizesController = StreamController.broadcast();
  Stream get sizesStream => _sizesController.stream;

  var _colorsController = StreamController.broadcast();
  Stream get colorsStream => _colorsController.stream;

  void getProduct(int id) async {
    try{
      product =  await ProductService.getProduct(id);
      _productController.sink.add(product);
    }catch(e){
      print(e);
      _productController.sink.addError(e);
    }
  }

  void getProductImage() {
    if(product ==null) return;
    ProductService.getImages(product.id).then((rs) =>
    {
      images = rs,
      _imagesController.sink.add(images)
    }
    ).catchError((e){
      print(e);
      images = List();
      _imagesController.sink.add(images);
    });
  }

  void getProductSizes() {
    if(product ==null) return;
    ProductService.getSizes(product.id).then((rs) =>
    {
      sizes = rs,
      _sizesController.sink.add(sizes)
    }
    ).catchError((e){
      print(e);
      sizes = List();
      _sizesController.sink.add(sizes);
    });
  }
  void getProductColors() {
    if(product ==null) return;
    ProductService.getColor(product.id).then((rs) =>
    {
      colors = rs,
      _colorsController.sink.add(colors)
    }
    ).catchError((e){
      print(e);
      sizes = List();
      _colorsController.sink.add(colors);
    });
  }
  void dispose(){
    _productController.close();
    _imagesController.close();
    _sizesController.close();
    _colorsController.close();
  }

}