import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    // httpClient.defaultDecoder =
    //     (val) => OrdertListNewModel.fromJson(val as Map<String, dynamic>);
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
      EasyLoading.show(status: '加载数据中...');
      return request;
    });

    //响应拦截器
    httpClient.addResponseModifier((request, response) {
      EasyLoading.dismiss();
      return response;
    });
  }
}
