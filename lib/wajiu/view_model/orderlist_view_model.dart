import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/orderlist.dart';

class OrderListViewModel with ChangeNotifier {

  List<ListBean>? _orderList = [];

  late ListBean _orderItem;

  bool loading = true;

  setOrderList(OrdertListModel ordertListModel) {
    _orderList = [];
    _orderList = ordertListModel.result.list;
    loading = false;
    notifyListeners();
  }

  setJoke(ListBean listBean) {
    _orderItem = listBean;
  }

  List<ListBean>? get orderList => _orderList;
  ListBean get joke => _orderItem;
}