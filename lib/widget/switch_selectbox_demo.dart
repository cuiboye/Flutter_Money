import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

import '../view/custom_appbar.dart';

/**
 * 单选开关和复选框
 */
class SwitchAddSelectBox extends StatefulWidget {
  @override
  _SwitchAddSelectBoxState createState() => _SwitchAddSelectBoxState();
}

class _SwitchAddSelectBoxState extends State<SwitchAddSelectBox> {
  bool _switchSelect = false;
  bool? _boxSelect = false;
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: '单选开关和复选框',
          context: context,
        ),
        body: Column(
          children: [
            Switch(
                value: _switchSelect,
                onChanged: (value){
                  setState(() {
                    _switchSelect = value;
                  });
                },
            ),
            Checkbox(
                activeColor: Colors.red,//选中时的颜色
                value: _boxSelect,//当前选中状态
                onChanged: (value){//状态变化
                  setState(() {
                    _boxSelect = value;
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}
