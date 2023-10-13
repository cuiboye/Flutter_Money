//扩展方法
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

extension StringExtension1 on String {
  //字符转换成Color对象
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    test();
  }
  Future<void> test() async{
    await Future.wait([ function1(), function2(), function3(), ]);
    debugPrint('所有方法执行完成');
  }

  Future<void> function1() async{
    Timer(const Duration(seconds: 2), (){
      debugPrint('function1方法执行完成');
    });
  }

  Future<void> function2() async{
    Timer(const Duration(seconds: 5), (){
      debugPrint('function2方法执行完成');
    });
  }

  Future<void> function3() async{
    Timer(const Duration(seconds: 8), (){
      debugPrint('function3方法执行完成');
      // OffsetLayer

    });
  }
}