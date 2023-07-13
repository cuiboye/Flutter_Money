import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:flutter_money/wajiu/provider/base_provider.dart';
import 'package:get/get.dart';

abstract class IStateMixinProvider {
  Future<Response> getOrderListData(int pageNum,String orderType);
}

class StateMixinProvider extends BaseProvider implements IStateMixinProvider {
  @override
  Future<Response> getOrderListData(int pageNum,String orderType) {
    print("当前页数为 $pageNum");
    debugPrint("await执行");
    var params = <String, dynamic>{};
    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFGLwH1fTTsZOfsxBMi1gimQ==";
    params["req_orderType"] = "1";
    params["page.size"] = "6";
    params["page"] = "$pageNum";
    params["userId"] = "84922";
    return get(ApiService.getMyDelivery,query: params);//请求方法中可以将返回数据自动转为模型
  }
}
