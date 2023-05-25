import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 空间适配
 * 子组件大小超出了父组件大小时，如果不经过处理的话 Flutter 中就会显示一个溢出警告并在控制台打印错误日志
 * https://book.flutterchina.club/chapter5/fittedbox.html#_5-6-2-%E5%AE%9E%E4%BE%8B-%E5%8D%95%E8%A1%8C%E7%BC%A9%E6%94%BE%E5%B8%83%E5%B1%80
 */
class FittedBoxLayout extends StatefulWidget {
  @override
  _FittedBoxLayoutState createState() => _FittedBoxLayoutState();
}

class _FittedBoxLayoutState extends State<FittedBoxLayout> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
        appBar:CustomAppbar(
          title: '空间适配',
          context: context,
        ),
      body: Column(
        children: [

          Text("第三方的身份第三方的身份似懂非懂是非得失第三方的身份第三方的身份似懂非懂是非得失"),
        ],
      ),
    ));
  }
}
