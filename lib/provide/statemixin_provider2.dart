import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_money/wajiu/provider/base_provider.dart';
import 'package:get/get.dart';

abstract class IStateMixinProvider2 {
  Future<Response> getOrderListData(String orderType);
}

class StateMixinProvider2 extends BaseProvider implements IStateMixinProvider2 {
  @override
  Future<Response> getOrderListData(String orderType) {
    var params = Map<String, dynamic>();

    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFGLwH1fTTsZOfsxBMi1gimQ==";
    params["req_orderType"] = "2";
    params["page.size"] = "20";
    params["page"] = "1";
    params["userId"] = "84922";
    return get(ApiService.getMyDelivery,query: params);//请求方法中可以将返回数据自动转为模型
  }
}
