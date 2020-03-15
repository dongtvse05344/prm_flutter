import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/myStyle.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ProductCard extends StatefulWidget {
  final Product product;
  final bool canEdit;
  ProductCard(this.product,this.canEdit);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  CartBloc _bloc ;

  void clearCartItem() {
    _bloc.clear(widget.product);
  }
  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<CartBloc>(context);
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: MyColor.white,
        boxShadow: [

        ]
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                "${Env.imageEndPoint}${widget.product.bannerPath}",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                            child: Text("${widget.product.name.substring(0,math.min(20, widget.product.name.length))}",style: MyText.productTitle1,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1,
                          child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: MyStyle.upBox,
                          child: Icon(FontAwesomeIcons.palette,color: Colors.grey)
                      )),
                      Expanded(
                        flex: 5,
                        child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(" ${widget.product.color}"
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),

                  Row(
                    children: <Widget>[
                      Expanded(flex: 1,child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: MyStyle.upBox,
                          child: Icon(FontAwesomeIcons.windowMaximize,color: Colors.grey))),
                      Expanded(
                        flex: 5,
                        child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(" ${widget.product.size}"
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),

                  Row(
                    children: <Widget>[
                      Expanded(flex: 1,child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: MyStyle.upBox,
                          child: Icon(FontAwesomeIcons.luggageCart,color: Colors.grey,))),
                      Expanded(
                        flex: 5,
                        child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(" ${widget.product.quantity}"
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          widget.canEdit ? Expanded(
            flex: 1,
            child: InkWell(
              onTap: clearCartItem,
              child: Container(
                child: Center(
                  child: Container(
                      decoration: MyStyle.upBox,
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.close)
                  ),
                ),
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
