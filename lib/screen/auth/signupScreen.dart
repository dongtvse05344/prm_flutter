import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/screen/auth/widget/loginButton.dart';
import 'package:prm_flutter/screen/auth/widget/socialButton.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/widget/LoadingDialog.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  String username ="";
  String email = "";
  String fullname = "";
  String phoneNumber = "";

  SignUpScreen({this.username, this.email, this.fullname, this.phoneNumber});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthBloc _authBloc;

  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _fullnameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phonenumberController = new TextEditingController();
  final TextEditingController _repasswordController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final ScrollController _scrollController = new  ScrollController();
  bool isExtend = true;
  String errorPassword =null;
  String errorFullname = null;
  String errorUsername = null;


  _onLoginButtonClick() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var fullname = _fullnameController.text;
    var email = _emailController.text;
    var phoneNumber = _phonenumberController.text;
    var repassword = _repasswordController.text;

    String _errorPassword = "";
    String _errorUsername ="";
    if(password.length<6) {
      _errorPassword = "Password must has at least 6 characters";
    } else
    if(password != repassword) {
        _errorPassword = "Re password is not matched";
    } else _errorPassword = null;

    if(username.length<6) {
      _errorUsername = "Username must has at least 6 characters";
    } else _errorUsername = null;

    if(_errorUsername == null && _errorPassword == null){
      _authBloc.register(username, password, email, phoneNumber, fullname, apiListener);
    }
    else {
      setState(() {
        errorPassword = _errorPassword;
        errorUsername = _errorUsername;
      });
    }
  }
  apiListener(data) {
    switch(data) {
      case AuthBloc.START:
        LoadingDialog.showLoadingDialog(context, "Register ...");
        break;
      case AuthBloc.ERROR:
        LoadingDialog.hideLoadingDialog(context);
        setState(() {
          errorUsername = "User name has been taken.";
        });
        break;
      case AuthBloc.OK:
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = Provider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: size.width,
                height: size.height,
                child: Image.asset(
                  "assets/login_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.55,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                      ),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _fullnameController,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.creditCard,color: Colors.white,),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.envelope,color: Colors.white,),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          TextFormField(
                            controller: _phonenumberController,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.phone,color: Colors.white,),
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          TextFormField(
                            controller: _usernameController,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.user,color: Colors.white,),
                              labelText: 'Username',
                              errorText: errorUsername,
                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.lock,color: Colors.white,),
                              labelText: 'Password',
                              errorText: errorPassword,
                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              TextFormField(
                                controller: _repasswordController,
                                obscureText: true,
                                cursorColor: Color(0xffcccccc),
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Re-Password',
                                  prefixIcon: Icon(FontAwesomeIcons.key,color: Colors.white,),
                                  labelStyle: TextStyle(color: Color(0xffcccccc)),
                                  focusColor: Colors.white,
                                  fillColor: Colors.white,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffcccccc))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                              onTap: _onLoginButtonClick,
                              child: LoginButton("Sign Up")
                          ),

                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
