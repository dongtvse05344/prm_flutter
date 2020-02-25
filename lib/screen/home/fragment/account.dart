import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/screen/auth/loginScreen.dart';
import 'package:prm_flutter/screen/home/widget/menuItem.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';

class AccountFragment extends StatefulWidget {
  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {

  gotoLogin() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc _bloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: FutureBuilder(
              future: _bloc.isLogin(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  if(snapshot.data == AuthBloc.OK) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(Icons.account_circle,color: MyColor.firstColor,size: 50,),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Tran Viet Dong", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: MyColor.firstColor),),
                                    Row(
                                      children: <Widget>[
                                        Text("Edit Profile",style: TextStyle(color: Colors.grey),),
                                        Icon(Icons.navigate_next,color: Colors.grey,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(),
                        MenuItem(),
                        Divider(),
                        MenuItem(),
                        Divider(),
                        MenuItem(),
                        Divider(),
                        MenuItem(),
                        Divider(),
                      ],
                    );
                  }
                  else {
                    return InkWell(
                      onTap: gotoLogin,
                      child: Container(
                        height: 50,
                        color: MyColor.firstColor,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signInAlt,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                " Login Now",
                                style: MyText.bottomBarTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                else {
                  return Text("...");
                }

              },

          ),
        ),
      ),
      )
    );
  }
}
