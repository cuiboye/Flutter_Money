import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/widget/share_data_widget.dart';

import 'inherited_widget_example.dart';

/**
 * InheritedWidget状态共享
 * 1)InheritedWidget是 Flutter 中非常重要的一个功能型组件，它提供了一种在 widget 树中从上到下共享数据的方式，比如
 * 我们在应用的根 widget 中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget 中来获取该共享的数据！这个
 * 特性在一些需要在整个 widget 树中共享数据的场景中非常方便！如Flutter SDK中正是通过 InheritedWidget 来共享应用主
 * 题（Theme）和 Locale (当前语言环境)信息的。
 * 2)InheritedWidget的在 widget 树中数据传递方向是从上到下的，这和通知Notification的传递方向正好相反。
 * InheritedWidget中的updateShouldNotify方法决定当数据发生变化时，是否通知子树中依赖该数据的Widget重新build。
 * 该方法如果返回true，则会回调didChangeDependencies方法。
 * 3)应该在didChangeDependencies()中做什么？
    一般来说，子 widget 很少会重写此方法，因为在依赖改变后 Flutter 框架也都会调用build()方法重新构建组件树。
    但是，如果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是在此方法中执行，这样可以避免
    每次build()都执行这些昂贵操作。
   4）如果我们只想更新子树中依赖了ShareDataWidget的组件，而不想重新构建整个页面，解决的办法是使用缓存。
 */
class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({super.key});

  @override
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print("InheritedWidgetTestRoute-build");
    return  Center(
      child: ShareDataWidget( //使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TestWidget(),//子widget中依赖ShareDataWidget
            ),
            ElevatedButton(
              child: Text("Increment"),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}