import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/categoryBloc.dart';
import 'package:prm_flutter/bloc/collection.bloc.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/cart/cart.screen.dart';
import 'package:prm_flutter/screen/home/widget/carouselCard.dart';
import 'package:prm_flutter/screen/home/widget/categoryCard.dart';
import 'package:prm_flutter/screen/home/widget/productCard.dart';
import 'package:prm_flutter/screen/home/widget/serviceCard.dart';
import 'package:prm_flutter/screen/product/search.screen.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/myStyle.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin<HomeFragment> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();


  CategoryBloc _categoryBloc = CategoryBloc.getInstance();
  ProductBloc _productBloc = ProductBloc.getInstance();
  CollectionBloc _collectionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryBloc.getCategories();
    _productBloc.getTopProducts();

  }
  goToCartScreen(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>CartScreen(),
    ));
  }
  gotoSearch() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>SearchScreen(),
    ));
  }

  Future<void> _refresh() async {
    print('refesing');
    _categoryBloc.getCategories();
    _collectionBloc.getCollection();
    _productBloc.getTopProducts();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _collectionBloc = Provider.of<CollectionBloc>(context,listen: false);
    return SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        color: MyColor.white,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('BRIDGE', style: MyText.title,),

                      Row(
                        children: <Widget>[

                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: MyStyle.upBox,
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart, color: MyColor.firstColor,),
                              onPressed: goToCartScreen,
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  Consumer<CollectionBloc>(
                    builder: (context, _bloc, child){
                      var collection = _bloc.collection;
                      if(collection ==null) {
                        return Container(
                          height: 200.0,
                          child:
                              Center(
                                child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  width: 320.0,
                                  height: 200,
                                  color: Colors.white,
                                ),
                          ),
                              ),
                        );
                      }
                        return CarouselSlider(
                          height: 200.0,
                          enlargeCenterPage: true,
                          items: collection.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return CarouselCard(i);
                              },
                            );
                          }).toList(),
                        );
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: gotoSearch,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 50,
                                width: size.width-20,
                                decoration: MyStyle.downBox,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Enter name, collection, ...",style: TextStyle(color: Colors.grey[400]),),
                                    Icon(Icons.search,color: MyColor.firstColor,)
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    height: 140,
                    child:
                    StreamBuilder(
                      initialData: _categoryBloc.categories,
                      stream: _categoryBloc.categoriesStream,
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          List data = snapshot.data;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                            CategoryCard(data[index]),
                            itemCount: data.length,
                          );
                        }
                        else {
                          return ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                width: 120.0,
                                height: 140,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      },

                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('New arrival', style: MyText.title,),
                      Text('More'),
                    ],
                  ),
                  Container(
                    height: 180,
                    child: StreamBuilder(
                       initialData: _productBloc.products,
                       stream: _productBloc.productsStream,
                       builder: (context, snapshot) {
                         if(snapshot.hasData){
                           List<Product> data = snapshot.data;
                           return ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: data.length,
                             itemBuilder: (context, index){
                               return ProductCard(data[index]);
                             },
                           );
                         }else {
                           return ListView.builder(
                             itemCount: 2,
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) => Shimmer.fromColors(
                               baseColor: Colors.grey[300],
                               highlightColor: Colors.white,
                               child: Container(
                                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                 width: 220.0,
                                 height: 180,
                                 color: Colors.white,
                               ),
                             ),
                           );
                         }
                       },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Explore', style: MyText.title,),
                      Text('More'),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
//                  child: FutureBuilder(
//                    future: _productBloc.getTopProducts(),
//                    builder: (context, snapshot) {
//                      if(snapshot.hasData){
//                        List<Product> data = snapshot.data;
//                        return ListView.separated(
//                          physics: NeverScrollableScrollPhysics(),
//                          shrinkWrap: true,
//                          separatorBuilder: (context, index) => Divider(),
//                          scrollDirection: Axis.vertical,
//                          itemCount: data.length,
//                          itemBuilder: (context, index){
//                            return ServiceCard(data[index]);
//                          },
//                        );
//                      }else {
//                        return Text("Loading ...");
//                      }
//                    },
//                  ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    print("-- home dispose");
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
