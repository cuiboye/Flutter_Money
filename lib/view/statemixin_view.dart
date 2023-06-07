import 'package:flutter/material.dart';
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';

import 'package:get/get.dart';
class StateMixinView extends GetView<StateMinxinController> {
  StateMixinView({Key? key}) : super(key: key);

  _buildListView(WajiuProductListNewModel? model) {
    print("44ss");
    List<DeliveryList>  deliveryList = model?.result?.delivery??[];
    return ListView.separated(
      itemCount: deliveryList.length,
      itemBuilder: (context, index) {
        final DeliveryList item = deliveryList[index];
        return ListTile(
          onTap: () => null,
          title: Text(""),
          trailing: Text("分类"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetConnect Page"),
      ),
      body: controller.obx(
            (state) => _buildListView(state),
        onEmpty: Text("onEmpty"),
        onLoading: Center(
          child: Column(
            children: [
              Text("没有数据"),
              ElevatedButton(
                onPressed: () {
                  controller.getOrderListData();
                },
                child: Text('拉取数据111'),
              ),
            ],
          ),
        ),
        onError: (err) => Text(err.toString()),
      ),
    );
  }
}