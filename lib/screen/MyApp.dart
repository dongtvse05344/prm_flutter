import 'package:flutter/material.dart';
import 'package:prm_flutter/bloc/auth.bloc.dart';
import 'package:prm_flutter/bloc/cartBloc.dart';
import 'package:prm_flutter/bloc/collection.bloc.dart';
import 'package:prm_flutter/bloc/product.search.bloc.dart';
import 'package:prm_flutter/screen/home/homeScreen.dart';
import 'package:prm_flutter/screen/product/product.search.screen.dart';
import 'package:provider/provider.dart';

import 'auth/loginScreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: HomeScreen(),
      ),
    );
  }
}
