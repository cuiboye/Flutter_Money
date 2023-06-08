import 'package:flutter/material.dart';
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';

import 'package:get/get.dart';
class StateMixinView extends GetView<StateMinxinController> {
  StateMixinView({Key? key}) : super(key: key);

  _buildListView(OrdertListNewModel? model) {
    print("44ss");
    List<ListBean> deliveryList = model?.result?.delivery??[];
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (context, index) {
        // final DeliveryList item = deliveryList[index];
        return Text(deliveryList[index]?.unionOrderNumber??"");
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Get.lazyPut<StateMixinProvider>(() => StateMixinProvider());
    Get.lazyPut<StateMinxinController>(() => StateMinxinController(provider: Get.find()));

    return controller.obx((state) => _buildListView(state),
        onEmpty: const Center(
          child: Text("暂无数据"),
        ),
        onLoading: const Text("加载中"),
        onError: (err) => Text(err.toString())
    );
  }
}