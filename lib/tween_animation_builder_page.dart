
import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';

///使用 TweenAnimationBuilder 在 Flutter 中自定义隐式动画
///如果隐藏式动画的基础组件如AnimatedContainer不能满足需求的话，可以使用TweenAnimationBuilder
class TweenAnimationBuildPage extends StatefulWidget {
  const TweenAnimationBuildPage({super.key});

  @override
  State<TweenAnimationBuildPage> createState() => _TweenAnimationBuildPageState();
}

class _TweenAnimationBuildPageState extends State<TweenAnimationBuildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: 'TweenAnimationBuilder的使用',),
      body: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 45),
        duration: const Duration(seconds: 2),
        builder: (context, angle, child) {
          return Transform.rotate(
            angle: angle,//旋转45度角
            child: const Padding(padding: EdgeInsets.all(30),child: Text('HELLO'),),
          );
        },
      ),
    );
  }
}
