//扩展方法
import 'package:flutter/cupertino.dart';

extension HclWidget on Widget {
  Widget marginAll(double margin){
    return Container(
      margin: EdgeInsets.all(margin),
      alignment: Alignment.center,
      child: this,
    );
  }
}