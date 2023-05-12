import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/model/wajiu_balance_model.dart';
import 'package:flutter_money/wajiu/view_model/balance_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BalanceService{
  static Future<void> getBalanceData(BalanceViewModel balanceViewModel,RefreshController _refreshController,
      int pageNum,int pageSize,bool refresh) async{
    var params = Map<String, dynamic>();
    params["pageNum"]=pageNum;
    params["pageSize"]=pageSize;
    await DioInstance.getInstance().get(ApiService.getBalanceData, params,
        success: (resultData) {
          print("获取到的数据：$resultData");
          WajiuBalanceModel model = WajiuBalanceModel.fromJson(resultData);
          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              balanceViewModel.setOrderList(model,refresh);

              if(refresh){
                _refreshController.refreshCompleted();
              }else{
                _refreshController.loadComplete();
              }

            }else{
              ToastUtils.showToast(msg);
            }
          }else{
            if(refresh){
              _refreshController.refreshFailed();
            }else{
              _refreshController.loadFailed();
            }          }
        }, fail: (reason, code) {
          if(refresh){
            _refreshController.refreshFailed();
          }else{
            _refreshController.loadFailed();
          }           });
  }
}