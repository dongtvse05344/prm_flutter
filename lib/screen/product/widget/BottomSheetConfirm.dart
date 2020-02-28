import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/product.detail.bloc.dart';
import 'package:prm_flutter/bloc/productBloc.dart';
import 'package:prm_flutter/model/color.dart';
import 'package:prm_flutter/model/product.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';

class BottomSheetConfirm extends StatefulWidget {
  @override
  _BottomSheetConfirmState createState() => _BottomSheetConfirmState();
}

class _BottomSheetConfirmState extends State<BottomSheetConfirm> {
  String selectedSize;
  String selectedColor;
  ProductDetailBloc _productBloc = ProductDetailBloc.getInstance();
  Product _product;
  CartBloc _cartBloc;
  int amount =1;
  @override
  void initState() {
    amount = 1;
    _product = _productBloc.product;
    _productBloc.getProductSizes();
    _productBloc.getProductColors();
    super.initState();
  }

  setSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }
  setColor(String color){
    setState(() {
      selectedColor = color;
    });
  }

  subAmount() {
    setState(() {
      amount -=1;
      amount = amount<1? 1: amount;
    });
  }

  addAmount() {
    setState(() {
      amount+=1;
      amount = amount>5? 5: amount;

    });
  }
  goBack() {
    Navigator.of(context).pop();
  }
  addToCart() {
    if(selectedSize ==null) {
      MessageDialog.showMessageDialog(context, "Error", "Please fill the size to order");
      return;
    }
    if(selectedColor ==null) {
      MessageDialog.showMessageDialog(context, "Error", "Please fill the color to order");
      return;
    }
    _product.size = selectedSize;
    _product.color = selectedColor;
    _product.quantity = amount;
    _cartBloc.addToCart(_product);
    goBack();
    MessageDialog.showMessageDialog(context, "OK", "Add to cart successfull");
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _cartBloc = Provider.of<CartBloc>(context);
    return Container(
      color: Colors.white,
      height: 500,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Opacity(
              opacity: 0.2,
              child: Container(
                height: 135,
                width: size.width,
                child: Image.network("${Env.imageEndPoint}${_product.bannerPath}",fit: BoxFit.cover,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child: IconButton(icon: Icon(Icons.cancel), onPressed: goBack,)
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: Text("${_product.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width:60,
                          child: Text("Size")
                      ),
                      Container(
                        height: 50,
                        width: size.width -120,
                        child: StreamBuilder(
                          stream: _productBloc.sizesStream,
                          initialData: _productBloc.sizes,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              List<String> data = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: ()=>setSize(data[index]),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: selectedSize == data[index] ? MyColor.firstColor : Colors.transparent
                                      ),
                                      margin: EdgeInsets.only(right: 5),
                                      padding: EdgeInsets.all(5),
                                      child: Center(child: Text("${data[index]}")),
                                    ),
                                  );
                                },
                              );
                            }
                            else {
                              return Text("Loading ");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width:60,
                          child: Text("Color:")
                      ),
                      Container(
                        height: 50,
                        width: size.width -120,
                        child: StreamBuilder(
                          stream: _productBloc.colorsStream,
                          initialData: _productBloc.colors,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              List<MColor> data = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: ()=>setColor(data[index].name),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.grey),
                                          borderRadius: BorderRadius.circular(5),
                                          gradient:
                                          selectedColor == data[index].name ?
                                          LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color.fromRGBO(data[index].r,
                                                  data[index].g,
                                                  data[index].b,
                                                  data[index].o*1.0),
                                              Color.fromRGBO(data[index].r,
                                                    data[index].g,
                                                    data[index].b,
                                                    data[index].o*1.0)
                                            ],
                                          ): LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Colors.white,
                                              Color.fromRGBO(data[index].r,
                                                  data[index].g,
                                                  data[index].b,
                                                  data[index].o*.5)
                                            ],
                                          )
                                      ),
                                      margin: EdgeInsets.only(right: 5),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  );
                                },
                              );
                            }
                            else {
                              return Text("Loading ");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width:60,
                          child: Text("Amount:")
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => subAmount(),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),

                              ),
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),

                            ),
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.all(5),
                            child: Center(child: Text(amount.toString()),),
                          ),
                          InkWell(
                            onTap: addAmount,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),

                              ),
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: addToCart,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: MyColor.firstColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  child: Center(child: Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 22),),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
