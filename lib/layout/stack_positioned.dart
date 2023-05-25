import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 1)层叠布局与类似Android中的FrameLayout
 * 子组件可以根据距父容器四个角的位置来确定自身的位置。层叠布局允许子组件按照代码中声明的顺序堆叠起来。Flutter中使用
 * Stack和Positioned这两个组件来配合实现绝对定位。Stack允许子组件堆叠，而Positioned用于根据Stack的四个角来确
 * 定子组件的位置。
 * 2)Positioned
 * left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离。
 */
class StackAddPositioned extends StatefulWidget {
  @override
  _StackAddPositionedState createState() => _StackAddPositionedState();
}

class _StackAddPositionedState extends State<StackAddPositioned> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
      appBar: CustomAppbar(
        title: '层叠布局-Stack,Positioned',
        context: context,
      ),
      body: Stack(
        // alignment: Alignment.center,//未定位（没有使用Positioned）时子View的位置
        //创建一个堆栈布局小部件。默认情况下，未定位的子堆栈放在左上角,类似安卓的FrameLayout
        fit: StackFit.loose,
        //loose:子View多大就多大;expand:子View和父组件一样大
        children: <Widget>[
          Image.network(
            'http://www.devio.org/img/avatar.png',
            height: 100,
            width: 100,
          ), //这个会显示在最底部
          Image.network(
            'http://www.devio.org/img/avatar.png',
            height: 80,
            width: 80,
          ),
          Image.network(
            'http://www.devio.org/img/avatar.png',
            height: 60,
            width: 60,
          ),
        ],
      ),
    ));
  }
}
