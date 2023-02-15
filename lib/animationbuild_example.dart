import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * AnimatedBuild
 * 1）用AnimatedWidget 可以从动画中分离出 widget，而动画的渲染过程（即设置宽高）仍然在AnimatedWidget 中，假设如
 * 果我们再添加一个 widget 透明度变化的动画，那么我们需要再实现一个AnimatedWidget，这样不是很优雅，如果我们能
 * 把渲染过程也抽象出来，那就会好很多，而AnimatedBuilder正是将渲染逻辑分离出来,
 * 2)使用AnimatedBuild的好处
 * ---不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。
   ---更好的性能：因为动画每一帧需要构建的 widget 的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
   ---通过AnimatedBuilder可以封装常见的过渡效果来复用动画。下面我们通过封装一个
 */
class AnimatedBuilderExample extends StatefulWidget {
  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample> with SingleTickerProviderStateMixin{
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
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "AnimationBuild的使用",),
          body:Column(
            children: [
              ElevatedButton(
                  onPressed: ()=>startAnimation(),
                  child: Text("执行动画")
              ),
              Expanded(child: AnimatedBuilder(
                animation: _animation,
                child: Text("Hello"),
                builder: (BuildContext ctx, child) {
                  return Center(
                    child: Container(
                      color: Colors.red,
                      height: _animation.value,
                      width: _animation.value,
                      child: child,
                    ),
                  );
                },
              ))
            ],
          )
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
