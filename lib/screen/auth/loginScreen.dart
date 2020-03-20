import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/screen/auth/signupScreen.dart';
import 'package:prm_flutter/screen/auth/widget/loginButton.dart';
import 'package:prm_flutter/screen/auth/widget/socialButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/widget/LoadingDialog.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
//  final FacebookLogin facebookLogin = FacebookLogin();
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    googleSignIn.signOut();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleSignInAuthentication.accessToken,
//      idToken: googleSignInAuthentication.idToken,
//    );
//
//    final AuthResult authResult = await _auth.signInWithCredential(credential);
//    final FirebaseUser user = authResult.user;
//
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);
//    return user;
    return googleSignInAccount;

  }

  Future<FirebaseUser> signInWithFacebook() async {
//    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
//
//    if (result.status == FacebookLoginStatus.loggedIn) {
//      final credential = FacebookAuthProvider.getCredential(
//        accessToken: result.accessToken.token,
//      );
//      final user = (await _auth.signInWithCredential(credential)).user;
//      print(user);
//    }
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }
  void fbSignIn() {
    signInWithFacebook();
  }
  void ggSignIn() {
    signInWithGoogle().then((rs)=>{
      googleSignIn.signOut(),
      _authBloc.googleSignin(rs.email, rs.email, rs.email,rs.displayName,null, tokenListener)
    }).catchError((e)=>{
      print(e),
        MessageDialog.showMessageDialog(context, "Error", "Unable to connect to server"),
    });
  }

  AuthBloc _authBloc;
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

  gotoSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpScreen(),
    ));
  }

  _onLoginButtonClick() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var deviceId = await _fcm.getToken();
    _authBloc.fetchToken(username, password, deviceId,tokenListener);
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
        Navigator.of(context).pop();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernamefocusNode.addListener(usernameTap);
    _passwordfocusNode.addListener(usernameTap);
  }
  @override
  Widget build(BuildContext context) {
    _authBloc = Provider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                        child: LoginButton("Sign In")
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                            onTap: fbSignIn,
                            child: SocialButton(FontAwesomeIcons.facebookF)
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                            onTap: ggSignIn,
                            child: SocialButton(FontAwesomeIcons.google)),
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
                    InkWell(
                        onTap: gotoSignup,
                        child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                    ),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


}
