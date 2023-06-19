import 'package:flutter/material.dart';
import 'package:flutter_money/adapter/order_total_adapter.dart';
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/view/base_pull_refresh.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageItemWidget extends StatefulWidget {
  String orderType;

  PageItemWidget(this.orderType);

  @override
  _PageItemWidgetState createState() => _PageItemWidgetState();
}

//使用 with AutomaticKeepAliveClientMixin 可以避免每次重新加载页面数据
// class _PageItemWidgetState extends State<PageItemWidget>  with AutomaticKeepAliveClientMixin{
//下面这种写法每次切换Tab都会重新加载数据
class _PageItemWidgetState extends State<PageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StateMixinView(widget.orderType);
    // return Text(widget.value);
  }
// @override
// bool get wantKeepAlive => true;
}

class StateMixinView extends GetView<StateMinxinController> {
  static const int PAGESIZE = 6;
  int pageNum = 1;
  bool hasData = false;
  String orderType;
  List<ListBean?> orderDdataList = [];

  StateMixinView(this.orderType);

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<StateMixinProvider>(() => StateMixinProvider());
    Get.lazyPut<StateMinxinController>(
        () => StateMinxinController(provider: Get.find()));
    controller.getOrderListData(pageNum, orderType);

    return contentWidget();
  }

  Widget contentWidget() {
    return controller.obx((state) {
      // print("delivery的长度为：当前页数为$pageNum,${state?.result?.delivery?.length??0}");
      hasData = (state?.result?.delivery?.length ?? 0) >= PAGESIZE;
      if (pageNum == 1) {
        orderDdataList.clear();
        orderDdataList = state?.result?.delivery ?? [];
        _refreshController.refreshCompleted();
      } else if (pageNum > 1) {
        orderDdataList.addAll(state?.result?.delivery ?? []);
        _refreshController.loadComplete();
      }
      return BasePullRefreshView(
        Container(
          color: ColorConstant.color_ebebeb,
          child: OrderTotalAdapter(orderDdataList),
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        hasData: hasData,
        refreshController: _refreshController,
      );
    },
        onEmpty: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/ic_order_nothing.png",
              width: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.w),
              child: const Text("您没有更多的订单"),
            )
          ],
        ),
        onLoading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/ic_order_nothing.png",
              width: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.w),
              child: const Text("您没有更多的订单"),
            )
          ],
        ),
        onError: (err) => Text(err.toString()));
  }

  void _onRefresh() async {
    pageNum = 1;
    controller.getOrderListData(pageNum, orderType);
  }

  void _onLoading() async {
    pageNum++;
    controller.getOrderListData(pageNum, orderType);
  }
}
