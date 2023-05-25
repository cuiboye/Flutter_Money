import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * GridView
 * 1)我们可以看到，GridView和ListView的大多数参数都是相同的，它们的含义也都相同的，我们唯一需要关注的是gridDelegate参数，
 * 类型是SliverGridDelegate，它的作用是控制GridView子组件如何排列(layout)。

    SliverGridDelegate是一个抽象类，定义了GridView Layout相关接口，子类需要通过实现它们来实现具体的布局算法。Flutter中提
    供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount和
    SliverGridDelegateWithMaxCrossAxisExtent，我们可以直接使用，

    SliverGridDelegateWithFixedCrossAxisCount参数:
    crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
    mainAxisSpacing：主轴方向的间距。
    crossAxisSpacing：横轴方向子元素的间距。
    childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数
    值就可以确定子元素在主轴的长度。
    可以发现，子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的。注意，这里的子元素指的是子组件的最大显
    示空间，注意确保子组件的实际大小不要超出子元素的空间。
   2)GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，我们通过它可以快速的创建横轴固定数量
    子元素的GridView
   3)GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent，我们通过它可以快速的创建横轴子元
    素为固定最大长度的的GridView
   4）GridView.builder
    上面我们介绍的GridView都需要一个widget数组作为其子元素，这些方式都会提前将所有子widget都构建好，所以只适用于子widget数
    量比较少时，当子widget比较多时，我们可以通过GridView.builder来动态创建子widget。

 */
class GridViewLayout extends StatefulWidget {
  @override
  _GridViewLayoutState createState() => _GridViewLayoutState();
}

class _GridViewLayoutState extends State<GridViewLayout> {
  final globalKey = GlobalKey<AnimatedListState>();
  int counter = 5;
  var data = <String>[];
  var _icons = <IconData>[]; //保存Icon数据

  @override
  void initState() {
    for(var i=0;i<counter;i++){
      data.add("${i+1}");
    }

    // 初始化数据
    _retrieveIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
        appBar:CustomAppbar(
          title: 'GridView',
          context: context,
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("1)flutter Vertical viewport was given unbounded height错误解决：Column里面嵌套Column、ListView、GridView,EasyRefresh等空间"
              "具有无限延展性等控件，每一层都需要用Expanded包裹，漏掉一层都不行。"),
          Text("2）通过SliverGridDelegateWithFixedCrossAxisCount来创建GridView"),

          Expanded(
              child: GridView(
                  scrollDirection:Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,//每一行3个
                    childAspectRatio: 1.0//宽高比为1
                ),
                children: [

                  _item(Icons.ac_unit),
                  _item(Icons.airport_shuttle),
                  _item(Icons.all_inclusive),
                  _item(Icons.beach_access),
                  _item(Icons.cake),
                  _item(Icons.free_breakfast)
                ],
              )
          ),
          Text("3）通过GridView.count来创建GridView"),

          Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  children: <Widget>[
                    _item(Icons.airport_shuttle),
                    _item(Icons.all_inclusive),
                    _item(Icons.beach_access),
                    _item(Icons.cake),
                    _item(Icons.free_breakfast)
                  ],
                ),
            ),
          Text("4）通过GridView.extent来创建GridView"),
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 1,//宽高比为1
              children: <Widget>[
                _item(Icons.airport_shuttle),
                _item(Icons.all_inclusive),
                _item(Icons.beach_access),
                _item(Icons.cake),
                _item(Icons.free_breakfast)
              ],
            ),
          ),
          Text("4）上面我们介绍的GridView都需要一个widget数组作为其子元素，这些方式都会提前将所有子widget都构建好，所以只适用于子widget数量比较少时，当子widget比较多时，我们可以通过GridView.builder来动态创建子widget。"),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //每行三列
                    childAspectRatio: 1.0, //显示区域宽高相等
                  ),
                  itemCount: _icons.length,
                  itemBuilder: (context, index) {
                    //如果显示到最后一个并且Icon总数小于200时继续获取数据
                    if (index == _icons.length - 1 && _icons.length < 200) {
                      _retrieveIcons();
                    }
                    return Icon(_icons[index]);
                  })
          )
        ],
      ),
    ));
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }

  Widget _item(IconData? iconData){
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      margin: EdgeInsets.all(2),
      child: Icon(iconData),
    );
  }
}
