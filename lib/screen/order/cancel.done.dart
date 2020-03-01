import 'package:flutter/material.dart';
import 'package:prm_flutter/style/colors.dart';

class CancelDoneScreen extends StatefulWidget {
  @override
  _CancelDoneScreenState createState() => _CancelDoneScreenState();
}

class _CancelDoneScreenState extends State<CancelDoneScreen> {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Text("Cancel order successfully",style: TextStyle(fontSize: 22),),
                        Container(
                          child: Center(
                              child: Text("We're sorry about what you afford with our services",),
                            //
                          ),
                        ),
                        Text("If you have any complain to us. Contact via 0123-456-789",)
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
