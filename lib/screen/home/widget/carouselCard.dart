import 'package:flutter/material.dart';

class CarouselCard extends StatefulWidget {
  final String index;

  CarouselCard(this.index);

  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Image.asset(widget.index, fit: BoxFit.cover,)
    );
  }
}
