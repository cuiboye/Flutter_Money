import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/layout_log_print.dart';
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 容器类组件
 * 1）Padding
 * Padding可以给其子节点添加填充（留白），和边距效果类似。
 * 参数：
 * padding：我们一般都使用EdgeInsets类，它是EdgeInsetsGeometry的一个子类，定义了一些设置填充的便捷方法。
 * 2）DecoratedBox
 * DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
 * 参数：
 * position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值：
 * background：在子组件之后绘制，即背景装饰。
 * foreground：在子组件之上绘制，即前景。
 * decoration：我们通常会直接使用BoxDecoration类，它是一个Decoration的子类，实现了常用的装饰元素的绘制。
 * BoxDecoration({
    Color color, //颜色
    DecorationImage image,//图片
    BoxBorder border, //边框
    BorderRadiusGeometry borderRadius, //圆角
    List<BoxShadow> boxShadow, //阴影,可以指定多个
    Gradient gradient, //渐变
    BlendMode backgroundBlendMode, //背景混合模式
    BoxShape shape = BoxShape.rectangle, //形状
    })
   3）变换 Transform
   Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作
   4)Container
    Container是一个组合类容器，它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组
    件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。
    Container({
      this.alignment,
      this.padding, //容器内补白，属于decoration的装饰范围
      Color color, // 背景色
      Decoration decoration, // 背景装饰
      Decoration foregroundDecoration, //前景装饰
      double width,//容器的宽度
      double height, //容器的高度
      BoxConstraints constraints, //容器大小的限制条件
      this.margin,//容器外补白，不属于decoration的装饰范围
      this.transform, //变换
      this.child,
        ...
    })
    容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；如果它们同时存在时，width、height优先。实际上Container内部会根据width、height来生成一个constraints。
    color和decoration是互斥的，如果同时设置它们则会报错！实际上，当指定color时，Container内会自动创建一个decoration。
  5)裁剪View Clip
 */
class ContainerWidget extends StatefulWidget {
  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
            appBar: CustomAppbar(
              title: '容器类组件',
              context: context,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1.Paddding,设置文字距离上下左右的距离"),
                Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Hello"),
                  ),
                ),
                Text(
                    "2.DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。"),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: DecoratedBox(
                    //position:可以设置前置背景和后置背景
                    position: DecorationPosition.background,
                    //我们通常会直接使用BoxDecoration类，它是一个Decoration的子类，实现了常用的装饰元素的绘制。
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange.shade700]), //背景渐变
                      boxShadow: [
                        //阴影
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0),
                      ],
                      borderRadius: BorderRadius.circular(3.0), //圆角
                    ),
                    child: SizedBox(
                      width: 80,
                      height: 30,
                      child: Center(
                        child: Text("Hello"),
                      ),
                    ),
                  ),
                ),
                Text(
                    "3.Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作"),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    child: Transform(
                        alignment: Alignment.topRight,
                        transform: Matrix4.skewY(0.3),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Hello"),
                          ),
                        )),
                  ),
                ),
                Text(
                    "4.Container是一个组合类容器，它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。"),
               Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(30),
                     decoration: BoxDecoration(color: Colors.red),
                     child: Text("容器内补白"),
                   ),
                   Spacer(),
                   Container(
                     decoration: BoxDecoration(color: Colors.blue),
                     child: Container(
                       margin: EdgeInsets.all(30),
                       decoration: BoxDecoration(color: Colors.red),
                       child: Text("容器内补白"),
                     ),
                   )

                 ],
               ),
                Text("5.裁剪 Clip"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1)通过ClipOval裁剪为圆形"),
                    ClipOval(//将View裁剪为圆形
                      child:Image.network(//加载网络图片
                          "https://img2.woyaogexing.com/2022/06/14/a6242dfe2ee9ccaa!400x400.jpg",
                          width: 50,
                          height: 50
                      ),
                    ),
                    Text("2)通过ClipRRect裁剪为圆角矩形"),
                    Padding(padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(//将View裁剪为圆形
                        borderRadius:BorderRadius.circular(5.0),
                        child:Image.network(//加载网络图片
                            "https://img2.woyaogexing.com/2022/06/14/a6242dfe2ee9ccaa!400x400.jpg",
                            width: 50,
                            height: 50
                        ),
                      ),
                    ),

                  ],
                )
              ],
            )));
  }
}
