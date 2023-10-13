import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/controller/orderlist_with_getconnect_controller.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:get/get.dart';

class GetConnectPageView extends GetView<OrderListWithConnectController> {
  GetConnectPageView({Key? key}) : super(key: key);

  _buildListView(WajiuProductListNewModel? model) {
    return ListView.separated(
      itemCount: model?.result?.delivery?.length ?? 0,
      itemBuilder: (context, index) {
        final DeliveryList? item = model?.result?.delivery?[index];
        return ListTile(
          onTap: () => null,
          title: Text("${item?.orders}"),
          trailing: Text("分类 ${item?.orders}"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
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
        (state) => _buildListView(state),//成功获取数据展示这个Widget
        onEmpty: Text("onEmpty"),//数据为空展示这个Widget
        onLoading: Center(//请求数据时显示这个Widget
          child: Column(
            children: [
              Text("没有数据"),
              ElevatedButton(
                onPressed: () {
                  controller.getNewsPageList();
                },
                child: Text('拉取数据'),
              ),
            ],
          ),
        ),
        onError: (err) => Text("onEmpty" + err.toString()),//报错显示这个Widget
      ),
    );
  }
}
