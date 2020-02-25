import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/screen/cart/cart.screen.dart';
import 'package:prm_flutter/screen/product/widget/product.card.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  goToCartScreen(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>CartScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: MyColor.firstColor,
        elevation: 1,
        title: Text("Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, ),
            onPressed: goToCartScreen,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<ProductSearchBloc>(
            builder: (context, _bloc, child) {
              var collection = _bloc.collection;
              var category = _bloc.category;
              var product = _bloc.products;
              List<Widget> widgets = List();
              if(product != null){
                widgets = product.map((p) => ProductCard(p)).toList();
              }

              return Column(
                children: <Widget>[
                  _bloc.collection !=null?
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Image.network("${Env.imageEndPoint}${_bloc.collection.banner}",fit: BoxFit.cover,),
                  ): category != null ?
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Image.network("${Env.imageEndPoint}${category.logo}",fit: BoxFit.cover,),
                  ):
                  Container(
                  ),

                  Wrap(
                    children: widgets,
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
