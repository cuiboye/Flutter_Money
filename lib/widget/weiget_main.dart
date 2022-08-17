import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 各种组件
 */
class WeigetMain extends StatefulWidget {
  @override
  _WeigetMainState createState() => _WeigetMainState();
}
var list = [ "Text", "Button","Icon","单选开关和复选框","输入框及表单","进度指示器"];
var pushNamedList= [
  "text", "button","icon","switchaddselectBox","inputaddform","indicator"
];
class _WeigetMainState extends State<WeigetMain> {
  Widget divider=Divider(color: Colors.blue,);
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: '各种组件',
          context: context,
        ),
        body: ListView.separated(
          itemCount: list.length,
          //列表项构造器
          itemBuilder: (BuildContext buildContext, int index) {
            return ListTile(title: GestureDetector(
              child: Text(list[index]),
              onTap: ()=>{
                print("${pushNamedList[index]}"),
                Navigator.pushNamed(context, pushNamedList[index])
              },
            ));
          },
          //分割器构造器
          separatorBuilder: (BuildContext context, int index) {
            return divider;
          },
        ),
      ),
    );
  }
}
