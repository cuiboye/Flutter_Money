import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/view/base_pull_refresh.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/widget/dash_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

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
  List<ListBean> orderDdataList = [];

  StateMixinView(this.orderType);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _buildListView(List<ListBean> orderDdataList) {
    print("44ss");
    List<ListBean> deliveryList = orderDdataList;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: deliveryList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            color: ColorConstant.color_ffffff,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 13, right: 13, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(deliveryList[index].unionOrderNumber ?? "",
                        style: const TextStyle(
                            fontSize: 14, color: ColorConstant.color_black)),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: ColorConstant.systemColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0))),
                      child: const Text(
                        "加入购物车",
                        style: TextStyle(
                            fontSize: 12, color: ColorConstant.systemColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: ColorConstant.color_f9f9f9,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 13, right: 13),
                child: Text(
                  deliveryList[index].orders[0].orderStatusStr ?? "",
                  style: const TextStyle(
                      color: ColorConstant.color_8b8b8b, fontSize: 13),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, childIndex) {
                  return Container(
                    color: ColorConstant.color_f9f9f9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LineView(
                          line_height: 0.5,
                          color: ColorConstant.color_dddddd,
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 13, right: 13, bottom: 10),
                            height: 91,
                            child: Row(
                              children: [
                                CacheImageViewWithWidth(
                                  url:
                                      "${deliveryList[index].orders[0].orderProduct[childIndex].picture}?imageView2/2/w/740/h/314/q/100" ??
                                          "",
                                  width: 91,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            deliveryList[index]
                                                    .orders[0]
                                                    .orderProduct[childIndex]
                                                    .cname ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color:
                                                    ColorConstant.color_343434),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  deliveryList[index]
                                                          .orders[0]
                                                          .orderProduct[
                                                              childIndex]
                                                          .stringOnePrice ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: ColorConstant
                                                          .systemColor)),
                                              Text(
                                                deliveryList[index]
                                                        .orders[0]
                                                        .orderProduct[
                                                            childIndex]
                                                        .isJiuZhouBianName ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: ColorConstant
                                                        .color_888888),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        deliveryList[index]
                                                .orders[0]
                                                .orderProduct[childIndex]
                                                .orderTypeStr ??
                                            "",
                                        style: const TextStyle(
                                            color: ColorConstant.color_888888,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            )),
                      ],
                    ),
                  );
                },
                itemCount: deliveryList[index].orders[0].orderProduct.length,
                shrinkWrap: true,
              ),
              Container(
                alignment: Alignment.centerRight,
                color: ColorConstant.color_ffffff,
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 13),
                child: Text(
                  deliveryList[index].orders[0].orderTotalPriceStr ?? "",
                  style: const TextStyle(
                      fontSize: 13, color: ColorConstant.color_343434),
                ),
              ),
              Container(
                height: 1,
                color: ColorConstant.color_ffffff,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: const DashLine(
                  color: ColorConstant.color_e4e4e4,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 13, top: 10, bottom: 10),
                alignment: Alignment.centerRight,
                color: ColorConstant.color_ffffff,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: 0.5)),
                      width: 68,
                      height: 28,
                      alignment: Alignment.center,
                      child: const Text(
                        "退款",
                        style: TextStyle(
                            color: ColorConstant.color_black, fontSize: 10),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: 0.5)),
                      width: 68,
                      height: 28,
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: const Text(
                        "下载资料",
                        style: TextStyle(
                            color: ColorConstant.color_black, fontSize: 10),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: 0.5)),
                      width: 68,
                      height: 28,
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: const Text(
                        "查看物流",
                        style: TextStyle(
                            color: ColorConstant.color_black, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              LineView(
                line_height: 8,
                color: ColorConstant.color_eeeeee,
              )
            ],
          ),
        );
      },
    );
  }

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
          child: _buildListView(orderDdataList),
          color: ColorConstant.color_ebebeb,
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
              child: Text("您没有更多的订单"),
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

  //
  void _onRefresh() async {
    // monitor network fetch
    // requestData(true);
    // print("_onRefresh");
    // // if failed,use refreshFailed()
    // if (mounted) setState(() {});
    pageNum = 1;
    controller.getOrderListData(pageNum, orderType);
  }

  void _onLoading() async {
    // monitor network fetch
    // loadMoreData();
    // print("_onLoading");
    // if (mounted) setState(() {});
    pageNum++;
    controller.getOrderListData(pageNum, orderType);
  }
}
