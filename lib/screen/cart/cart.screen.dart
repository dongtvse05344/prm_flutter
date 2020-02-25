import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/auth/loginScreen.dart';
import 'package:prm_flutter/screen/cart/widget/product.card.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/screen/order.address.screen.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AuthBloc _authBloc;
  addToCart() {
//    if(_authBloc.isLogin) {
//      Navigator.push(context, MaterialPageRoute(
//          builder: (context) => OrderAddressScreen()
//      ));
//    }
//    else {
//      Navigator.push(context, MaterialPageRoute(
//        builder: (context) => LoginScreen()
//      ));
//    }
  }
  @override
  Widget build(BuildContext context) {
    _authBloc = Provider.of<AuthBloc>(context);
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        backgroundColor: MyColor.firstColor,
        leading: IconButton(
          onPressed: () {
//            Navigator.of(context).push(MaterialPageRoute(
//                builder: (context)=> HomeScreen(),
//            ));
            Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Your product: ",style: TextStyle(color: MyColor.firstColor,fontSize: 24),),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50),
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
          Positioned(
            bottom: 0,
            height: 50,
            width: size.width,
            child: InkWell(
              onTap: addToCart,
              child: Container(
                color: MyColor.firstColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Add to Cart",
                        style: MyText.bottomBarTitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
