import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/wajiu/model/order_list_item_data_model.dart';
import 'package:get/get.dart';

import '../wajiu/constant/apiservice.dart';

class GetxWithDioController extends GetxController {
  var newsPageList = Rx<OrderListItemDataModel>(OrderListItemDataModel());

  @override
  void onInit() {
    super.onInit();
    print("onInit");
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose");
  }

  Future<void> getMyDelivery() async {
    var params = Map<String, dynamic>();
    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFLQmybkbtJzpQKM4fGKyytw==";
    params["req_orderType"] = "1";
    params["page.size"] = "20";
    params["page"] = "1";
    params["userId"] = "84922";
    await DioInstance.getInstance().post(ApiService.getMyDelivery,
        queryParametersMap: params, success: (resultData) {
          print("获取到的数据：$resultData");
          newsPageList.value =  OrderListItemDataModel.fromJson(resultData);
        }, fail: (reason, code) {});
  }
}
