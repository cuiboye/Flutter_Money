import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/widget/dash_line.dart';

import '../wajiu/model/orderlist_new.dart';

class OrderTotalAdapter extends StatelessWidget {
 final List<ListBean?> orderDdataList;
  OrderTotalAdapter(this.orderDdataList);
  @override
  Widget build(BuildContext context) {
    return getItem(orderDdataList);
  }

  Widget getItem(List<ListBean?> orderDdataList) {
    print("44ss");
    List<ListBean?> deliveryList = orderDdataList;
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
                    Text(deliveryList[index]?.unionOrderNumber ?? "",
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
                  deliveryList[index]?.orders?[0]?.orderStatusStr ?? "",
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
                                  "${deliveryList[index]?.orders?[0]?.orderProduct?[childIndex]?.picture}?imageView2/2/w/740/h/314/q/100" ??
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
                                                    ?.orders?[0]
                                                    ?.orderProduct?[childIndex]
                                                    ?.cname ??
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
                                                          ?.orders?[0]
                                                          ?.orderProduct?[
                                                      childIndex]
                                                          ?.stringOnePrice ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: ColorConstant
                                                              .systemColor)),
                                                  Text(
                                                    deliveryList[index]
                                                        ?.orders?[0]
                                                        ?.orderProduct?[
                                                    childIndex]
                                                        ?.isJiuZhouBianName ??
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
                                                ?.orders?[0]
                                                ?.orderProduct?[childIndex]
                                                ?.orderTypeStr ??
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
                itemCount: deliveryList[index]?.orders?[0]?.orderProduct?.length??0,
                shrinkWrap: true,
              ),
              Container(
                alignment: Alignment.centerRight,
                color: ColorConstant.color_ffffff,
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 13),
                child: Text(
                  deliveryList[index]?.orders?[0]?.orderTotalPriceStr ?? "",
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
}
