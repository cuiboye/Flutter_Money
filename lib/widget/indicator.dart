import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

import '../view/custom_appbar.dart';

/**
 * 进度指示器
 * 1）LinearProgressIndicator
 * value：value表示当前的进度，取值范围为[0,1]；如果value为null时则指示器会执行一个循环动画（模糊进度）；当value不为null时，指
 * 示器为一个具体进度的进度条。
 * backgroundColor：指示器的背景色。
 * valueColor: 指示器的进度条颜色；值得注意的是，该值类型是Animation<Color>，这允许我们对进度条的颜色也可以指定动画。如果我们
 * 不需要对进度条颜色执行动画，换言之，我们想对进度条应用一种固定的颜色，此时我们可以通过AlwaysStoppedAnimation来指定。
 * 2）CircularProgressIndicator
 *   value: 0.4,//当前进度，取值[0,1],和LinearProgressIndicator一样，value为null或者不设置，进度条一直循环
 *   strokeWidth: 10,//进度条宽度
 *   backgroundColor: Colors.grey[200],//进度条背景色
 *   valueColor: AlwaysStoppedAnimation(Colors.blue),//进度条颜色
 * 3）自定义进度条
 * 通过ConstrainedBox、SizedBox可以自定义进度条
 */
class IndicatorWidget extends StatefulWidget {
  @override
  _IndicatorWidgetState createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget>
    with SingleTickerProviderStateMixin {
  double _num = 0.1;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: '进度指示器',
          context: context,
        ),
        body: Column(
          children: [
            Text("1.线形进度条 LinearProgressIndicator"),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: LinearProgressIndicator(
                //指示器的背景颜色
                backgroundColor: Colors.grey[200],
                //指示器的颜色，需要使用 AlwaysStoppedAnimation
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: LinearProgressIndicator(
                value: _num, //取值范围[0,1]，value没有设置或者为null，进度条将会一直循环
                //指示器的背景颜色
                backgroundColor: Colors.grey[200],
                //指示器的颜色，需要使用 AlwaysStoppedAnimation
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            ElevatedButton(
                onPressed: () => setIndicator(), child: Text("增加进度")),
            Text("2.圆形进度条 LinearProgressIndicator"),
            CircularProgressIndicator(
              //不断循环的进度条
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            CircularProgressIndicator(
              //不断循环的进度条
              value: 0.4,
              //当前进度，取值[0,1],和LinearProgressIndicator一样，value为null或者不设置，进度条一直循环
              strokeWidth: 10,
              //进度条宽度
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Text("3.自定义进度条"),
            SizedBox(
              height: 2,
              child: LinearProgressIndicator(
                value: 0.4,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                value: 0.4,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            const Text("4.进度条颜色渐变动画"),
            const Text("可以通过CustomPainter Widget 来自定义绘制逻辑，实际上LinearProgressIndicator和CircularProgressIndicator也正是通过CustomPainter来实现外观绘制的。"),
            const Text("flutter_spinkit (opens new window)包提供了多种风格的模糊进度指示器 https://pub.flutter-io.cn/packages/flutter_spinkit"),


          ],
        ),
      ),
    );
  }

  double setIndicator() {
    setState(() {
      _num += 0.1;
    });
    return _num;
  }
}
