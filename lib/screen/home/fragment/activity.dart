import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.dart';
import 'package:prm_flutter/screen/home/widget/activityBox.dart';
import 'package:prm_flutter/screen/home/widget/order.card.dart';
import 'package:prm_flutter/screen/order/order.detail.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
class ActivityFragment extends StatefulWidget {
  @override
  _ActivityFragmentState createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
  var now = new DateTime.now();
  AuthBloc _aBloc;
  OrderBloc _orderBloc;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    _aBloc = Provider.of<AuthBloc>(context);
    _orderBloc = Provider.of<OrderBloc>(context);
    if(_aBloc.token !=null) {
      _orderBloc.getOrders(_aBloc.token);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("My Activity"),
        leading: Icon(FontAwesomeIcons.gavel),
        backgroundColor: MyColor.firstColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Today",style: TextStyle(color: MyColor.firstColor, fontWeight: FontWeight.bold,fontSize: 18),),
                Text("${formattedDate}",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 18))
              ],
            ),
            Divider(),
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
          ],
        ),
      ),
    );
  }
}
