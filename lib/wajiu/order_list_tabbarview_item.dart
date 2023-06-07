import 'package:flutter/material.dart';
import 'package:flutter_money/controller/order_list_item_data_controller.dart';
import 'package:flutter_money/wajiu/model/order_list_item_data_model.dart';
import 'package:get/get.dart';

/**
 * GetX+MVVM
 */
class NewsDioView extends StatelessWidget {
  NewsDioView({Key? key}) : super(key: key);

  _buildListView(List<Delivery>? items) {
    return items == null
        ? Center(
      child: Column(
        children: [
          Text("没有数据"),
          ElevatedButton(
            onPressed: () {
              Get.find<OrderListItemDataController>().getMyDelivery();
            },
            child: Text('拉取数据'),
          ),
        ],
      ),
    )
        : ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final Delivery item = items[index];
        return ListTile(
          onTap: () => null,
          title: Text("dsfd"),
          trailing: Text("分类 ${items[index].unionOrderNumber}"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("NewsDioView-build");
    //Get.put为依赖注入
    var controller = Get.put<OrderListItemDataController>(OrderListItemDataController());
    return Scaffold(
      appBar: AppBar(
        title: Text("GetConnect Page"),
      ),
      body: GetX<OrderListItemDataController>(
        init: controller,
        builder: (_) => _buildListView(_.newsPageList.value.result?.delivery),
      ),
    );
  }
}
