import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/model/wajiu_balance_model.dart';
import '../model/orderlist.dart';

class BalanceViewModel with ChangeNotifier {

  List<BalanceList> _balanceList = [];

  late BalanceList _balanceBean;

  bool loading = true;
  bool _hasData = true;

  setOrderList(WajiuBalanceModel model,bool refresh) {
    if(refresh){
      _balanceList = [];
      _balanceList = model.result.balanceList;
    }else{
      _balanceList.addAll(model.result.balanceList);
    }
    _hasData = model.result.balanceList.length<10?false:true;
    loading = false;
    notifyListeners();
  }

  setBalance(BalanceList balanceBean) {
    _balanceBean = balanceBean;
  }

  List<BalanceList> get balanceList => _balanceList;
  BalanceList get balanceBean => _balanceBean;
  bool get hasData => _hasData;
}