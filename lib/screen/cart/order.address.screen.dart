import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/user.address.bloc.dart';
import 'package:prm_flutter/bloc/user.bloc.dart';
import 'package:prm_flutter/model/user.dart';
import 'package:prm_flutter/model/useraddress.dart';
import 'package:prm_flutter/screen/cart/create.address.screen.dart';
import 'package:prm_flutter/screen/cart/order.confirm.screen.dart';
import 'package:prm_flutter/screen/cart/widget/address.card.screen.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';
class OrderAddressScreen extends StatefulWidget {
  @override
  _OrderAddressScreenState createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  int _radioSelected = -1;
  CartBloc _cartBloc;
  UserBloc _userBloc;
  UserAddressBloc _addressBloc;
  int addressSrc =0 ;
  gotoNext() {
    if(_radioSelected == -1){
      MessageDialog.showMessageDialog(context, "Erro", "Please select the address");
      return;
    }
    _cartBloc.setAddress(_addressBloc.addresses[_radioSelected]);

     Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=> OrderConfirmScreen()
    ));
  }


  gotoCreateAddress(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=> CreateAddressScreen()
    ));
  }
  onChanged(int t){
    setState(() {
      _radioSelected = t;
    });
  }
  @override
  Widget build(BuildContext context) {
    _cartBloc = Provider.of<CartBloc>(context);
    _userBloc = Provider.of<UserBloc>(context);
    _addressBloc = Provider.of<UserAddressBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: MyColor.firstColor,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Address",style: MyText.title,),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Consumer<UserAddressBloc>(
                builder: (context, bloc, child){
                  List<UserAddress> addresses = bloc.addresses;
                  if(addresses != null) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:  addresses.length,
                      itemBuilder: (context,i){
                        return AddressCard(addresses[i],i,_radioSelected,onChanged);
                      },
                    );
                  } else {
                    return Container(
                    );
                  }
                },
              ),
              InkWell(
                onTap: gotoCreateAddress,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Add new address"),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: gotoNext,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        color: MyColor.firstColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("OK",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
