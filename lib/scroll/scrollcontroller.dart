import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';

import '../view/custom_materialapp.dart';

/**
 * ScrollController
 * 1)可以用ScrollController来控制可滚动组
 * 2）ScrollController常用的属性和方法：
    offset：可滚动组件当前的滚动位置。
    jumpTo(double offset)、animateTo(double offset,...)：这两个方法用于跳转到指定的位置，它们不同之处在于，后者在跳转时
    会执行一个动画，而前者不会。
  3）滚动监听
    ScrollController间接继承自Listenable，我们可以根据ScrollController来监听滚动事件，
  4)NotificationListener
    Flutter Widget树中子Widget可以通过发送通知（Notification）与父(包括祖先)Widget通信。父级组件可以通过NotificationListener组
    件来监听自己关注的通知，这种通信方式类似于Web开发中浏览器的事件冒泡，我们在Flutter中沿用“冒泡”这个术语，关于通知冒泡我们将在后面“事
    件处理与通知”一章中详细介绍。

    可滚动组件在滚动时会发送ScrollNotification类型的通知，ScrollBar正是通过监听滚动通知来实现的。通过NotificationListener监听
    滚动事件和通过ScrollController有两个主要的不同：

    通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。而ScrollController只能和具体的可滚动组件关联后
    才可以。
    收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只
    能获取当前滚动位置。

    在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：

    pixels：当前滚动位置。
    maxScrollExtent：最大可滚动长度。
    extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
    extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
    extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
    atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。
 */
class ScrollControllerWidget extends StatefulWidget {
  @override
  _ScrollControllerWidgetState createState() => _ScrollControllerWidgetState();
}

class _ScrollControllerWidgetState extends State<ScrollControllerWidget> {
   final ScrollController _scrollController = ScrollController();
   bool show = false;
   late int pos;

   String _progress = "%0";

   //在initState中添加监听器
   @override
   void initState() {
     super.initState();
     //监听滚动事件，打印滚动位置
     _scrollController.addListener(() {
       if (_scrollController.offset < 1000 && show) {
         setState(() {
           show = false;
         });
       } else if (_scrollController.offset >= 1000 && show == false) {
         setState(() {
           show = true;
         });
       }
     });
   }

   @override
   void dispose() {
     //为了避免内存泄露，需要调用_controller.dispose
     _scrollController.dispose();
     super.dispose();
   }


   @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if(_scrollController.offset<1000 && show){
        setState(() {
          show =false;
        });
      }else if(_scrollController.offset>1000 && !show){
        setState(() {
          show =true;
        });
      }

    });

    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: 'ScrollController',
          context: context,
        ),
        // body: ListView.builder(
        //     itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
        //     controller: _scrollController,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text("item $index",style: TextStyle(color: Colors.black),);
        //     }
        // ),
        // floatingActionButton: show? GestureDetector(
        //   child: Text("回到顶部"),
        //   onTap: (){
        //     //返回到顶部时执行动画
        //     _scrollController.animateTo(
        //       .0,
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.linear,
        //     );
        //   },
        // ):null,
     //    body: NotificationListener<ScrollNotification>(
     //    onNotification: (ScrollNotification notification) {
     // double progress = notification.metrics.pixels /
     // notification.metrics.maxScrollExtent;
     // //重新构建
     // setState(() {
     // _progress = "${(progress * 100).toInt()}%";
     // });
     // print("BottomEdge: ${notification.metrics.extentAfter == 0}");
     // return false;
     // //return true; //放开此行注释后，进度条将失效
     // },
        body: Scrollbar(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              double progress = notification.metrics.pixels /
                  notification.metrics.maxScrollExtent;
              //重新构建
              setState(() {
                _progress = "${(progress * 100).toInt()}%";
                print("进度：$_progress");
                print("当前滚动位置。：${notification.metrics.pixels}");
                print("最大可滚动长度。：${notification.metrics.maxScrollExtent}");
                print("滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。：${notification.metrics.extentBefore}");
                print("ViewPort内部长度；此示例中屏幕显示的列表部分的长度。：${notification.metrics.extentInside}");
                print("列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。：${notification.metrics.extentAfter}");
                print("是否滑到了可滚动组件的边界：${notification.metrics.atEdge}");

              });
              print("BottomEdge: ${notification.metrics.extentAfter == 0}");
              return false;
              //return true; //放开此行注释后，进度条将失效
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ListView.builder(
                  itemCount: 100,
                  itemExtent: 50.0,
                  itemBuilder: (context, index) => ListTile(title: Text("$index")),
                ),
                CircleAvatar(
                  //显示进度百分比
                  radius: 30.0,
                  backgroundColor: Colors.black54,
                  child: Text(_progress),
                )
              ],
            ),
          ),
        )


      ),
    );
  }
}
