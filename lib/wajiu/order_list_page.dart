import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/order_list_tabbarview_item.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;//保持页面状态

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
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "订单列表",),
          body: Column(
            children: [
              Container(
                height: 40,
                color: ColorConstant.color_ffffff,
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
              Expanded(child: TabBarView(//相当于Android的ViewPager
                controller: _tabController,
                children: _tabBarViews(),
              ),)
            ],
          )),
    );
  }

  //tab标题
  List<String> list = [
    "全部",
    "待支付",
    "已发货",
    "已完成",
    "未成功",
  ];

  List<Widget> tabs() {
    List<Widget> listTab = [];
    for (int i = 0; i < list.length; i++) {
      listTab.add(
        Tab(
            child: Container(
              height: 44,
              child:Align(
                child: Text(
                  "${list[i]}",
                  style: TextStyle(
                      color: _select == i ? ColorConstant.systemColor: Colors.black38),
                ),
                alignment: Alignment.center,
              ),
            )),
      );
    }
    return listTab;
  }

  List<Widget> _tabBarViews() {
    return list.map<Widget>((value) {
      return Center(
        // child: Text("hello"),
        child: NewsDioView(),
      );
    }).toList();
  }
}
