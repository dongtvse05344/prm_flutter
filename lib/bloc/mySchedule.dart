import 'package:flutter/cupertino.dart';

class MySchedule with ChangeNotifier{
  double _stateManagementTime = 0.5;

  double get stateMangementTime => _stateManagementTime;

  set stateMangementTime(double newValue) {
    _stateManagementTime = newValue;
    notifyListeners();
  }
}