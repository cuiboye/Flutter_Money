import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

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
        body: Row(
            children: [
              Flexible(
                  child:  Text("hello"*1000)
              )

            ],
        ),
        appBar:CustomAppbar(
          title: 'Test',
          context: context,
        ),
      ),
    );
  }
  //_下划线
  _test(){
    name ??= "lisi";
    var result = name ?? "zhangsan";
    print(name?.length);
  }
}
