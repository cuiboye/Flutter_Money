import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          print("Parent的尺寸：$constraints");
          return Text("hello");
        }),
        // body: ConstrainedBox(constraints: BoxConstraints(
        //     minWidth: 0,
        //     maxWidth: 100,
        //     minHeight: 0,
        //     maxHeight: 100
        //
        // ),
        //   child: Container(
        //     height: 1000,
        //     width: 10000,
        //     color: ColorConstant.systemColor,
        //     child: Text("sdfds"),
        //   ),
        // ),
        appBar:CustomAppbar(
          title: 'Test',
          context: context,
        ),
      ),
    );
  }
  //_下划线
  _test(){
    String? name;
    name ??= "lisi";//当且仅当b为null时才赋值
    var result = name ?? "zhangsan";
    print(name?.length);
  }
}
