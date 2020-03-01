import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/screen/product/product.search.screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _editingController = new TextEditingController();
  ProductSearchBloc _bloc;
  onSubmit(String text) {
    if(text.length >0) {
      _bloc.searchByName(text);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> ProductSearchScreen()
      ));
    }
  }
  clearText() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_)=>        _editingController.clear()
    );

  }
  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<ProductSearchBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: onSubmit,
                  controller: _editingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: clearText,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    hintText: "Enter name of products",

                    enabledBorder: OutlineInputBorder(

                    ),
                    focusedBorder: OutlineInputBorder(

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
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
