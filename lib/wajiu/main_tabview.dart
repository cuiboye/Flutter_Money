import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainTabViewPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<MainTabViewPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true; //保持页面状态

  late TabController _tabController;
  int _select = 0; //选中tab小标
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: list.length);
    _tabController.addListener(() {
      setState(() {
        _select = _tabController.index;
        print("$_select");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            height: 40,
            child: TabBar(
                indicatorColor: Colors.transparent,
                //指示器设置为透明色
                indicatorPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                isScrollable: true,
                //设置可滑动
                controller: _tabController,
                onTap: (value) {
                  setState(() {
                    _select = value;
                  });
                },
                //tabs tab标签
                tabs: tabs()),
          ),
          SizedBox(
            height: 90,
            child: TabBarView(
              controller: _tabController,
              children: _tabBarViews(),
            ),
          )
          // Expanded(child: TabBarView(
          //   controller: _tabController,
          //   children: _tabBarViews(),
          // ),)
          //   INTRINSICHEIGHT
        ],
      )),
    );
  }

  //tab标题
  List<String> list = [
    "直播",
    "推荐",
    "热门",
    "追番",
    "影视",
    "其他",
    "其他",
    "其他",
    "其他",
    "其他",
    "其他",
  ];

  List<Widget> tabs() {
    List<Widget> listTab = [];
    for (int i = 0; i < list.length; i++) {
      listTab.add(
        Tab(
            child: Container(
          height: 44,
          child: Stack(
            children: [
              Align(
                child: Text(
                  "${list[i]}",
                  style: TextStyle(
                      color: _select == i
                          ? ColorConstant.systemColor
                          : Colors.black38),
                ),
                alignment: Alignment.center,
              ),
              Positioned(
                child: Icon(Icons.arrow_drop_up,
                    color: _select == i ? Colors.red : Colors.white),
                bottom: 0,
              )
            ],
          ),
        )),
      );
    }
    return listTab;
  }

  @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _tabBarViews() {
    return list.map<Widget>((value) {
      // return StaggeredGrid.count(
      //   crossAxisCount: 4,
      //   mainAxisSpacing: 4,
      //   crossAxisSpacing: 4,
      //   children: const [
      //     Text("sdfdsf"),
      //     Text("sdfdsf"),
      //     Text("sdfdsf"),
      //     Text("sdfdsf"),
      //     Text("sdfdsf"),
      //     Text("sdfdsf"),
      //   ],
      // );
      return Text("sdfsdfs");
    }).toList();
  }
}
