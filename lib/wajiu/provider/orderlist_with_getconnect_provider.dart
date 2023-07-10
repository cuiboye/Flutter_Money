import 'dart:io';

import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:get/get.dart';


// ignore: one_member_abstracts
abstract class IOrderListWithConnectProvider {
  Future<Response<WajiuProductListNewModel>> getOrderListData(String path);
}

class OrderListWithConnectProvider extends GetConnect implements IOrderListWithConnectProvider {
  @override
  void onInit() {
    // httpClient.defaultDecoder =
    //     (val) => OrderListItemDataModel.fromJson(val as Map<String, dynamic>);
    // httpClient.baseUrl = 'https://wjapp.iopenx.com/';

    httpClient.defaultDecoder =
        (val) => WajiuProductListNewModel.fromJson(val as Map<String, dynamic>);
    //baseurl
    httpClient.baseUrl = "https://wjapp.iopenx.com/";

    //请求拦截器
    httpClient.addRequestModifier<void>((request) {
      if (Platform.isIOS) {
        request.headers["appBundleId"] = "com.dakai.app3";
        request.headers["appVersion"] = "4.8.9";
        request.headers["deviceID"] =
        "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
        request.headers["macAddress"] = "E5:B0:R3:B7:02:13";
        request.headers["req_token"] = "";
        request.headers["systemType"] = "wajiu.ios";
      } else {
        request.headers["deviceID"] =
        "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
        request.headers["appVersion"] = "3.80.5";
        request.headers["systemType"] = "wajiu.android";
        request.headers["macAddress"] = "E5:B0:R3:B7:02:13";
        request.headers["androidId"] = "84cd3d602cdef656";
        // request.headers["req_token"] = "";
      }

      httpClient.printInfo();
      httpClient.printError();
      print("${request.headers}");
      print("${request.url}");
      print("${request.bodyBytes}");
      print("${request.method}");
      return request;
    });

    //响应拦截器
    httpClient.addResponseModifier((request, response) {
      print("ssssss2");
      return response;
    });
    super.onInit();
  }
  @override
  Future<Response<WajiuProductListNewModel>> getOrderListData(String path){
    var params = Map<String, dynamic>();

    params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFP32gCeLHZLT05B0y49hqmrA==1";
    params["req_orderType"] = "1";
    params["page.size"] = "20";
    params["page"] = "1";
    params["userId"] = "84922";
    return get(path,query: params);
  }
}
