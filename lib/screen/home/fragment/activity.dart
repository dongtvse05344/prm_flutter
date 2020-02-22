import 'package:flutter/material.dart';
import 'package:prm_flutter/screen/home/widget/activityBox.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
class ActivityFragment extends StatefulWidget {
  @override
  _ActivityFragmentState createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Activity"),
        leading: Icon(FontAwesomeIcons.gavel),
        backgroundColor: MyColor.firstColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Today",style: TextStyle(color: MyColor.firstColor, fontWeight: FontWeight.bold,fontSize: 18),),
                Text("5 Feb 2020",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 18))
              ],
            ),
            MyBox(),
            MyBox(),
            MyBox(),

          ],
        ),
      ),
    );
  }
}
