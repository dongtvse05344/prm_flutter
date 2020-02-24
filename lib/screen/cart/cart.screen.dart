import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/cart/widget/product.card.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
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
      appBar: AppBar(
        title: const Text('Your cart'),
        backgroundColor: MyColor.firstColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> HomeScreen(),
            ));
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text("Your product: ",style: TextStyle(color: MyColor.firstColor,fontSize: 24),),
            ),
            Container(
              child: Consumer<CartBloc>(
                builder: (context, cartBloc, child) {
                  var cart = cartBloc.cart;
                  if(cart.length >0) {
                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(),
                        scrollDirection: Axis.vertical,
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          int giftIndex = cart.keys.toList()[index];
                          Product product = cart[giftIndex];
                          return ProductCard(product);
                        }
                    );
                  } else {
                    return
                        Container(
                          child: Center(child: Text("Your cart is empty"),),
                        );
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
