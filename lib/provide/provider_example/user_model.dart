
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier{
// class UserModel{//
  String name = "Jimi";
  void changeName() {
    name = "hello";
    print(name);
    notifyListeners();

  }
}