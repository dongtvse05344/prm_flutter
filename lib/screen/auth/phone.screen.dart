import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PhoneVerifyScreen extends StatefulWidget {
  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  TextEditingController _smsCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber;
  String smsCode;
  String verificationCode;
  String verificationId;
  Future<void> _submit() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
    };

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) {
      print("Verificado");
    };

    final PhoneVerificationFailed phoneVerificationFailed = (
        AuthException exception) {
      print("FAIL: ${exception.message}");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );
  }
  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text("Verify"),
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user) {
                    if(user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Phone Number"
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phoneNumber = value,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    child: RaisedButton(
                      onPressed: _submit,
                      child: Text("Submit", style: TextStyle(fontSize: 15.0, color: Colors.white),),
                      color: Color(0xFF18D191),
                      elevation: 7.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
