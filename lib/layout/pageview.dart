import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:flutter_money/view/keep_alive_wrapper.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * PageView
 * 1)如果要实现页面切换和 Tab 布局，我们可以使用 PageView 组件。需要注意，PageView 是一个非常重要的组件，因为在移动端开发中很常用，比如
 * 大多数 App 都包含 Tab 换页效果、图片轮动以及抖音上下滑页切换视频功能等等，这些都可以通过 PageView 轻松实现。
 * 2)遇到的问题：
 * The ParentDataWidget Expanded(flex: 1) wants to apply ParentData of type FlexParentData to a RenderObject,
 * which has been set up to accept ParentData of incompatible type ParentData：
 * 这个错误提示说明Expanded、Flexible只在Row、Column等组件内，不在其他组件内使用，也就是说Expanded的直接父View只能是Row和Column
 */
class PageViewLayout extends StatefulWidget {
  @override
  _PageViewLayoutState createState() => _PageViewLayoutState();
}

class _PageViewLayoutState extends State<PageViewLayout> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(int i=0;i<6;i++){
      children.add(_pageviewItem("$i"));
    }

    var children2 = <Widget>[];
    for(int i=0;i<6;i++){
      children2.add( Page( text: '$i'));
    }

    return CustomMaterialApp(
        home: Scaffold(
      appBar: CustomAppbar(
        title: 'PageView',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("遇到的问题：PageView放在Column中不显示，需要使用Expanded包裹",style: TextStyle(color: Colors.red),),
            Text("1)PageView默认是横向滚动"),
            Container(
              decoration: BoxDecoration(color: Colors.red),
              height: 200,
              child: PageView(
                children: children,
              )
            ),
            Text("2)PageView纵向滚动"),
            Container(
                decoration: BoxDecoration(color: Colors.red),
                height: 200,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  children: children,
                )
            ),
            Text("3)PageView的缓存"),
            Text("每次翻页都会触发PageView中Widget的build方法,对于想要保存页面的状态，这个是有问题的，所以需要将PageView中的item进行缓存,"
                "可以通过KeepAliveWrapper来缓存页面"),
            Container(
                decoration: BoxDecoration(color: Colors.red),
                height: 200,
                child: PageView(
                  children: children2,
                )
            ),
          ],
        ),
      )
    ));
  }

  _pageviewItem(String text){
    return Center(child: Text("$text", textScaleFactor: 5));
  }
}

// Tab 页面
class Page extends StatefulWidget {
  const Page({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    //每次翻页都会触发PageView中Widget的build方法
    //对于想要保存页面的状态，这个是有问题的，所以需要将PageView中的item进行混存
    print("build ${widget.text}");
    return KeepAliveWrapper(
      keepAlive: true,
      child: Center(child: Text("${widget.text}", textScaleFactor: 5))
    );
  }
}