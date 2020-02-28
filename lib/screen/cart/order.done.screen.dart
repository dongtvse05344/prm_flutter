import 'package:flutter/material.dart';
import 'package:prm_flutter/style/colors.dart';

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: MyColor.firstColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(Icons.done,size: 20,color: Colors.white,)
                        ),
                        Text("Thank you"),
                        Text("Order successfully"),
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
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: goToHome,
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColor.firstColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Come back Home Screen"),
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
