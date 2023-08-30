
import 'package:flutter/cupertino.dart';

class Singleton {
  static Singleton _instance = null;

  // 私有的命名构造函数
  Singleton._internal();

  static Singleton getInstance() {
    if (_instance == null) {
      _instance = Singleton._internal();
    }
    return _instance;
  }

  void play(){
    debugPrint('play');
  }
}