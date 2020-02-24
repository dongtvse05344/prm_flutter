import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/categoryBloc.dart';
import 'package:prm_flutter/screen/home/fragment/account.dart';
import 'package:prm_flutter/screen/home/fragment/activity.dart';
import 'package:prm_flutter/screen/home/fragment/favorite.dart';
import 'package:prm_flutter/screen/home/fragment/home.dart';
import 'package:prm_flutter/service/appEnv.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryBloc _categoryBloc = CategoryBloc.getInstance();
  PageController _pageController = new PageController();
  SharedPreferences prefs;
  int bottom_nav_index = 0;
  String _appLabel = "Home";


  @override
  void initState() {
  }

  initToken() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    String token = prefs.get(AppEnv.TOKEN);
    if(token !=null) {
      setState(() {
        _appLabel = token;
      });
    }
  }

  void changBottomIndex(int index) {
    setState(() {
      bottom_nav_index = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: AnimatedSwitcher(
//          duration: Duration(milliseconds: 500),
//          child: body
//      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeFragment(),
          FavoriteFragment(),
          ActivityFragment(),
          AccountFragment()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: BubbleBottomBar(
          backgroundColor: Colors.transparent,
          opacity: 1,
          elevation: 0,
          currentIndex: bottom_nav_index,
          onTap: changBottomIndex,
          items: <BubbleBottomBarItem> [
            BubbleBottomBarItem(
              backgroundColor: MyColor.firstColor,
              icon: Icon(Icons.home, color: MyColor.firstColor,),
              activeIcon: Icon(Icons.home, color: Colors.white,),
              title: Text(_appLabel,style: MyText.bottomBarTitle,),
            ),
            BubbleBottomBarItem(
              backgroundColor: MyColor.firstColor,
              icon: Icon(Icons.category, color: MyColor.firstColor,),
              activeIcon: Icon(Icons.category, color: Colors.white,),
              title: Text("Cate",style: MyText.bottomBarTitle,),
            ),
            BubbleBottomBarItem(
              backgroundColor: MyColor.firstColor,
              icon: Icon(Icons.history, color: MyColor.firstColor,),
              activeIcon: Icon(Icons.history, color: Colors.white,),
              title: Text("History",style: MyText.bottomBarTitle,),
            ),
            BubbleBottomBarItem(
              backgroundColor: MyColor.firstColor,
              icon: Icon(Icons.menu, color: MyColor.firstColor,),
              activeIcon: Icon(Icons.menu, color: Colors.white,),
              title: Text("Menu",style: MyText.bottomBarTitle,),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryBloc.dispose();
  }
}
