//text的扩展方法
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextExtension on Widget{
  Widget withContainer(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.blue),
      child: this,
    );
  }
}