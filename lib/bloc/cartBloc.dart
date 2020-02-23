import 'package:flutter/material.dart';
import 'package:prm_flutter/model/product.dart';

class CartBloc with ChangeNotifier {
  Map<int, Product> _cart = {};
  Map<int, Product> get cart => _cart;

  void addToCart(Product product) {
    if (_cart.containsKey(product.id)) {
    } else {
      _cart[product.id] = product;
    }
    notifyListeners();
  }

  void clear(product) {
    if (_cart.containsKey(product.id)) {
      _cart.remove(product.id);
      notifyListeners();
    }
  }
}