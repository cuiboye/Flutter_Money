import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/layout_log_print.dart';
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 1)对齐与相对定位（Align）
 * Align比Stack,Position简单，可以实现简单的定位
 * 参数：
 * alignment：表示子组件在父组件中的起始位置。
 * 2)FractionalOffset 可以了解下
 * 3）Center
 * Center继承自Align，可以让子View居中
 */
class AlianWidget extends StatefulWidget {
  @override
  _AlianWidgetState createState() => _AlianWidgetState();
}

class _AlianWidgetState extends State<AlianWidget> {
  @override
  Widget build(BuildContext context) {

    return CustomMaterialApp(
        home: Scaffold(
      appBar: CustomAppbar(
        title: '对齐与相对定位（Align）',
        context: context,
      ),
      body:ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("Align底部中间"),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text("Center"),
              ),
            ),
          ],
        )
      )
    ));
  }

}
