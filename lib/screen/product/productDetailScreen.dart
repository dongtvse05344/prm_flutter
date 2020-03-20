import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/product.detail.bloc.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/model/rate.dart';
import 'package:prm_flutter/screen/cart/cart.screen.dart';
import 'package:prm_flutter/screen/product/widget/BottomSheetConfirm.dart';
import 'package:prm_flutter/screen/product/widget/feedback.card.dart';
import 'package:prm_flutter/screen/product/widget/rate.card.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/myStyle.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;

  ProductDetailScreen({@required this.id});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  ProductDetailBloc _bloc = new ProductDetailBloc();
  String _seletedImage;
  final scrollController = new ScrollController();
  double barOpacity = 0;
  int sizeTop = 20;
  Product _product;

  initData() async {
    await _bloc.getProduct(widget.id);
    _product = _bloc.product;
    _bloc.getProductImage();
    _bloc.getProductRates();
    ProductDetailBloc.setInstance(_bloc);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void changeSeletedImage(String image) {
    setState(() {
      _seletedImage = image;
    });
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void onScroll() {
    var tempOpacity = scrollController.position.pixels;
    if (tempOpacity <= sizeTop && barOpacity == 1) {
      setState(() {
        barOpacity = 0;
      });
    } else if (tempOpacity > sizeTop && barOpacity == 0) {
      setState(() {
        barOpacity = 1;
      });
    }
  }

  goToCartScreen() {

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CartScreen(),
    ));
  }

  onAddToCart(BuildContext context) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetConfirm();
        }).then((rs) {
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: MyColor.white,
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: StreamBuilder(
                    stream: _bloc.productStream,
                    initialData: _bloc.product,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Product _product = snapshot.data;
                        return Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: _seletedImage == null
                                        ? Hero(
                                          tag: "ProductBanner${_product.bannerPath}",
                                          child: Image.network(
                                              "${Env.imageEndPoint}${_product.bannerPath}",
                                              fit: BoxFit.cover,
                                            ),
                                        )
                                        : Image.network(
                                            "${Env.imageEndPoint}${_seletedImage}",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.error,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.gavel,
                                        color: Colors.lightGreen,
                                      ),
                                      Text(
                                        " Shop loved",
                                        style:
                                            TextStyle(color: Colors.lightGreen),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${_product.name}",
                                    style: MyText.pageTitle,
                                  ),
                                  Text(
                                    "${_product.description}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.yellow,
                                          ),
                                          Text("${_product.star}"),

                                        ],
                                      ),
                                      Container(
                                          decoration: MyStyle.upBox,
                                          padding: EdgeInsets.all(10),
                                          child: Text("\$ ${_product.currentPrice}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.loyalty,
                                        color: Colors.grey,
                                      ),
                                      Text(" Special discount for combo"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Images",
                                        style: MyText.cardTitle,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 100,
                                    child: StreamBuilder(
                                        initialData: _bloc.images,
                                        stream: _bloc.imagesStream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<String> data = snapshot.data;
                                            return ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () =>
                                                      changeSeletedImage(
                                                          data[index]),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    margin: EdgeInsets.only(
                                                        right: 30),
                                                    child: Image.network(
                                                        "${Env.imageEndPoint}${data[index]}"),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                width: 120.0,
                                                height: 140,
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                        }),
                                  ),

                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: StreamBuilder(
                                          initialData: _bloc.rates,
                                          stream: _bloc.rateStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Rate> data = snapshot.data;
                                              if(data.length>0) {
                                                return Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Rating and Feedback ",
                                                        style: MyText.cardTitle),
                                                    RateCard(data[data.length-1]),
                                                    ListView.builder(
                                                      scrollDirection:
                                                      Axis.vertical,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: data.length-1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          child: FeedBackCard(data[index]),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }else {
                                                return Container();
                                              }
                                            } else {
                                              return Container(
                                                child: Shimmer.fromColors(
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
                                          })),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container(
                          child: Shimmer.fromColors(
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
                    }),
              ),
            ),
            Positioned(
              height: 50,
              width: media.size.width,
              child: Stack(
                children: <Widget>[
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: barOpacity > 1 ? 1 : barOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5, 0),
                                blurRadius: 5)
                          ]),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: goBack,
                          icon: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        Text(
                          "",
                          style: MyText.cardTitle,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                          onPressed: goToCartScreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              height: 80,
              width: media.size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: ()=>onAddToCart(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColor.firstColor,
                        borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2,2),
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5,-5),
                          blurRadius: 5,
                        )
                      ]),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add to Cart",
                            style: MyText.bottomBarTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    _bloc.dispose();
    super.dispose();
  }
}
