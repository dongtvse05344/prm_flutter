import 'package:flutter/material.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';

class OrderDoneScreen extends StatefulWidget {
  @override
  _OrderDoneScreenState createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen> {
  goToHome() {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            color: MyColor.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyColor.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5,5),
                                  blurRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-5,-5),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Icon(Icons.done,size: 40,color: MyColor.firstColor,)
                        ),
                        SizedBox(height: 10,),
                        Text("Thank you",style: MyText.littleTitle,),
                        SizedBox(height: 5,),
                        Text("Order successfully",style: MyText.des),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: 85,
              decoration: BoxDecoration(
                color: MyColor.white,

              ),
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: goToHome,
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5,5),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,-5),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text("Come back Home Screen",style: MyText.littleTitle,),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
