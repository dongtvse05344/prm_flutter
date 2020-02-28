import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/screen/cart/order.done.screen.dart';
import 'package:prm_flutter/service/order.service.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';

class OrderConfirmScreen extends StatefulWidget {
  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  OrderBloc _orderBloc;
  CartBloc _cartBloc;
  AuthBloc _authBloc;
  confirm() async{
    OrderCM data = OrderCM();
    List<OrderDetailCM> orderDetai = List();
    data.address = _cartBloc.order.address;
    data.note =  _cartBloc.order.note;
    _cartBloc.cart.forEach((i,product) {
      orderDetai.add(new OrderDetailCM(
        color: product.color,
        size: product.size,
        productId: product.id,
        quantity: product.quantity
      ));
    });
    data.orderDetailCMs = orderDetai;
    var result = await _orderBloc.createOrder(data,_authBloc.token);
    if(result) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderDoneScreen()
      ));
    }

  }
  @override
  Widget build(BuildContext context) {
    _orderBloc = Provider.of<OrderBloc>(context);
    _cartBloc = Provider.of<CartBloc>(context);
    _authBloc = Provider.of<AuthBloc>(context);
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
        title: Text("Confirm Order",style: MyText.title,),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Order information"),
                      Text("Edit")
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: 120,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total Amount: "),
                      Text("9.99 \$")
                    ],
                  ),
                  InkWell(
                    onTap: confirm,
                    child: Container(
                      width: size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: MyColor.firstColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Order"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
