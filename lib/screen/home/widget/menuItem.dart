import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final String title;

  MenuItem(this.title);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Text("${widget.title}"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }
}
