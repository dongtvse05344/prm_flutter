import 'dart:async';

import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/productService.dart';

class ProductBloc {
  static ProductBloc _productBloc;
  static ProductBloc getInstance() {
    if(_productBloc == null) _productBloc = ProductBloc();
    return _productBloc;
  }
  List<Product> products ;
  Product seletedProduct;
  List<String> images;

  var _productsController = StreamController.broadcast();
  Stream get productsStream => _productsController.stream;

  var _imagesController = StreamController();
  Stream get imagesStream => _imagesController.stream;

  var _productController = StreamController();
  Stream get productStream => _productController.stream;

  void setSelectedProduct(Product product) {
    seletedProduct = product;
    _productController.sink.add(seletedProduct);
  }

  void getTopProducts() {
      ProductService.getTopProducts().then((rs)  =>
      {
        products = rs,
        _productsController.sink.add(products)
      }
      ).catchError((e){
        products = List();
        _productsController.sink.add(products);
      });
    }
  void getProductImage() {
    _imagesController = new StreamController();
    if(seletedProduct ==null) return;
    ProductService.getImages(seletedProduct.id).then((rs) =>
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

  void dispose(){
    _productsController.close();
    _productController.close();
  }

  void disposeImage(){
    _imagesController.close();
  }

}