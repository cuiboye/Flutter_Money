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
            ElevatedButton(
              onPressed: () {
                // 直接通过of静态方法来获取ScaffoldState
                ScaffoldState _state = Scaffold.of(context);
                // 打开抽屉菜单
                _state.openDrawer();
              },
              child: Text('打开抽屉菜单2'),
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
