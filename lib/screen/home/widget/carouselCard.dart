import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/model/collection.dart';
import 'package:prm_flutter/screen/product/product.search.screen.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:provider/provider.dart';

class CarouselCard extends StatefulWidget {
  final Collection index;

  CarouselCard(this.index);

  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  ProductSearchBloc _bloc;

  viewDetail() {
    _bloc.searchByCollection(widget.index);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=> ProductSearchScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<ProductSearchBloc>(context,listen: false);
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                child: Image.network("${Env.imageEndPoint}${widget.index.banner}", fit: BoxFit.cover,)),
            Positioned(
              right: 0,
              bottom: 0,
              child: widget.index.isCurrent ?
              InkWell(
                onTap: viewDetail,
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                  ),
                  child: Center(child: Text("More detail",style: TextStyle(color: Colors.white),),),
                ),
              ):
              Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                ),
                child: Center(child: Text("Comming Soon !!!",style: TextStyle(color: Colors.white),),),
              ),
            )
          ],
        )
    );
  }
}
