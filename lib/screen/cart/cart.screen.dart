import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/user.address.bloc.dart';
import 'package:prm_flutter/bloc/user.bloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/model/useraddress.dart';
import 'package:prm_flutter/screen/auth/loginScreen.dart';
import 'package:prm_flutter/screen/cart/widget/address.card.screen.dart';
import 'package:prm_flutter/screen/cart/widget/product.card.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/screen/cart/order.address.screen.dart';
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
  UserBloc _userBloc;
  CartBloc _cartBloc;
  UserAddressBloc _addressBloc;
  addToCart() async {
    if (await _authBloc.isLogin() == AuthBloc.OK) {
      if (_userBloc.user == null) await _userBloc.getUserData(_authBloc.token);
      _addressBloc.getAddresses(_authBloc.token);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OrderAddressScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
  backToHome() {
    Navigator.popUntil(
        context, (Route<dynamic> route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = Provider.of<AuthBloc>(context);
    _userBloc = Provider.of<UserBloc>(context);
    _cartBloc = Provider.of<CartBloc>(context);
    _addressBloc= Provider.of<UserAddressBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        backgroundColor: MyColor.firstColor,
        leading: IconButton(
          onPressed: backToHome,
          icon: Icon(Icons.home),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Your product: ",
                      style: TextStyle(color: MyColor.firstColor, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Consumer<CartBloc>(
                      builder: (context, cartBloc, child) {
                        var cart = cartBloc.cart;
                        if (cart.length > 0) {
                          return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => Divider(),
                              scrollDirection: Axis.vertical,
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                int giftIndex = cart.keys.toList()[index];
                                Product product = cart[giftIndex];
                                return ProductCard(product,true);
                              });
                        } else {
                          return Container(
                            child: Center(
                              child: Text("Your cart is empty"),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              height: 120,
              width: size.width,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Consumer<CartBloc>(builder: (context, cartBloc, child) {
                  var cart = cartBloc.cart;
                  if (cart.length > 0) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Total amount: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.firstColor,
                                  fontSize: 18
                              ),),
                            Text(
                              " ${_cartBloc.totalAmount()} \$",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: addToCart,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: MyColor.firstColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                    "Check out",
                                    style: MyText.bottomBarTitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else {
                    return InkWell(
                      onTap: backToHome,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(

                          border: Border.all(width: 1,color: MyColor.firstColor,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.home,
                                color: MyColor.firstColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                " Back to Home",
                                style: MyText.cardTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ))
        ],
      ),
    );
  }
}
