// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_money/controller/statemixin_controller.dart';
// import 'package:flutter_money/provide/statemixin_provider.dart';
// import 'package:flutter_money/view/base_pull_refresh.dart';
// import 'package:flutter_money/wajiu/constant/color.dart';
// import 'package:flutter_money/wajiu/model/orderlist_new.dart';
// import 'package:flutter_money/wajiu/widget/line_view.dart';
// import 'package:flutter_money/widget/cache_image_view_with_size.dart';
// import 'package:flutter_money/widget/dash_line.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// typedef Provider = void Function();
// typedef MyCallBack = List<dynamic> Function(); //自定义了一个 传String的函数类型
//
// class BasePullRefreshView<T extends GetxController> extends GetView<T> {
//   List<dynamic> mData = [];
//   late final Widget childContentWidget;
//   int PAGESIZE = 6;
//   int pageNum = 1;
//   bool hasData = false;
//
//   // final Provider f;
//
//   @override
//   Widget build(BuildContext context) {
//     final RefreshController _refreshController =
//         RefreshController(initialRefresh: false);
//     return controller.obx((state) {
//       hasData = (state?.result?.delivery?.length ?? 0) >= PAGESIZE;
//       if (pageNum == 1) {
//         mData.clear();
//         mData = state?.result?.delivery ?? [];
//         _refreshController.refreshCompleted();
//       } else if (pageNum > 1) {
//         mData.addAll(state?.result?.delivery ?? []);
//         _refreshController.loadComplete();
//       }
//       // onCall(){
//       //   return mData;
//       // }
//       // onCall();
//       return BasePullRefresh(
//         getchildView(),
//         onRefresh: _onRefresh,
//         onLoading: _onLoading,
//         hasData: hasData,
//         refreshController: _refreshController,
//       );
//     },
//         onEmpty: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "images/ic_order_nothing.png",
//               width: 80,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10.w),
//               child: const Text("您没有更多的订单"),
//             )
//           ],
//         ),
//         onLoading: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "images/ic_order_nothing.png",
//               width: 80,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10.w),
//               child: const Text("您没有更多的订单"),
//             )
//           ],
//         ),
//         onError: (err) => Text(err.toString()));
//
//
//   }
//
//   Widget getchildView(){
//     return const SizedBox(height: 0,width: 0,);
//   }
//
//   void _onRefresh() async {
//     pageNum = 1;
//     controller.getOrderListData(pageNum, "1");
//   }
//
//   void _onLoading() async {
//     pageNum++;
//     controller.getOrderListData(pageNum, "1");
//   }
// }
