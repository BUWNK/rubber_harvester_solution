import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String myLocation = 'Kegalle';

  void updateVariable(String newValue) {
    myLocation = newValue;
    notifyListeners(); 
  }
}
