import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * Column嵌套Column或者Row嵌套Row的情况
 */
class LinearLayout2 extends StatefulWidget {
  @override
  __LinearLayout2State createState() => __LinearLayout2State();
}

class __LinearLayout2State extends State<LinearLayout2> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar:CustomAppbar(
            title: 'Column嵌套Column或者Row嵌套Row的情况',
            context: context,
          ),
        // body: columnContainsColumn()),
      //如果要让里面的Column占满外部Column，可以使用Expanded 组件：
          body: Column(
            children: [
              Text("Column嵌套Column或者Row嵌套Row，里面的Column或者Row失效"),
              columnContainsColumn(),
              Text("可以使用Expanded解决上面的问题"),
              columnContainsColumnWithExpanded()
            ],
          )
      ),
    );
  }

  //Column嵌套Column或者Row嵌套Row的情况
  Widget columnContainsColumn(){
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
        children: <Widget>[
          Text("hello world "),
          Text("I am Jack "),
        ],
      ),
    );
  }

  Widget columnContainsColumnWithExpanded(){
    return Expanded(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
          children: <Widget>[
            Text("hello world "),
            Text("I am Jack "),
          ],
        ),
      ),
    );
  }
}
