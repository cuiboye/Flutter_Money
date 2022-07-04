import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 线性布局
 * 1）Row和Column都继承自Flex
 * 2）对于线性布局，有主轴和纵轴之分，如果布局是沿水平方向，那么主轴就是指水平方向，而纵轴即垂直方向；如果布局沿垂直方向，
 * 那么主轴就是指垂直方向，而纵轴就是水平方向。在线性布局中，有两个定义对齐方式的枚举类MainAxisAlignment和
 * CrossAxisAlignment，分别代表主轴对齐和纵轴对齐。
 */
class LinearLayout extends StatefulWidget {
  @override
  _LinearLayoutState createState() => _LinearLayoutState();
}

class _LinearLayoutState extends State<LinearLayout> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar:CustomAppbar(
            title: '线性布局',
            context: context,
          ),
          body: Column(
            children: [
              setRowMainAxisAlignment(),//测试Row的mainAxisAlignment属性
              setRowVerticalDirectionAddCrossAxisAlignment(),//测试crossAxisAlignment和verticalDirection

              Text("2.Column和Row类似"),

            ],
          )),
    );
  }

  Widget setRowVerticalDirectionAddCrossAxisAlignment(){
    return Column(
      children: [
        Text("1.Row-crossAxisAlignment和verticalDirection属性"),
        Container(
          height: 200,
          decoration: BoxDecoration(color: Colors.blue),
          child: Row(
            //crossAxisAlignment：表示子组件在纵轴方向的对齐方式，Row的高度等于子组件中最高的子元素高度，它的取值
            //和MainAxisAlignment一样(包含start、end、 center三个值)，不同的是crossAxisAlignment的参考系
            //是verticalDirection，即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指
            //顶部对齐，verticalDirection值为VerticalDirection.up时，crossAxisAlignment.start指底部对齐；
            //而crossAxisAlignment.end和crossAxisAlignment.start正好相反；
            crossAxisAlignment: CrossAxisAlignment.start,
            //verticalDirection：表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down，表示从上到下。
            verticalDirection: VerticalDirection.up,
            children: [
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        )
      ],
    );
  }

  Widget setRowMainAxisAlignment(){
    return Column(
      children: [
        Text("1.Row-mainAxisAlignment属性"),
        Text("1)start 默认值"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            //表示水平方向子组件的布局顺序(是从左往右还是从右往左)，默认为系统当前Locale环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)。
            textDirection: TextDirection.ltr,
            //1)mainAxisSize：表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，表示尽可能多的占用水平方向的空间，此时无论子 widgets 实
            //际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度；而MainAxisSize.min表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则
            //Row的实际宽度等于所有子组件占用的的水平空间；
            //2)如果这里设置了MainAxisSize.min，textDirection属性就不会生效了
            mainAxisSize: MainAxisSize.max,
            //1)mainAxisAlignment：表示子组件在Row所占用的水平空间内对齐方式，如果mainAxisSize值为MainAxisSize.min，则此属性无意义，因为子组件的
            //宽度等于Row的宽度。只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义
            //  MainAxisAlignment的属性值：
            //  start: 默认值，从开始位置排列
            //  end: 排列在尾部
            //  center:设置children中所有的child居中
            //  spaceBetween: 平分权重，两端的分别挨着左右两侧，中间的也分别挨着临界
            //  spaceAround:平分权重，子View分别居中
            //  spaceEvenly:将空闲空间均匀地放在子节点之间以及第一个和最后一个子节点之前和之后。
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Hello"),
            ],
          ),
        ),
        Text("2)center"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello"),
            ],
          ),
        ),
        Text("3)end"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Hello"),
            ],
          ),
        ),
        Text("4)end"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        ),
        Text("4)spaceBetween"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        ),
        Text("4)spaceBetween"),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        )
      ],
    );
  }
}
