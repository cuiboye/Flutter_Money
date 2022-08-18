import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 上拉刷新下拉加载
 * pull_to_refresh
 */
class PullRefreshMain extends StatefulWidget {
  @override
  _PullRefreshMainState createState() => _PullRefreshMainState();
}

class _PullRefreshMainState extends State<PullRefreshMain> with SingleTickerProviderStateMixin{
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //帧动画
  late Animation<double> animation;
  late AnimationController controller;
  //素材列表
  List<String> images=[
    "images/ic_progressbar_0.png",
    "images/ic_progressbar_1.png",
    "images/ic_progressbar_2.png",
    "images/ic_progressbar_3.png",
    "images/ic_progressbar_4.png",
    "images/ic_progressbar_5.png"
    "images/ic_progressbar_6.png"
    "images/ic_progressbar_7.png"
    "images/ic_progressbar_8.png"
  ];

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    controller=AnimationController(vsync: this,duration:Duration(milliseconds: 700) );
    animation=Tween<double>(begin: 0,end: images.length.toDouble()).animate(controller);
    controller.forward();
    animation.addStatusListener((status) {
      if (status==AnimationStatus.completed) {controller.forward(from: 0);} //循环执行动画
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "下拉刷新上拉加载",),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          // header: WaterDropHeader(),
          header: CustomHeader(builder: (context, mode) {
            return Center(
              //可以根据状态来执行不同的展示
                // child: Text(mode == RefreshStatus.idle
                //     ? "下拉刷新"
                //     : mode == RefreshStatus.refreshing
                //     ? "刷新中..."
                //     : mode == RefreshStatus.canRefresh
                //     ? "可以松手了!"
                //     : mode == RefreshStatus.completed
                //     ? "刷新成功!"
                //     : "刷新失败")
            // child: Image.asset(images[animation.value.toInt()]),
              //帧动画可以考虑使用gif图，上面的 animation.value.toInt() 有一些问题
            child: Image.asset("images/zoulu.gif",width: 50,height: 50,),
            );
          }, onOffsetChange: (offset) {
            //do some ani
          }),
          footer: CustomFooter(
            builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手,加载更多!");
              } else {
                body = Text("没有更多数据了!");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(//ListView一样要作为SmartRefresher的child，不能与其分开
            itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
            itemExtent: 100.0,
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
