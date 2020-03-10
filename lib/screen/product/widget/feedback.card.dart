import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/model/rate.dart';
import 'package:prm_flutter/style/colors.dart';

class FeedBackCard extends StatelessWidget {
  final Rate rate;

  FeedBackCard(this.rate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.user,
                color: MyColor.firstColor,
              ),
              Text(
                " ${rate.fullname}",
                style: TextStyle(color: MyColor.firstColor,fontSize: 20,fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RatingBar(
                ignoreGestures: true,
                initialRating: rate.rate,
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
              Text(
                " 28 Feb 2020",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text("${rate.comment} ",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
