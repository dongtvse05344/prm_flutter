import 'package:flutter/material.dart';
import 'package:prm_flutter/style/colors.dart';

class RateBar extends StatelessWidget {
  final double rank;

  RateBar(this.rank);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: <Widget>[
          Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[400],
            ),
          ),
          Container(
            width: 120/5*rank,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MyColor.firstColor,
            ),
          ),
        ],
      ),
    );
  }
}
