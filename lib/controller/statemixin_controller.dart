import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:flutter_money/utils/log_utils.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StateMinxinController extends GetxController
    with StateMixin<OrdertListNewModel> {
  final StateMixinProvider provider;

  StateMinxinController({required this.provider});

  @override
  void onInit() {
    //这个接口在这里调用是因为一进页面就要请求数据，如果不是一进页面请求数据的话，可以在view中通
    //过controller.getOrderListData();的方式来请求接口
    // getOrderListData("全部","全部");
  }

  @override
  void onReady() {

  }

  Future<void> getOrderListData(int pageNum,String orderType) async {
    EasyLoading.show(status: 'loading...');
    debugPrint("await执行之前");
    final Response response = await provider.getOrderListData(pageNum,orderType);
    //这个语句会阻塞，知道response的结果返回，如果不想后面的语句被阻塞，可以将不想被阻塞的语句放到getOrderListData方法之后
    debugPrint("await执行之后");
    EasyLoading.dismiss();

    debugPrint("接口返回数据 ${response.bodyString}");
    debugPrint("response.hasError ${response.hasError}");
    debugPrint("response.isOk ${response.isOk}");
    debugPrint("接口请求Header ${response.request?.headers?.toString()}");
    debugPrint("接口请求地址 ${response.request?.url}");
    debugPrint("接口请求方法 ${response.request?.method}");
    debugPrint("http响应码 ${response.statusCode}");


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
