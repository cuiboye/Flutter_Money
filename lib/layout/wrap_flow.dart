import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 流式布局
 * 如果子 widget 超出屏幕范围，则会报溢出错误。
 * Row默认只有一行，如果超出屏幕不会折行。我们把超出屏幕显示范围会自动折行的布局称为流式布局。Flutter中通过Wrap和Flow来支持流式布局
 * Wrap的很多属性在Row（包括Flex和Column）中也有，如direction、crossAxisAlignment、textDirection、verticalDirection等，
 * 这些参数意义是相同的。
 * 1）Wrap
 * Wrap特有的几个属性：
 * spacing：主轴方向子widget的间距
 * runSpacing：纵轴方向的间距
   runAlignment：纵轴方向的对齐方式
 *
 * 2）Flow
 * 很少使用，需要自定义
 */
class WrapAddFlow extends StatefulWidget {
  @override
  _WrapAddFlowState createState() => _WrapAddFlowState();
}

class _WrapAddFlowState extends State<WrapAddFlow> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
        home: Scaffold(
        appBar:CustomAppbar(
          title: '流式布局',
          context: context,
        ),
      body: Column(
        //注意：crossAxisAlignment这个属性在Column中在横轴方向默认是居中的，所以如果不设置这个属性为start，默认是水平居中对齐的
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("1)Row中不能折行"),
          Row(
            children: [
              Text("Row默认只有一行，如果超出屏幕不会折行。Row默认只有一行，如果超出屏幕不会折行。"),
            ],
          ),
          Text("2)Wrap可以折行"),
          Wrap(
              spacing: 20.0,//主轴方向子Widget之间的间距
              runSpacing: 10.0,//纵轴方向子Widget之间的间距
              alignment: WrapAlignment.center,//延主轴方向居中
              children: [
                Text("Wrap可以换行Wrap可以换行"),
                Text("可以换行Wrap可以换行"),
                Text("可以换行Wrap可以换行"),
              ],
            ),
        ],
      ),
    ));
  }
}
