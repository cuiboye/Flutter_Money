import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StateMinxinController extends GetxController
    with StateMixin<WajiuProductListNewModel> {
  final StateMixinProvider provider;

  StateMinxinController({required this.provider});

  Future<void> getOrderListData() async {
    //获取数据
    final Response response = await provider.getOrderListData();
    print("777aa");
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
      var data = WajiuProductListNewModel.fromJson(response.body);
      change(data, status: RxStatus.success());
    }
  }
}
