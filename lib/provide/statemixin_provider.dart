import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_money/wajiu/provider/base_provider.dart';
import 'package:get/get.dart';

abstract class IStateMixinProvider {
  Future<Response> getOrderListData(String orderType);
}

class StateMixinProvider extends BaseProvider implements IStateMixinProvider {
  @override
  Future<Response> getOrderListData(String orderType) {

    String reqOrderType = "";
    if(orderType=="全部"){
      reqOrderType = "1";
    }else if(orderType=="待支付"){
      reqOrderType = "2";
    }else if(orderType=="已发货"){
      reqOrderType = "3";
    }else if(orderType=="已完成"){
      reqOrderType = "4";
    }else if(orderType=="未成功"){
      reqOrderType = "5";
    }
    print("reqOrderType $reqOrderType");
    var params = Map<String, dynamic>();

    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFGLwH1fTTsZOfsxBMi1gimQ==";
    params["req_orderType"] = "1";
    params["page.size"] = "20";
    params["page"] = "1";
    params["userId"] = "84922";
    return get(ApiService.getMyDelivery,query: params);//请求方法中可以将返回数据自动转为模型
  }
}
