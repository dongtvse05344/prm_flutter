import 'package:flutter/material.dart';
import 'package:prm_flutter/screen/home/widget/menuItem.dart';
import 'package:prm_flutter/style/colors.dart';

class AccountFragment extends StatefulWidget {
  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}