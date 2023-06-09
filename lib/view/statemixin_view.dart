import 'package:flutter/material.dart';
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';

import 'package:get/get.dart';
class StateMixinView extends GetView<StateMinxinController> {
  String orderType;
  StateMixinView(this.orderType,{Key? key}) : super(key: key);

  _buildListView(OrdertListNewModel? model) {
    print("44ss");
    List<ListBean> deliveryList = model?.result?.delivery??[];
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        // final DeliveryList item = deliveryList[index];
        return Container(
          padding: EdgeInsets.all(13),
          decoration: const BoxDecoration(
            color: ColorConstant.color_ffffff,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(deliveryList[index].unionOrderNumber??"",style: const TextStyle(fontSize: 14,color: ColorConstant.color_black)),
                  Container(
                    padding: const EdgeInsets.only(top: 3,bottom: 3,left: 10,right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: ColorConstant.systemColor),
                        borderRadius: const BorderRadius.all(Radius.circular(30.0))
                    ),
                    child: const Text("加入购物车",style: TextStyle(fontSize: 12,color: ColorConstant.systemColor),),
                  ),

                ],
              ),
              ListView.builder(itemBuilder:  (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text("待支付"),
                        ),
                        LineView(line_height: 1,color: ColorConstant.color_dddddd,),
                        Container(
                          height: 91,
                          child:Row(
                            children: [
                              const CacheImageViewWithWidth(
                                url:
                                "http://image.59cdn.com/static/upload/image/product/20170614/o_1497405976743.jpg",
                                width: 91,
                              ),
                              Expanded(child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: ColorConstant.systemColor,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "金鱼干红",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    ColorConstant.color_343434),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text("¥ 118.00/瓶",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .color_888888)),
                                              Text(
                                                "sss",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorConstant
                                                        .color_888888),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "小店现货",
                                      style: TextStyle(
                                          color: ColorConstant.color_888888,
                                          fontSize: 12),
                                    )
                                  ],
                                ))
                            ],
                          )
                        )
                    ],
                  ),
                );
              },itemCount: 1,shrinkWrap: true,)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<StateMixinProvider>(() => StateMixinProvider());
    Get.lazyPut<StateMinxinController>(() => StateMinxinController(provider: Get.find()));
    controller.getOrderListData(orderType);
    return controller.obx((state) => Container(
      child: _buildListView(state),
      color: ColorConstant.color_ebebeb,
    ),
        onEmpty: const Center(
          child: Text("暂无数据"),
        ),
        onLoading: const Text("加载中"),
        onError: (err) => Text(err.toString())
    );
  }
}