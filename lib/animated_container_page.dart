import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 隐式动画如AnimatedContainer的使用,这些Widget会自动以动画方式对其属性进行更改。当使用新的属性值调用setState重
 * 建小部件时，Widget会将动画从先前值改变到新值。
 */
class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimationMainState createState() => _AnimationMainState();
}
class _AnimationMainState extends State<AnimatedContainerPage>
    with SingleTickerProviderStateMixin {
  bool bigger = false;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "动画",
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: changeWidth, child: const Text('开始动画')),
            AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: bigger ? 50 : 100,
                height: bigger ? 50 : 100,
                color: Colors.black,
                curve: Curves.easeInOutQuint,//曲线效果
                child: const Text('AnimatedContainer'))
          ],
        ),
      ),
    );
  }

  void changeWidth() {
    bigger = !bigger;
    setState(() {});
  }
}
