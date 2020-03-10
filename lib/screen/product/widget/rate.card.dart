import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prm_flutter/model/rate.dart';
import 'package:prm_flutter/screen/product/widget/rate.bar.dart';

class RateCard extends StatefulWidget {
  final Rate rate;

  RateCard(this.rate);

  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text("${widget.rate.rate}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                ),
                RatingBar(
                  ignoreGestures: true,
                  initialRating: widget.rate.rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text("${widget.rate.comment}")
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        child: Center(child: Text("5"),),
                      ),
                      RateBar(4.5),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        child: Center(child: Text("4"),),
                      ),
                      RateBar(3.1),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        child: Center(child: Text("3"),),
                      ),
                      RateBar(1.8),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        child: Center(child: Text("2"),),
                      ),
                      RateBar(0.2),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        child: Center(child: Text("1"),),
                      ),
                      RateBar(0.8),
                    ],
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
