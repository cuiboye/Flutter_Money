import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * AnimatedWidget简化动画
 * 通过addListener()和setState() 来更新UI这一步其实是通用的，如果每个动画中都加这么一句是比较繁琐的。
 * AnimatedWidget类封装了调用setState()的细节，并允许我们将 widget 分离出来
 */
class AnimatedWidgetExample extends StatefulWidget {
  @override
  _AnimationMainState createState() => _AnimationMainState();
}

class _AnimationMainState extends State<AnimatedWidgetExample> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );
    _animation = Tween(begin: 0.0,end: 200.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "动画",),
        body: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: ()=>startAnimation(),
                    child: Text("执行动画")
                ),
                AnimatedImage(animation: _animation,)
              ],
            )
          ],
        ),
      ),
    );
  }

  void startAnimation(){
    _animationController.forward();
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源，放置内存泄漏
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget{
  const AnimatedImage({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final _animation = listenable as Animation<double>;
    return Center(
      child: Image.asset("images/main_page_banner1.jpeg",
        width: _animation.value,height: _animation.value,)
    );
  }
}