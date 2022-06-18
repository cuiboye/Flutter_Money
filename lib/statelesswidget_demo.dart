import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

/**
 * StatelessWidget组件的使用，常用的包含Text，Icon，CloseButton，BackButton，Chip，Divider，Card，AlertDialog
 * 1）Container widget 可以用来创建一个可见的矩形元素。 Container 可以使用 BoxDecoration 来进行
 * 装饰，如背景，边框，或阴影等。 Container 还可以设置外边距、内边距和尺寸的约束条件等。另外，Container可以使
 * 用矩阵在三维空间进行转换。
 */
class StatelessWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        title: "StatelessWidget的使用",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("StatelessWidget组件的使用"),
            leading: GestureDetector(
              //leading是AppBar组件的action功能，GestureDetector是手势组件
              onTap: () => Navigator.pop(context),
              //onTap：点击操作   Navigator.pop(context)为销毁当前页面
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: const ContentWiget(),
        ));
  }
}

class ContentWiget extends StatelessWidget {
  const ContentWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(fontSize: 20, color: ColorUtil.color("#ffffff"));
    return SingleChildScrollView(
      child: Container(
        // color: Colors.red,//背景颜色，color和decoration不能同时使用，否则会报错
        height: 700,
        //高度
        width: 500,
        //宽度
        margin: const EdgeInsets.all(20.0),
        //margin设置与父容器的距离
        padding: const EdgeInsets.all(20.0),
        //padding设置与容器内子View的距离
        decoration: BoxDecoration(//装饰器，decoration需要和BoxDecoration一起使用
          //boxShadow阴影，需要用到BoxShadow，BoxShadow通常和decoration一起使用
            boxShadow: const [BoxShadow(color: Colors.orange, blurRadius: 8.0)],
            color: Colors.blue, //背景颜色
            borderRadius: BorderRadius.circular(10), //圆角
            border: const Border(
              //边框,Border一般和BorderSide一起使用
                right: BorderSide(color: Colors.red, width: 1.0),
                left: BorderSide(color: Colors.red, width: 1.0),
                top: BorderSide(color: Colors.red, width: 1.0),
                bottom: BorderSide(color: Colors.red, width: 1.0))),
        child: Column(
          // Text，Icon，CloseButton，BackButton，Chip，Divider，Card，AlertDialog
          children: [
            Text("我是一个Text", style: textStyle),
            Icon(Icons.arrow_back, size: 40),
            CloseButton(onPressed: () => _closeButtonOnPress() //点击事件
            ),
            BackButton(
              onPressed: () => _backButtonOnPress(),
            ),
            const Chip(
              //更加详情的可以参考下文档
                avatar: Icon(Icons.android),
                label: Text("右侧的文本")),
            Divider(
              //线，缺点是不能设置高度
                height: 10, //容器高度，不是线的高度,
                indent: 10,
                endIndent: 10, //距离右侧的距离
                color: ColorUtil.color("#ff0000")),
            Card(//带有圆角，阴影，边框等效果的卡片
              //卡片的背景颜色
              color: Colors.orange,
              //设置阴影
              elevation: 5.0,
              shape: RoundedRectangleBorder(//形状
                //设置卡片的角度，这里设置为0.0为直角
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              margin: EdgeInsets.all(10),
              //设置上下左右的margin值
              child: Container(
                child: Text('I am Card', style: textStyle),
                margin: const EdgeInsets.only(left:20,top:10,right:20,bottom: 10),
              ),
            ),
            AlertDialog(
              title: Text("标题"),
              content: Text("我是内容"),
            )
          ],
        ),
      )
    );
  }

  _closeButtonOnPress() {
    print("_closeButtonOnPress");
  }

  _backButtonOnPress() {
    print("_backButtonOnPress");
  }
}
