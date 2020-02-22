import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/authBloc.dart';
import 'package:prm_flutter/screen/auth/widget/loginButton.dart';
import 'package:prm_flutter/screen/auth/widget/socialButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/service/appEnv.dart';
import 'package:prm_flutter/service/authService.dart';
import 'package:prm_flutter/widget/LoadingDialog.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences prefs;
  final AuthBloc _authBloc = AuthBloc.getInstance();
  final FocusNode _usernamefocusNode = FocusNode();
  final FocusNode _passwordfocusNode = FocusNode();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _appLabel = "Start and in relaxation with the in-depth cultural tour of your pet in daily day ( Ho Chi Minh only) ";
  final ScrollController _scrollController = new  ScrollController();
  bool isExtend = true;

  usernameTap() {
    setState(() {
      isExtend = !isExtend;
    });
  }

  _onLoginButtonClick() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    _authBloc.fetchToken(username, password);
  }
  tokenListener(data) {
    switch(data) {
      case AuthBloc.START:
        LoadingDialog.showLoadingDialog(context, "Login ...");
        break;
      case AuthBloc.ERROR:
        LoadingDialog.hideLoadingDialog(context);
        MessageDialog.showMessageDialog(context, "Error", data);
        break;
      case AuthBloc.OK:
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen()
        ));
    }
  }

  initToken() async {
    print('login - init');
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    String token = prefs.get(AppEnv.TOKEN);
    if(token !=null) {
      setState(() {
        _appLabel = token;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernamefocusNode.addListener(usernameTap);
    _passwordfocusNode.addListener(usernameTap);
    _authBloc.statusStream.listen(tokenListener);
    initToken();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: isExtend? size.height * 0.4:size.height * 0.1 ,
                ),
                Container(
                  height: size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: double.infinity,
                        child: Text(
                          _appLabel
                          ,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        focusNode: _usernamefocusNode,
                        cursorColor: Color(0xffcccccc),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Username',
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
                            controller: _passwordController,
                            focusNode: _passwordfocusNode,
                            obscureText: true,
                            cursorColor: Color(0xffcccccc),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Password',

                              labelStyle: TextStyle(color: Color(0xffcccccc)),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffcccccc))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 20,
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(color: Color(0xffcccccc)),
                            ),
                          )
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
                          child: LoginButton()
                      ),
                      Row(
                        children: <Widget>[
                          SocialButton(FontAwesomeIcons.facebookF),
                          SizedBox(width: 10,),
                          SocialButton(FontAwesomeIcons.google),
                        ],
                      )

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(

                    children: <Widget>[
                      Text("Or",style: TextStyle(color: Colors.white)),
                      Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
  }


}
