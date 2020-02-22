import 'package:flutter/material.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/style/colors.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.white),
        color: MyColor.firstColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
    );
  }
}
