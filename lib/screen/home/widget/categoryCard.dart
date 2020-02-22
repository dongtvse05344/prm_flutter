import 'package:flutter/material.dart';
import 'package:prm_flutter/model/category.dart';
import 'package:prm_flutter/service/apiEnv.dart';

class CategoryCard extends StatefulWidget {
  final Category model;

  CategoryCard(this.model);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 120,
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0,3),
              blurRadius: 5,
            ),
          ],
      ),
      child: Column(
        children: <Widget>[
//          Image.network(widget.icon, width: 100.0, height: 100.0),
        Image.network("${Env.imageEndPoint}${widget.model.logo}", width: 80.0,height: 80.0,),
          SizedBox(height: 5,),
          Text(widget.model.name)
        ],
      ),
    );
  }
}
