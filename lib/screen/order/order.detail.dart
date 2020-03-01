import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/screen/order/widget/timeLine.dart';
import 'package:prm_flutter/service/apiEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';

import 'cancel.done.dart';

class OrderDetailScreen extends StatefulWidget {
  final bool canCancel;

  OrderDetailScreen(this.canCancel);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderBloc _orderBloc;
  AuthBloc _authBloc;
  cancelOrder() async {
    if(_authBloc.token != null) {
      var result = await _orderBloc.cancelOrder(_orderBloc.order.id, _authBloc.token);
      if(result) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CancelDoneScreen(),
        ));
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    _orderBloc = Provider.of<OrderBloc>(context);
    _authBloc  = Provider.of<AuthBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: MyColor.firstColor,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Order Detail",style: MyText.title,),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Consumer<OrderBloc>(
                  builder: (context, oBloc,child){
                    Order order = oBloc.order;
                    if(order != null) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Date: "),
                                    Text("${order.formatDate}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Address: "),
                                    Text(order.address),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Code: "),
                                    Text("${order.id}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Money: "),
                                    Text("${order.totalAmount}\$"),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Container(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:  order.orderDetails.length,
                                itemBuilder: (context,i){
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Image.network("${Env.imageEndPoint}${order.orderDetails[i].image}"),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("Color: "),
                                                Text("${order.orderDetails[i].color}",)
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("Size: "),
                                                Text("${order.orderDetails[i].size}",)
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("Quantity: "),
                                                Text("${order.orderDetails[i].quantity}",)
                                              ],
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                          ),
                          Divider(),
                          Container(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:  order.orderStatues.length,
                                itemBuilder: (context,i){
                                  if(i < order.orderStatues.length-1){
                                    return TimelineRow("${order.orderStatues[i].name}",
                                        "${DateFormat("dd-MM-yyyy").format(order.orderStatues[i].dateCreated)}");
                                  } else {
                                    return TimelineLastRow("${order.orderStatues[i].name}",
                                        "${DateFormat("dd-MM-yyyy").format(order.orderStatues[i].dateCreated)}");
                                  }

                                },
                              )
                          )
                        ],
                      );
                    }
                    else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
          widget.canCancel ? Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: 90,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: cancelOrder,
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColor.firstColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Cancel Order"),
                  ),
                ),
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
