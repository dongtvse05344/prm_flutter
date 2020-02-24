import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/model/category.dart';
import 'package:prm_flutter/screen/product/product.search.screen.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatefulWidget {
  final Category model;

  CategoryCard(this.model);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  ProductSearchBloc _bloc;
  onClick() {
    _bloc.searchByCategory(widget.model);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=> ProductSearchScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<ProductSearchBloc>(context);
    return InkWell(
      onTap: onClick,
      child: Container(
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
      ),
    );
  }
}
