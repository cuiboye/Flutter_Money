import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/view/statemixin_view.dart';
import 'package:flutter_money/view/statemixin_view2.dart';
import 'package:flutter_money/view/statemixin_view3.dart';
import 'package:flutter_money/view/statemixin_view4.dart';
import 'package:flutter_money/view/statemixin_view5.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/widget/fix_tabbarview.dart';
import 'package:get/get.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true; //保持页面状态

  late TabController _tabController;

  late PageController _pageController;

  RxInt _select = 0.obs; //选中tab小标
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: list.length);

    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        _select.value = _tabController.index;
        _pageController.jumpToPage(_select.value);
      }
    });
    _pageController = PageController();
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
          appBar: CustomAppbar(
            context: context,
            title: "订单列表",
          ),
          body: Column(
            children: [
              Container(
                height: 40,
                color: ColorConstant.color_ffffff,
                child: TabBar(
                    indicatorColor: Colors.transparent,
                    //指示器设置为透明色
                    indicatorPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    isScrollable: true,
                    //设置可滑动
                    controller: _tabController,
                    onTap: (value) {
                      print("onTap $value");
                      _select.value = value;
                    },
                    //tabs tab标签
                    tabs: tabs()),
              ),
              Expanded(
                child: FixTabBarView(
                    pageController: _pageController,
                    tabController: _tabController,
                    // children: _tabBarViews()
                    children: [
                      PageItemWidget("全部"),
                      PageItemWidget2("待支付"),
                      PageItemWidget3("已发货"),
                      PageItemWidget4("已完成"),
                      PageItemWidget5("未成功"),
                    ]),
              ),
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
          child: Align(
            alignment: Alignment.center,
              child: Obx((){
                return Text(
                  list[i],
                  style: TextStyle(
                      color: _select.value == i
                          ? ColorConstant.systemColor
                          : Colors.black38),
                );
              }),
          ),
        )),
      );
    }
    return listTab;
  }

  List<Widget> _tabBarViews() {
    String str = list[_select.value];
    return list.map<Widget>((String value) {
      return Center(
        child: PageItemWidget(value),
      );
    }).toList();
  }
}
