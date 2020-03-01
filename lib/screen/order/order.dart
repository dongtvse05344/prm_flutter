import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/screen/home/widget/order.card.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final int index ;

  OrderScreen(this.index);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My orders",style: TextStyle(color: MyColor.firstColor),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: MyColor.firstColor,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            child: DefaultTabController(
                length: 2,
                initialIndex: widget.index,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: MyColor.firstColor,
                        indicatorColor: MyColor.firstColor,
                        tabs: [
                          Tab(text: "Active orders",),
                          Tab(text: "Past orders",),
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints.expand(),
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child:
                                  Consumer<OrderBloc>(
                                    builder: (context, bloc, child) {
                                      List<Order> orders = bloc.orders;
                                      if(orders != null) {
                                        return ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:  orders.length,
                                          itemBuilder: (context,i){
                                            return OrderCard(orders[i]);
                                          },
                                        );
                                      } else {
                                        return Text("You must be login first");
                                      }
                                    },
                                  ),
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints.expand(),
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child:
                                Consumer<OrderBloc>(
                                  builder: (context, bloc, child) {
                                    List<Order> orders = bloc.ordersD;
                                    if(orders != null) {
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:  orders.length,
                                        itemBuilder: (context,i){
                                          return OrderCard(orders[i]);
                                        },
                                      );
                                    } else {
                                      return Text("You must be login first");
                                    }
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
