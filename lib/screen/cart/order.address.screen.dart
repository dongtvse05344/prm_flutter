import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/user.bloc.dart';
import 'package:prm_flutter/screen/cart/order.confirm.screen.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';
class OrderAddressScreen extends StatefulWidget {
  @override
  _OrderAddressScreenState createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  TextEditingController textEditingController = new TextEditingController();
  CartBloc _cartBloc;
  UserBloc _userBloc;
  int addressSrc =0 ;
  gotoNext() {
    var address = textEditingController.text;
    if(address ==null || address.length ==0) {
      MessageDialog.showMessageDialog(context, "Error", "Address can't be blank");
      return;
    }
    _cartBloc.setAddress(address);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=> OrderConfirmScreen()
    ));
  }
  void changeAddress(int address) {
    if(address ==0) {
      textEditingController.text = _userBloc.user.homeAddress;
    }
    else {
      textEditingController.text = _userBloc.user.companyAddress;
    }
    print("${textEditingController.text}");
    setState(() {
      addressSrc = address;
    });
  }
  @override
  Widget build(BuildContext context) {
    _cartBloc = Provider.of<CartBloc>(context);
    _userBloc = Provider.of<UserBloc>(context);
    if(textEditingController.text == null || textEditingController.text.length ==0 ){
      textEditingController.text = _userBloc.user.homeAddress;
    }
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: ()=>changeAddress(0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        color: addressSrc == 0 ? MyColor.firstColor : Colors.white,
                          border: Border.all(width: 1,color: MyColor.firstColor),
                          borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Home",style: TextStyle(color: addressSrc != 0 ? MyColor.firstColor : Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => changeAddress(1),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        color: addressSrc == 1 ? MyColor.firstColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1,color: MyColor.firstColor)
                      ),
                      child: Center(
                        child: Text("Company",style: TextStyle(color: addressSrc !=1 ? MyColor.firstColor : Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child:  TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.firstColor
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.firstColor
                        ),
                      ),
                    ),
                  ),
            ),
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
    );
  }
}
