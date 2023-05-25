import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 弹性布局
 * 1)弹性布局允许子组件按照一定比例来分配父容器空间。弹性布局的概念在其它UI系统中也都存在，如 H5 中的弹性盒子布局，
 * Android中 的FlexboxLayout等。Flutter 中的弹性布局主要通过Flex和Expanded来配合实现。
 * 2)Expanded
 * Expanded 只能作为 Flex 的孩子（否则会报错），它可以按比例“扩伸”Flex子组件所占用的空间。因为 Row和Column 都继承
 * 自 Flex，所以 Expanded 也可以作为它们的孩子。
 * 3)Spacer
 * 通过Spacer()也可以达到设置权重的效果，Spacer是Expanded的一个包装类
 */
class FlexLayout extends StatefulWidget {
  @override
  _FlexLayoutState createState() => _FlexLayoutState();
}

class _FlexLayoutState extends State<FlexLayout> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
        appBar:CustomAppbar(
          title: 'Flex布局的使用',
          context: context,
        ),
      body: Column(
        children: [
          Text("1.Expanded的使用"),
          Text(
              "1)设置权重，充满剩余空间，只能作为 Flex 的孩子（否则会报错），它可以按比例“扩伸”Flex子组件所占用的空间。因为 Row和Column 都继承自 Flex，所以 Expanded 也可以作为它们的孩子。"),
          Row(
            children: [
              Text("Hello"),
              Text("Hello"),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("这个View的权重为1，充满了剩余的控件，相当于Android中的Weight"),
              )),
              Text("Hello"),
            ],
          ),
          Text("2）可以为多个View设置权重，相当于Android中的weight"),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text("这个View的权重为1"),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text("这个View的权重为2"),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.orange),
                    child: Text("这个View的权重为3"),
                  )),
            ],
          ),
          Text("2.通过Spacer()也可以达到设置权重的效果，Spacer是Expanded的一个包装类"),
          Row(
            children: [
              Container(
                width: 80,
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                  child: Text("View1"),
                ),
              ),
              Spacer(flex: 2),
              Container(
                width: 80,
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Text("View2"),
                ),
              ),
              Spacer(),
              Container(
                width: 80,
                decoration: BoxDecoration(color: Colors.orange),
                child: Center(
                  child: Text("View3"),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
