import 'package:flutter/material.dart';

class CountNotifier with ChangeNotifier {

  int count = 0;

  void increment() {
    count++;
    notifyListeners();//通知子节点进行刷新
  }
}