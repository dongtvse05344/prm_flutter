import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/bloc/product.detail.bloc.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/screen/cart/cart.screen.dart';
import 'package:prm_flutter/screen/product/widget/BottomSheetConfirm.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';

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

  onAddToCart() {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: BottomSheetConfirm());
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
            SingleChildScrollView(
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
                                  child:
                                  _seletedImage ==null ?
                                  Image.network(
                                    "${Env.imageEndPoint}${_product.bannerPath}",
                                    fit: BoxFit.cover,
                                  ) :
                                  Image.network(
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
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.yellow,
                                    ),
                                    Text("${_product.star}"),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.timelapse,
                                      color: Colors.grey,
                                    ),
                                    Text("\$ ${_product.currentPrice}"),
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
                                                onTap: () => changeSeletedImage(
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
                                          return Text("Loading ...");
                                        }
                                      }),
                                ),
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "My services",
                                      style: MyText.cardTitle,
                                    ),
                                  ],
                                ),
                                Container(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: <Widget>[],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container(
                        child: Text("Loading ..."),
                      );
                    }
                  }),
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
                          "Shop booking",
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
              height: 50,
              width: media.size.width,
              child: InkWell(
                onTap: onAddToCart,
                child: Container(
                  color: MyColor.firstColor,
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
