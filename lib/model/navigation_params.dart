
import 'package:flutter/material.dart';

class NavigationParams with ChangeNotifier{
  String backParams = "";
  void setParams(String params){
    print("${params}");
    backParams = params;
    notifyListeners();
  }
}