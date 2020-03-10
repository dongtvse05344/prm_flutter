import 'package:flutter/material.dart';

import 'colors.dart';

class MyStyle {
  static BoxDecoration upBox = BoxDecoration(
      color: MyColor.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(2,2),
          blurRadius: 5,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-5,-5),
          blurRadius: 5,
        )
      ]
  );

  static BoxDecoration downBox = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(1),
        offset: const Offset(0.0, 0.0),
      ),
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        offset: const Offset(-3,-3),
        blurRadius: 0.0,

      ),
      BoxShadow(
        color: Color(0xfff2f5f8),
        offset: const Offset(0.0, 0.0),
        spreadRadius: 0.0,
        blurRadius: 10.0,
      ),
    ],
  );
}