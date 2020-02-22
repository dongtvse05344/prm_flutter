//import 'package:flutter/material.dart';
//import 'package:prm_flutter/bloc/mySchedule.dart';
//import 'package:prm_flutter/style/colors.dart';
//import 'package:provider/provider.dart';
//import 'activityBox.dart';
//
//class MySlider extends StatefulWidget {
//  @override
//  _MySliderState createState() => _MySliderState();
//}
//
//class _MySliderState extends State<MySlider> {
//
//  var _value = 0.5;
//  void _onValueChanged(double value){
//
//    setState(() {
//      _value =value;
//    });
//
//  }
//  @override
//  Widget build(BuildContext context) {
//    final schedule = Provider.of<MySchedule>(context);
//    return Slider(
//      value: schedule.stateMangementTime,
//      onChanged: (value) => schedule.stateMangementTime = value,
//    );
//  }
//}
