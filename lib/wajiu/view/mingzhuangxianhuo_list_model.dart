import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/model/mingzhuangxianhuo_product_list_model.dart';


class MingzhuangxianhuoViewModel with ChangeNotifier {

  List<Productlist?>? _productList = [];
  List<Noticelist?>? _noticeList = [];
  late Productlist _productItem;

  bool loading = true;

  setData(MingzhuangxianhuoProductListModel model) {
    _productList = [];
    _noticeList = [];
    _productList = model.result.productlist;
    _noticeList = model.result.noticelist;
    loading = false;
    notifyListeners();
  }

  List<Productlist?>? get productList => _productList;
  List<Noticelist?>? get noticeList => _noticeList;

  Productlist get productItem => _productItem;
}