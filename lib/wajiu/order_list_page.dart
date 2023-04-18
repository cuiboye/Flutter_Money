import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/order_list_item.dart';

import '../layout/tabbarview.dart';
import '../provide/provider_mvvm_example/provide_demo.dart';
import '../view/keep_alive_wrapper.dart';
import 'order_list_item_main.dart';

// class OrderListPage extends StatefulWidget {
//   @override
//   _OrderListPageState createState() => _OrderListPageState();
// }
//
// class _OrderListPageState extends State<OrderListPage>
//     with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
//   @override
//   bool get wantKeepAlive => true;//保持页面状态
//
//   late TabController _tabController;
//   int _select = 0; //选中tab小标
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: list.length);
//     _tabController.addListener(() {
//       setState(() {
//         _select = _tabController.index;
//         print("$_select");
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//           body: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 50),
//                 height: 40,
//                 child: TabBar(
//                     indicatorColor: Colors.transparent,
//                     //指示器设置为透明色
//                     indicatorPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                     isScrollable: true,
//                     //设置可滑动
//                     controller: _tabController,
//                     onTap: (value) {
//                       setState(() {
//                         _select = value;
//                       });
//                     },
//                     //tabs tab标签
//                     tabs: tabs()),
//               ),
//               // Expanded(
//               //   flex: 1,
//               //   child: TabBarView(//相当于Android的ViewPager
//               //     controller: _tabController,
//               //     children: _tabBarViews(),
//               //   ),
//               // )
//               Expanded(child: TabBarView(//相当于Android的ViewPager
//                 controller: _tabController,
//                 children: _tabBarViews(),
//               ),)
//             ],
//           )),
//     );
//   }
//
//   //tab标题
//   List<String> list = [
//     "直播",
//     "推荐",
//     "热门",
//     "追番",
//     "影视",
//     "其他",
//     "其他",
//     "其他",
//     "其他",
//     "其他",
//     "其他",
//   ];
//
//   List<Widget> tabs() {
//     List<Widget> listTab = [];
//     for (int i = 0; i < list.length; i++) {
//       listTab.add(
//         Tab(
//             child: Container(
//               height: 44,
//               child: Stack(
//                 children: [
//                   Align(
//                     child: Text(
//                       "${list[i]}",
//                       style: TextStyle(
//                           color: _select == i ? ColorConstant.systemColor: Colors.black38),
//                     ),
//                     alignment: Alignment.center,
//                   ),
//                   Positioned(
//                     child: Icon(Icons.arrow_drop_up,
//                         color: _select == i ? Colors.red : Colors.white),
//                     bottom: 0,
//                   )
//                 ],
//               ),
//             )),
//       );
//     }
//     return listTab;
//   }
//
//   List<Widget> _tabBarViews() {
//     return list.map<Widget>((value) {
//       return Center(
//         child: Text(value),
//       );
//     }).toList();
//   }
// }
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
