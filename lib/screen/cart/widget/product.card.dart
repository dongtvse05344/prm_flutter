import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard(this.product);

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
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(5,5),
            blurRadius: 5
          )
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
            child: Column(
              children: <Widget>[
                Text("${widget.product.name}"),
                Text("${widget.product.color}"),
                Text("${widget.product.size}"),
                Text("${widget.product.quantity}"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: clearCartItem,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.firstColor
                ),
                child: Center(
                  child: Text("Clear",style: TextStyle(color: Colors.white, fontSize: 22),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
