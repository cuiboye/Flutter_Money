
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_money/provide/provider_mvvm_example/model/joke_model.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view_model/joke_view_model.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/app_strings.dart';
import 'package:flutter_money/wajiu/model/mingzhuangxianhuo_product_list_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/view/mingzhuangxianhuo_list_model.dart';
import 'package:flutter_money/wajiu/view_model/orderlist_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MingzhuangxianhuoService {
  static void requestData(MingzhuangxianhuoViewModel mingzhuangxianhuoViewModel) {
    getLoginToken().then((token) {
      getMingzhuangxianhuoData(token ?? "",mingzhuangxianhuoViewModel);
    });
  }
  static Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loginToken = prefs.getString(Constant.LOGIN_TOKEN);
    return loginToken;
  }

  static void getMingzhuangxianhuoData(String token,MingzhuangxianhuoViewModel mingzhuangxianhuoViewModel) {
    var params = Map<String, dynamic>();

    if (!TextUtils.isEmpty(token)) {
      params["req_token"] = token;
      print("名庄现货的token:=====》》》${Uri.encodeComponent(token)}");
      // params["req_token"] = "60R64HMPXUjGBQikTPRZH5z5MdBHGMfFSHPlQcZLBt9sNuTyEsmhbw%253D%253D";
    }
    params["page"] = 1;
    params["userId"] = 1;
    DioInstance.getInstance().get(ApiService.appGaoduan, params,
        success: (resultData) {
          //通知下，刷新成功
          // if (isOnRefresh) {
          //   _refreshController.refreshCompleted();
          // } else {
          //   _refreshController.loadComplete();
          // }
          MingzhuangxianhuoProductListModel model = MingzhuangxianhuoProductListModel.fromJson(resultData);
          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              // // 转换模型
              // JokeModel jokeModel = jokeModelFromJson(json.encode(response.data["result"]));
              // // 更新数据
              mingzhuangxianhuoViewModel.setData(model);
            }
          } else {
            //通知下，刷新失败
            // if (isOnRefresh) {
            //   _refreshController.refreshFailed();
            // } else {
            //   _refreshController.loadFailed();
            // }
          }
        }, fail: (reason, code) {
            print("fail");
          // if (isOnRefresh) {
          //   _refreshController.refreshFailed();
          // } else {
          //   _refreshController.loadFailed();
          // }
        });
  }
}