import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:flutter_money/view/keep_alive_wrapper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * TabBarView
 * 1)TabBarView 是 Material 组件库中提供了 Tab 布局组件，通常和 TabBar 配合使用。
 * TabBarView 封装了 PageView，它的构造方法很简单

    TabBarView({
    Key? key,
    required this.children, // tab 页
    this.controller, // TabController
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    })
    TabController 用于监听和控制 TabBarView 的页面切换，通常和 TabBar 联动。如果没有指定，则会在组件树中
    向上查找并使用最近的一个 DefaultTabController 。
    2）TabBar
    TabBar 为 TabBarView 的导航标题，
    TabBar 有很多配置参数，通过这些参数我们可以定义 TabBar 的样式，很多属性都是在配置 indicator 和 label。
    Label 是每个Tab 的文本，indicator 指 下划线。
    const TabBar({
    Key? key,
    required this.tabs, // 具体的 Tabs，需要我们创建
    this.controller,
    this.isScrollable = false, // 是否可以滑动
    this.padding,
    this.indicatorColor,// 指示器颜色，默认是高度为2的一条下划线
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,// 指示器高度
    this.indicatorPadding = EdgeInsets.zero, //指示器padding
    this.indicator, // 指示器
    this.indicatorSize, // 指示器长度，有两个可选值，一个tab的长度，一个是label长度
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.mouseCursor,
    this.onTap,
    ...
    })
    TabBar 通常位于 AppBar 的底部，它也可以接收一个 TabController ，如果需要和 TabBarView 联动， TabBar 和
    TabBarView 使用同一个 TabController 即可，注意，联动时 TabBar 和 TabBarView 的孩子数量需要一致。如果没有
    指定 controller，则会在组件树中向上查找并使用最近的一个 DefaultTabController 。另外我们需要创建需要的 tab 并
    通过 tabs 传给 TabBar， tab 可以是任何 Widget，不过Material 组件库中已经实现了一个 Tab 组件，我们一般都会直
    接使用它：
    const Tab({
    Key? key,
    this.text, //文本
    this.icon, // 图标
    this.iconMargin = const EdgeInsets.only(bottom: 10.0),
    this.height,
    this.child, // 自定义 widget
    })
    注意，text 和 child 是互斥的，不能同时制定。

    因为TabBarView 内部封装了 PageView，如果要缓存页面，可以使用KeepAliveWrapper
 */
class TabBarViewLayout extends StatefulWidget {
  @override
  _TabBarViewLayoutState createState() => _TabBarViewLayoutState();
}

class _TabBarViewLayoutState extends State<TabBarViewLayout> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    print("initState");
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView( //构建
        controller: _tabController,
        children: tabs.map((e) {
          return KeepAliveWrapper(//保持PageView的状态
            child: Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 5),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }
}
