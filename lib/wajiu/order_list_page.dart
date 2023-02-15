import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/order_list_item.dart';

import '../layout/tabbarview.dart';
import '../provide/provider_mvvm_example/provide_demo.dart';
import '../view/keep_alive_wrapper.dart';
import 'order_list_item_main.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List tabs = [ "全部","待支付","已发货", "已完成","未成功"];

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
            child: OrderListItemMain()
            // child: ProvideDemo6()
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
