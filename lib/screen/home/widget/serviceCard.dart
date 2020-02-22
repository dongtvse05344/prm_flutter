import 'package:flutter/material.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServiceCard extends StatefulWidget {
  final Product productModel;

  ServiceCard(this.productModel);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3,0),
                blurRadius: 5,
              )
            ]
        ),
        child: Row(
          children: <Widget>[
            Image.asset(widget.productModel.bannerPath, width: 100,height: double.infinity, fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.productModel.name,style: MyText.cardTitle,),
                  SizedBox(height: 5,),
                  Container(width: 200, child: Text(widget.productModel.description,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)),
                  SizedBox(height: 5,),
                  RatingBar(
                    initialRating: 3,
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
        )
    );
  }
}
