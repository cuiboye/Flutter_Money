import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 各种Button的使用
 * 1)ElevatedButton: 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
 * 2)TextButton:即文本按钮，默认背景透明并不带阴影。按下后，会有背景色
 * 3)OutlineButton:默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
 * 4)IconButton:是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
 * 5)ElevatedButton、TextButton、OutlineButton都有一个icon 构造函数，通过它可以轻松创建带图标的按钮
 */
class ButtonDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<ButtonDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: 'Button的使用',
          context: context,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => print("ElevatedButton Click"),
                child: Text("ElevatedButton")),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              onPressed: () => print("ElevatedButton.icon Click"),
              label: Text("ElevatedButton.icon"),
            ),
            TextButton(
                onPressed: () => print("TextButton Click"),
                child: Text("TextButton")),
            TextButton.icon(
                icon: Icon(Icons.send),
                onPressed: () => print("TextButton.icon Click"),
                label: Text("TextButton.icon")),
            OutlinedButton(
                onPressed: () => print("OutlinedButton Click"),
                child: Text("OutlinedButton")),
            OutlinedButton.icon(
                icon: Icon(Icons.send),
                onPressed: () => print("OutlinedButton.icon Click"),
                label: Text("OutlinedButton.icon")),
            IconButton(
                onPressed: () => print("OutlinedButton Click"),
                icon: Icon(Icons.thumb_up)),
          ],
        ),
      ),
    );
  }
}
