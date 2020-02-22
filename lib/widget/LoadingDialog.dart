import 'package:flutter/material.dart';

class LoadingDialog {
  static void  showLoadingDialog(BuildContext context, String message) {
    showDialog(context: context, barrierDismissible: false, builder:
        (context) => new Dialog(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0 ),
              child: Text(message, style: TextStyle(fontSize: 18),),
            )
          ],
        ),
      ),
    ));
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}