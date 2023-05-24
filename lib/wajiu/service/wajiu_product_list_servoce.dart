import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/app_strings.dart';
import 'package:flutter_money/wajiu/model/wajiu_product_list_model.dart';
import 'package:flutter_money/wajiu/viewmodel/wajiu_product_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class WajiuProductListService {
  static Future<void> getProductList(ProductListViewModel productListViewModel,
      int pageNum, RefreshController _refreshController, bool refresh) async {
    getLoginToken().then((token) async {
      var map = Map<String, dynamic>();
      map['prices'] = [1];
      map['category'] = [17];
      map['activityId'] = 0;
      map['couponId'] = 0;
      map['qyType'] = 0;
      map['sort'] = 0;
      map['virtualStock'] = 0;

      // productListInDTO 数据格式如下：
      // {"activityId":0,"category":[17],"couponId":0,"prices":[1],"qyType":0,"sort":0,"virtualStock":0}
      var formData = FormData.fromMap({
        "token": token,
        "pageNum": pageNum,
        "pageSize": 20,
        "productListInDTO": map.toString(),
      });
      print("当前页数为 $pageNum");
      await DioInstance.getInstance().post(ApiService.productListScrenn,
          formData: formData, success: (resultData) {
        WajiuProductListModel model =
            WajiuProductListModel.fromJson(resultData);
        if (null != model) {
          int status = model.states;
          String msg = model.msg;
          if (status == 200) {
            productListViewModel.setProductList(model, refresh);
          } else {
            ToastUtils.showToast(msg);
          }
          if (refresh) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.loadComplete();
          }
          print("接口请求数据回来了 $pageNum");
        } else {
          if (refresh) {

            _refreshController.refreshFailed();
          } else {
            _refreshController.loadFailed();
          }
        }
      }, fail: (reason, code) {
        if (refresh) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      });
    });
  }

  static Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loginToken = prefs.getString(Constant.LOGIN_TOKEN);
    return loginToken;
  }
}
