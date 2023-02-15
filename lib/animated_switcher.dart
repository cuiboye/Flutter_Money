import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 动画切换组件
 * 1）AnimatedSwitcher 可以同时对其新、旧子元素添加显示、隐藏动画。也就是说在AnimatedSwitcher的子元素发生变化时，会
 * 对其旧元素和新元素做动画，AnimatedSwitcher 的定义：
    const AnimatedSwitcher({
    Key? key,
    this.child,
    required this.duration, // 新child显示动画时长
    this.reverseDuration,// 旧child隐藏的动画时长
    this.switchInCurve = Curves.linear, // 新child显示的动画曲线
    this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
    })
    2）当AnimatedSwitcher的 child 发生变化时（类型或 Key 不同），旧 child 会执行隐藏动画，新 child 会执行执行显示
    动画。究竟执行何种动画效果则由transitionBuilder参数决定，该参数接受一个AnimatedSwitcherTransitionBuilder类
    型的 builder，定义如下：

    typedef AnimatedSwitcherTransitionBuilder =
    Widget Function(Widget child, Animation<double> animation);
    该builder在AnimatedSwitcher的child切换时会分别对新、旧child绑定动画：

    对旧child，绑定的动画会反向执行（reverse）
    对新child，绑定的动画会正向指向（forward）
    这样一下，便实现了对新、旧child的动画绑定。AnimatedSwitcher的默认值是AnimatedSwitcher.defaultTransitionBuilder ：
 */
class AnimatedSwitcherExample extends StatefulWidget {
  @override
  _AnimatedSwitcherExampleState createState() =>
      _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context, title: "AnimatedSwitch动画切换使用",),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  //执行缩放动画
                  return ScaleTransition(scale: animation, child: child,);
                },
                child: Text("$_count",
                  key: ValueKey<int>(_count),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _count +=1;
                    });
                  },
                  child: Text("+1")
              )
            ],
          ),
        ),
      ),
    );
  }
}
