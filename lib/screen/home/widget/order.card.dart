import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/screen/order/order.detail.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatefulWidget {
  final Order _order;

  OrderCard(this._order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  AuthBloc _aBloc;
  OrderBloc _orderBloc;
  clickToOrderDetail(int id) {
    _orderBloc.getOrder(id, _aBloc.token);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderDetailScreen(widget._order.currentStatus == 0 ||widget._order.currentStatus == 1)
    ));
  }


  @override
  Widget build(BuildContext context) {
    _aBloc = Provider.of<AuthBloc>(context);
    _orderBloc = Provider.of<OrderBloc>(context);
    Text status ;
    switch(widget._order.currentStatus){
      case 0: status = Text("Received", style: TextStyle(color: Colors.green),); break;
      case 1: status = Text("Doing", style: TextStyle(color: Colors.yellow),); break;
      case 2: status = Text("Done", style: TextStyle(color: Colors.blueAccent),); break;
      case 3: status = Text("Cancel", style: TextStyle(color: Colors.redAccent),); break;
    }
    return InkWell(
      onTap: ()=>clickToOrderDetail(widget._order.id),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Date: "),
                Text("${widget._order.formatDate}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Address: "),
                Text(widget._order.address),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Code: "),
                Text("${widget._order.id}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Money: "),
                Text("${widget._order.totalAmount}"),
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
    );
  }
}
