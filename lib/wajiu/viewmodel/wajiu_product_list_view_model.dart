import 'package:flutter/material.dart';

import '../model/wajiu_product_list_model.dart';

class ProductListViewModel with ChangeNotifier {
  List<ProductList> _productList = [];
  late ProductList _productListItem;
  bool loading = true;
  bool refreing = true;
  bool hasData = false;

  setProductList(WajiuProductListModel model,bool refresh) {
    if(refresh){
      _productList.clear();
      _productList = model.result?.productList??[];
      refreing = false;
      print("refreing监听$refreing");
    }else {
      _productList.addAll(model.result?.productList??[]);
      loading = false;
    }

    hasData = (model.result?.productList??[]).length<20?false:true;
    notifyListeners();
  }

  List<ProductList> get productList => _productList;
  ProductList get productListItem => _productListItem;
}