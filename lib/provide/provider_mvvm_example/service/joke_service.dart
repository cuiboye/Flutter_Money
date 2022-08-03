
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_money/provide/provider_mvvm_example/model/joke_model.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view_model/joke_view_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/view_model/orderlist_view_model.dart';

class JokeService {
  static Future<void> getJokes(JokeViewModel jokeViewModel) async {

    var response = await Dio().get("http://v.juhe.cn/joke/content/text.php?page=1&pagesize=20&key=03303e4d34effe095cf6a4257474cda9");
    if (response.statusCode == 200) {
      // 转换模型
      JokeModel jokeModel = jokeModelFromJson(json.encode(response.data["result"]));
      // 更新数据
      jokeViewModel.setJokeList(jokeModel);
    }
  }

  static Future<void> getOrderList(OrderListViewModel orderListViewModel) async {

    var response = await Dio().get("http://192.168.5.199:8082/danyuan/getOrderList");
    if (response.statusCode == 200) {
      // 转换模型
      final responseData = json.decode(response.toString());
      print("ordertListModel===========>${responseData}");

      OrdertListModel ordertListModel = OrdertListModel.fromJson(responseData);
      // 更新数据
      orderListViewModel.setJokeList(ordertListModel);
    }
  }
}