
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * Notification
 * 1)通知（Notification）是Flutter中一个重要的机制，在widget树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递，
 * 所有父节点都可以通过NotificationListener来监听通知。Flutter中将这种由子向父的传递通知的机制称为通知冒
 * 泡（Notification Bubbling）。通知冒泡和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行。
   注意：通知冒泡和Web开发中浏览器事件冒泡原理是相似的，都是事件从出发源逐层向上传递，我们可以在上层节点任意位置来监
   听通知/事件，也可以终止冒泡过程，终止冒泡后，通知将不会再向上传递。
   2)Flutter的UI框架实现中，除了在可滚动组件在滚动过程中会发出ScrollNotification之外，还有一些其它的通知，
    如SizeChangedLayoutNotification、KeepAliveNotification 、LayoutChangedNotification等，Flutter正是通过
    这种通知机制来使父元素可以在一些特定时机来做一些事情。
 */
class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  String? _scrollState;
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        //Flutter中很多地方使用了通知，如Scrollable 组件，它在滑动时就会分发滚动
        //通知（ScrollNotification），而 Scrollbar 正是通过监听 ScrollNotification 来确定滚动条位置的。
        body: Column(
          children: [
            Text(_scrollState??"监听ListView滚动状态"),
            NotificationListener(
              onNotification: (notification) {
                switch (notification.runtimeType) {
                  case ScrollStartNotification:
                    print("开始滚动");
                    setState(() {
                      _scrollState = "开始滚动";
                    });
                    break;
                  case ScrollUpdateNotification:
                    print("正在滚动");
                    setState(() {
                      _scrollState = "正在滚动";
                    });
                    break;
                  case ScrollEndNotification:
                    print("滚动停止");
                    setState(() {
                      _scrollState = "滚动停止";
                    });
                    break;
                  case OverscrollNotification:
                    print("滚动到边界");
                    break;
                }
                //它的返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；
                //当返回值为false 时继续向上冒泡通知。
                return false;
              },
              child: Expanded(
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index){
                      return Text("$index");
                    }
                ),
              )
            ),
          ],
        ),
        appBar:CustomAppbar(
          title: 'Notification',
          context: context,
        ),
      ),
    );
  }
}
