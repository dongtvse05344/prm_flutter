import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/model/order.detail.dart';
import 'package:prm_flutter/screen/order/widget/product.card.dart';
import 'package:prm_flutter/screen/order/widget/rating.dialog.dart';
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

  void rating(OrderDetail orderDetail) {
    showDialog(
        context: context, builder: (BuildContext context) => RatingDialog(orderDetail));
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
                      Text status ;
                      switch( order.currentStatus){
                        case 0: status = Text("Received", style: TextStyle(color: Colors.green),); break;
                        case 1: status = Text("Doing", style: TextStyle(color: Colors.yellow),); break;
                        case 2: status = Text("Done", style: TextStyle(color: Colors.blueAccent),); break;
                        case 3: status = Text("Cancel", style: TextStyle(color: Colors.redAccent),); break;
                      }
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Text("Reciever: ")),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          child: Text(order.receiver,textAlign: TextAlign.right,)
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Text("Phone Number: ")),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          child: Text(order.phoneNumber,textAlign: TextAlign.right,)
                                      ),
                                    ),
                                  ],
                                ),
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
                                    Expanded(
                                        flex: 1,
                                        child: Text("Address: ")),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          child: Text(order.address,textAlign: TextAlign.right,)
                                      ),
                                    ),
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
                                    Text("${order.totalAmount}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Status: "),
                                    status,
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
                                  return InkWell(
                                      onTap: ()=> rating(order.orderDetails[i]),
                                      child: ProductCard(order.orderDetails[i])
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
