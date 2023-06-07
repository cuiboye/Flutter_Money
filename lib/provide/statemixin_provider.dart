import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/provider/base_provider.dart';
import 'package:get/get.dart';

abstract class IStateMixinProvider {
  Future<Response<WajiuProductListNewModel>> getOrderListData();
}

class StateMixinProvider extends BaseProvider implements IStateMixinProvider {
  @override
  Future<Response<WajiuProductListNewModel>> getOrderListData() {
    var params = Map<String, dynamic>();

    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFP32gCeLHZLT05B0y49hqmrA==1";
    params["req_orderType"] = "1";
    params["page.size"] = "20";
    params["page"] = "1";
    params["userId"] = "84922";
    return get(ApiService.getMyDelivery,query: params);
  }
}
