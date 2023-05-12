
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_money/utils/md5_utils.dart';
import 'package:flutter_money/wajiu/constant/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Success = void Function(dynamic resultData);
typedef Fail = void Function(String? reason, int? code);
typedef After = void Function();

/**
 * Dio网络请求工具类
 */
class DioInstance {
  static Dio? _dio;
  static DioInstance https = DioInstance();

  static DioInstance getInstance() {
    return https;
  }

  DioInstance() {
    _dio ??= createDio();
  }

  Dio createDio() {
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      // baseUrl: "http://192.168.0.101:8083",
      baseUrl: "https://wjapp.iopenx.com/",
      responseType: ResponseType.json,
    );

    //设置header配置
    if(Platform.isIOS){
      baseOptions.headers["appBundleId"] = "com.dakai.app3";
      baseOptions.headers["appVersion"] = "4.8.9";
      baseOptions.headers["deviceID"] = "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
      baseOptions.headers["macAddress"] = "E5:B0:R3:B7:02:13";
      baseOptions.headers["req_token"] = "";
      baseOptions.headers["systemType"] = "wajiu.ios";
    }else{
      baseOptions.headers["deviceID"] = "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
      baseOptions.headers["appVersion"] = "3.80.5";
      baseOptions.headers["systemType"] = "wajiu.android";
      baseOptions.headers["macAddress"] = "E5:B0:R3:B7:02:13";
      baseOptions.headers["androidId"] = "84cd3d602cdef656";
      // baseOptions.headers["req_token"] = "";
    }

    var dio = Dio(baseOptions);
    //添加拦截器，这里添加Dio的日志
    dio.interceptors.add(DioLogInterceptor());

    return dio;
  }

   Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loginToken = prefs.getString(Constant.LOGIN_TOKEN);
    return loginToken;
  }

  Future<void> get(String uri, Map<String, dynamic> queryParametersMap, {Success? success, Fail? fail, After? after}) {

    var params = <String, dynamic>{};
    if(null == queryParametersMap){//外部接口有参数
      params.addAll(getCommitRequestParams());
    }else{//外部接口无参数
      queryParametersMap?.addAll(getCommitRequestParams());
      params = queryParametersMap;
    }

    _dio?.get(uri, queryParameters: params,options:Options(responseType: ResponseType.plain)).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          print("33333 ${json.decode(response.data)}");
          success(json.decode(response.data));
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    return Future.value();
  }

  Future<void> post(String uri, {Map<String, dynamic>? queryParametersMap,FormData? formData,Success? success, Fail? fail, After? after}) {
    var params = <String, dynamic>{};
    if(null == queryParametersMap){//外部接口有参数
      params.addAll(getCommitRequestParams());
    }else{//外部接口无参数
      queryParametersMap?.addAll(getCommitRequestParams());
      params = queryParametersMap;
    }

    //formData为空，实例化一个空的map，formData有值的话就不重新new了
    formData ??=  FormData.fromMap({});

    _dio?.post(uri, queryParameters: params,data: formData,options: Options(contentType: "multipart/form-data",responseType: ResponseType.plain)).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          print("接口请求成功了");
          print("${response.data}");
          success(json.decode(response.data));
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    return Future.value();
  }

  //拼接在url后面的公共参数
  Map<String, dynamic> getCommitRequestParams(){
    var params = <String, dynamic>{};
    if(Platform.isIOS){
      params["appBundleId"] = "com.dakai.app3";
      params["appVersion"] = "4.8.9";
      params["deviceID"] = "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
      params["macAddress"] = "E5:B0:R3:B7:02:13";
      params["req_token"] = "";
      params["systemType"] = "wajiu.ios";
    }else{
      params["appVersion"] = "3.80.5";
      params["systemType"] = "wajiu.android";
      params["macAddress"] = "E5:B0:R3:B7:02:13";
      getLoginToken().then((value) {
        // params["req_token"] =Uri.encodeComponent(value??"");
        params["req_token"] ="60R64HMPXUjGBQikTPRZH5z5MdBHGMfFSHPlQcZLBt9sNuTyEsmhbw%253D%253D";
      });
      params["deviceID"] = "02ffff10102b2ff0263d393677fc1b7270d9e08c8f";
    }
    return params;
  }
}
