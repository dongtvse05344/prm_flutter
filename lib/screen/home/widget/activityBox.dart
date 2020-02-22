import 'package:flutter/material.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:provider/provider.dart';



_MyBoxState boxState;
class MyBox extends StatefulWidget {
  @override
  _MyBoxState createState(){
    boxState = new _MyBoxState();
    return boxState;
  }
}

class _MyBoxState extends State<MyBox> {
  double myHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      height: 150,
        decoration: BoxDecoration(
          color: Color(0xffF2F3F5),
          borderRadius: BorderRadius.circular(5)
        ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Image.asset("assets/cat.png"),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Waiting",style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold,fontSize: 18)),
                Text("Booking an order at Pet 24h shop",style: TextStyle(color: MyColor.firstColor,fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(child: Text("2 Feb",style: TextStyle(color: MyColor.firstColor,fontSize: 18)),),
            ),
          )
        ],
      ),
    );
  }

}
