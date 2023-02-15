import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 动画
 */
class AnimationMain extends StatefulWidget {
  @override
  _AnimationMainState createState() => _AnimationMainState();
}

class _AnimationMainState extends State<AnimationMain> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool _isforward = true;//是否是正向执行动画

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );

    //1）默认情况下，AnimationController对象值的范围是[0.0，1.0]。如果我们需要构建UI的动画值在不同的范围或不
    //同的数据类型，则可以使用Tween来添加映射以生成不同的范围或数据类型的值,下面Tween生成了0到200的数值,除了数值，也可以
    //是其他的数值，比如渐变色
    //2）要使用Tween对象，需要调用animate方法，传入一个控制器
    //3）addListener设置动画监听
    //4）默认是匀速线性的
    _animation = Tween(begin: 0.0, end: 200.0).animate(_animationController)
      ..addListener(() {
        //监听动画
        setState(() {

        });
      })
      ..addStatusListener((status) {
        //监听动画
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
        if(status == AnimationStatus.forward){
          print("正向动画");
        }else if(status == AnimationStatus.reverse){
          print("反向动画");
        }else if(status == AnimationStatus.dismissed){
          print("动画在起始点停止");
        }else if(status == AnimationStatus.completed){
          print("动画在终点停止");
        }
      });

    //定一个Curve，来实现一个类似于弹簧效果的动画过程
    // animation = CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
    // _animation = Tween(begin: 0.0,end: 200.0).animate(_animation)
    //   ..addListener(() {
    //     setState(() {
    //
    //     });
    //   });
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
                    child: Text("执行${_isforward?"正向":"反向"}动画")
                ),
                Image.asset("images/main_page_banner1.jpeg",
                width: _animation.value,height: _animation.value,)
              ],
            )
          ],
        ),
      ),
    );
  }

  void startAnimation(){
    if(_isforward){
      //启动动画，正向执行
      _animationController.forward();
    }else{
      //启动动画，反向执行
      _animationController.reverse();
    }
    _isforward = !_isforward;
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源，放置内存泄漏
    _animationController.dispose();
    super.dispose();
  }
}
