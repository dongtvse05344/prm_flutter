import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/cart/widget/product.card.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;

    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            int giftIndex = cart.keys.toList()[index];
            Product product = cart[giftIndex];
            return ProductCard(product);
          }
        ),
      ),
    );
  }
}
