import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/categoryBloc.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/home/widget/carouselCard.dart';
import 'package:prm_flutter/screen/home/widget/categoryCard.dart';
import 'package:prm_flutter/screen/home/widget/productCard.dart';
import 'package:prm_flutter/screen/home/widget/serviceCard.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin<HomeFragment> {
  CategoryBloc _categoryBloc = CategoryBloc.getInstance();
  ProductBloc _productBloc = ProductBloc.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryBloc.getCategories();
    _productBloc.getTopProducts();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('WEOZ', style: MyText.title,),
                    Container(
                      width: 200,
                      height: 40,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                          hintText: "Search",
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(),
                          suffixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColor.firstColor
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          filled: true,
                          fillColor: Colors.black12
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
//                FutureBuilder(
//                  future: _categoryBloc.getCarouselBanner(),
//                  builder: (context, snapshot){
//                    if(snapshot.hasData) {
//                      List<String> data = snapshot.data;
//                      return CarouselSlider(
//                        height: 200.0,
//                        enlargeCenterPage: true,
//                        items: data.map((i) {
//                          return Builder(
//                            builder: (BuildContext context) {
//                              return CarouselCard(i);
//                            },
//                          );
//                        }).toList(),
//                      );
//
//                    }
//                    else {
//                      return Text('Loading');
//                    }
//                  },
//                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Category', style: MyText.title,),
                    Text('More'),
                  ],
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
                        return Text("Loading ...");
                      }
                    },

                  )
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Recommended Shop', style: MyText.title,),
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
                         return Text("Loading ...");
                       }
                     },
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Top rank of services', style: MyText.title,),
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
