import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/cart.bloc.dart';
import 'package:prm_flutter/bloc/collection.bloc.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/bloc/user.address.bloc.dart';
import 'package:prm_flutter/bloc/user.bloc.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';

import 'auth/loginScreen.dart';
import 'order/MessageDemo.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
        ChangeNotifierProvider<CartBloc>(
          create: (context)=> CartBloc(),
        ),
        ChangeNotifierProvider<CollectionBloc>(
          create: (context)=> CollectionBloc(),
        ),
        ChangeNotifierProvider<ProductSearchBloc>(
          create: (context)=> ProductSearchBloc(),
        ),
        ChangeNotifierProvider<AuthBloc>(
          create: (context)=> AuthBloc(),
        ),
        ChangeNotifierProvider<UserBloc>(
          create: (context)=> UserBloc(),
        ),
        ChangeNotifierProvider<OrderBloc>(
          create: (context)=> OrderBloc(),
        ),
        ChangeNotifierProvider<UserAddressBloc>(
          create: (context)=> UserAddressBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(),
        )
            .copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
      home: HomeScreen(),
//        home: MessagingDemo(),
      ),
    );
  }
}

