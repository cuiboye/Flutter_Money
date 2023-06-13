import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/provide/statemixin_provider2.dart';
import 'package:flutter_money/utils/log_utils.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StateMinxinController2 extends GetxController
    with StateMixin<OrdertListNewModel> {
  final StateMixinProvider2 provider;

  StateMinxinController2({required this.provider});

  @override
  void onInit() {
    //这个接口在这里调用是因为一进页面就要请求数据，如果不是一进页面请求数据的话，可以在view中通
    //过controller.getOrderListData();的方式来请求接口
    // getOrderListData("全部","全部");
  }

  Future<void> getOrderListData(String orderType) async {
    final Response response = await provider.getOrderListData(orderType);
    if (response.hasError) {
      //如果有错误
      //改变数据，传入状态，在UI中会处理这些错误
      if(response.status.code ==401){
        change(null, status: RxStatus.error("用户未登录"));
        return;
      }
      change(null, status: RxStatus.error(response.statusText));
    } else {
      //存储数据，改变状态为成功
      OrdertListNewModel data = OrdertListNewModel.fromJson(response.body);
      print("info---111");
      if(null == data || null==data.result){
        change(null, status: RxStatus.error(response.statusText));
        print("info---error");
        return;
      }
      if(WajiuUtils.collectionIsEmpty(data.result?.delivery) == true){
        change(data, status: RxStatus.empty());
        print("info---empty");
        return;
      }
      change(data, status: RxStatus.success());
    }
  }
}
