import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/categoryBloc.dart';
import 'package:prm_flutter/screen/home/widget/categoryCard.dart';

class FavoriteFragment extends StatefulWidget {
  @override
  _FavoriteFragmentState createState() => _FavoriteFragmentState();
}

class _FavoriteFragmentState extends State<FavoriteFragment> {
  CategoryBloc _categoryBloc = CategoryBloc.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryBloc.getCategories();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    child:
                    StreamBuilder(
                      initialData: _categoryBloc.categories,
                      stream: _categoryBloc.categoriesStream,
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          List data = snapshot.data;
                          List<Widget> widgets = new List<Widget>();
                          for(var i = 0; i< data.length;i++){
                            widgets.add(CategoryCard(data[i]));
                          }
                          return Wrap(
                            children: widgets,
                          );
                        }
                        else {
                          return Text("Loading ...");
                        }
                      },

                    )
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
