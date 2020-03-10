import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/user.address.bloc.dart';
import 'package:prm_flutter/model/useraddress.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/widget/LoadingDialog.dart';
import 'package:provider/provider.dart';

class CreateAddressScreen extends StatefulWidget {
  @override
  _CreateAddressScreenState createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController(text:"Đào Thị Hoài Thương");
  TextEditingController phoneController = new TextEditingController(text:"0334885952");
  TextEditingController addressController = new TextEditingController(text:"FPT university Distric 9, Ho Chi Minh city");
  UserAddressBloc _addressBloc;
  AuthBloc _authBloc;
  onSubmit() async {
    if (_formKey.currentState.validate())  {
      UserAddress address = new UserAddress(name: nameController.text,
          phoneNumber: phoneController.text,
          address: addressController.text);
      LoadingDialog.showLoadingDialog(context, "Loading ...");
      try {
        await _addressBloc.createAddress(address, _authBloc.token);
        Navigator.of(context).pop();
      }catch(e){
        print(e);
      }
      LoadingDialog.hideLoadingDialog(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    _addressBloc = Provider.of<UserAddressBloc>(context);
    _authBloc  = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: MyColor.firstColor,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text("Add new address"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: 'Full name',
                    enabledBorder: OutlineInputBorder(
                    ),
                    focusedBorder: OutlineInputBorder(
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone number',
                    enabledBorder: OutlineInputBorder(
                    ),
                    focusedBorder: OutlineInputBorder(
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: addressController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'Address',
                    enabledBorder: OutlineInputBorder(
                    ),
                    focusedBorder: OutlineInputBorder(
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: onSubmit,
                  child: Container(
                    height: 60,
                    color: MyColor.firstColor,
                    child: Center(child: Text("Add new address",style: TextStyle(color: Colors.white,fontSize: 20),),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




}
