import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/texts.dart';

import '../productDetailScreen.dart';
class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard(this.product);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ProductBloc _productBloc = ProductBloc.getInstance();

  onTap() {
    _productBloc.setSelectedProduct(widget.product);
    print(widget.product.id);
    Navigator.of(context).push(MaterialPageRoute(
        builder:(context)=> ProductDetailScreen(id:widget.product.id)
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        width: size.width/2-10,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0,5)
            )
          ]
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Image.network("${Env.imageEndPoint}${widget.product.bannerPath}",fit: BoxFit.cover,),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                  child: Column(
                    children: <Widget>[
                      Text("${widget.product.name}",style: MyText.cardTitle,),

                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 5,
              right: -30,
              child: Container(
                  width: 130,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${widget.product.oldPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        " ${widget.product.currentPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
