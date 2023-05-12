import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/view_model/orderlist_view_model.dart';

class OrderService{
  static Future<void> getOrderList(OrderListViewModel orderListViewModel) async {
    var params = Map<String, dynamic>();
    await DioInstance.getInstance().get(ApiService.getOrderList, params,
        success: (resultData) {
          print("获取到的数据：$resultData");
          OrdertListModel ordertListModel = OrdertListModel.fromJson(resultData);
          if (null != ordertListModel) {
            int status = ordertListModel.states;
            String msg = ordertListModel.msg;
            if (status == 200) {
              orderListViewModel.setOrderList(ordertListModel);
            }else{
              ToastUtils.showToast(msg);
            }
          }else{

          }
        }, fail: (reason, code) {

        });
  }
}