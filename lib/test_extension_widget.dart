//测试扩展方法在Widget中的应用

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'text_extension.dart';

class TestExtensionWidget extends StatefulWidget {
  @override
  _TestExtensionWidgetState createState() => _TestExtensionWidgetState();
}

class _TestExtensionWidgetState extends State<TestExtensionWidget> {

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: '测试扩展方法在Widget中的使用',
          context: context,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: <Widget>[
          //   Container(
          //     margin: const EdgeInsets.all(10),
          //     alignment: Alignment.center,
          //     child: const Text("ZL"),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(10),
          //     alignment: Alignment.center,
          //     child: const Text("ZL"),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(10),
          //     alignment: Alignment.center,
          //     child: const Text("ZL"),
          //   ),
          // ],
          //使用Widget的扩展方法后，就不用写上面那些重复的代码了
          children: [
            Text("ZL").marginAll(10),
            Text("ZL").marginAll(10),
            Text("ZL").marginAll(10)
          ],
        ),
      ),

    );
  }
}
