import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';

import '../view/custom_materialapp.dart';

/**
 * 可滚动组件
 * 1）Flutter 有两种布局模型
 * 基于 RenderBox 的盒模型布局。
    基于 Sliver ( RenderSliver ) 按需加载列表布局。
    2）基于Sliver的布局组件。

    通常可滚动组件的子组件可能会非常多、占用的总高度也会非常大；如果要一次性将子组件全部构建出将会非常昂贵！为此，Flutter中提
    出一个Sliver（中文为“薄片”的意思）概念，Sliver 可以包含一个或多个子组件。Sliver 的主要作用是配合：加载子组件并确定每
    一个子组件的布局和绘制信息，如果 Sliver 可以包含多个子组件时，通常会实现按需加载模型。

    只有当 Sliver 出现在视口中时才会去构建它，这种模型也称为“基于Sliver的列表按需加载模型”。可滚动组件中有很多都支持基
    于Sliver的按需加载模型，如ListView、GridView，但是也有不支持该模型的，如SingleChildScrollView。
    3）Flutter 中的可滚动主要由三个角色组成：Scrollable、Viewport 和 Sliver：

    Scrollable ：用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建 Viewport 。
    Viewport：显示的视窗，即列表的可视区域；
    Sliver：视窗里显示的元素。
    4）具体布局过程：

    Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport 。
    Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver。
    Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 类型的对象）。
 */
class ScrollWidget extends StatefulWidget {
  @override
  _ScrollWidgetState createState() => _ScrollWidgetState();
}

var list = [
  "1)Scrollbar是一个Material风格的滚动指示器（滚动条），如果要给可滚动组件添加滚动条，只需将Scrollbar作为可滚动组件的任意一个父级组件即可",
"2)SingleChildScrollCiew",
"ListView",
"ScrollController控制器和NotificationListener滚动监听器",
  "AnimatedList","GridView","PageView","TabBarView","CustomScrollViewAddSlivers"];
var pushNamedList = [
  "scrollbar_widget","singlechildscrollview","listview_widget","scrollcontroller_widget","animatedlist",
  "gridview","pageview","tabbarview","customscrollview_slivers"
];

class _ScrollWidgetState extends State<ScrollWidget> {
  Widget divider = Divider(
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: '可滚动组件',
          context: context,
        ),
        body: ListView.separated(
          itemCount: list.length,
          //列表项构造器
          itemBuilder: (BuildContext buildContext, int index) {
            return ListTile(
                title: GestureDetector(
              child: Text(list[index]),
              onTap: () => Navigator.pushNamed(context, pushNamedList[index]),
            ));
          },
          //分割器构造器
          separatorBuilder: (BuildContext context, int index) {
            return divider;
          },
        ),
      ),
    );
  }
}
