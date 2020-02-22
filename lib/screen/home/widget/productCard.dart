import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/product/productDetailScreen.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    Navigator.of(context).push(MaterialPageRoute(
       builder:(context)=> ProductDetailScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(top: 20, right: 20, bottom: 10),
          width: 260,
          height: 160,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 0),
                  blurRadius: 5,
                )
              ]),
          child: Row(
            children: <Widget>[
              Image.network(
                "${Env.imageEndPoint}${widget.product.bannerPath}",
                width: 100,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 140,
                        child: Text(
                      widget.product.name,
                      style: MyText.cardTitle,
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 130,
                        child: Text(
                          "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    RatingBar(
                      initialRating: widget.product.star,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.lightBlueAccent,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
