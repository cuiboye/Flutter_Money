import 'package:flutter/material.dart';
import 'package:flutter_money/controller/getx_with_dio_controller.dart';
import 'package:flutter_money/wajiu/model/order_list_item_data_model.dart';
import 'package:get/get.dart';

/**
 * GetX+MVVM
 */

//通过GetView更加方便的获取数据
class GetXWithDioView extends GetView<GetxWithDioController> {
  @override
  Widget build(BuildContext context) {
    controller.getMyDelivery();
    return Scaffold(
      appBar: AppBar(
        title: Text("GetConnect Page"),
      ),
      body: Obx((){
        return _buildListView(controller.newsPageList.value.result?.delivery);
      }),
    );
  }

  _buildListView(List<Delivery?>? items) {
    return items == null
        ? Center(
      child: Column(
        children: [
          Text("没有数据"),
          ElevatedButton(
            onPressed: () {
              Get.find<GetxWithDioController>().getMyDelivery();
            },
            child: Text('拉取数据'),
          ),
        ],
      ),
    )
        : ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final Delivery? item = items[index];
        return ListTile(
          onTap: () => null,
          title: Text("dsfd"),
          trailing: Text("分类 ${item?.unionOrderNumber}"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

