import 'package:flutter_money/wajiu/controller/orderlist_with_getconnect_controller.dart';
import 'package:flutter_money/wajiu/interface/orderlist_with_getconnect_interface.dart';
import 'package:flutter_money/wajiu/provider/orderlist_with_getconnect_provider.dart';
import 'package:flutter_money/wajiu/repository/orderlist_with_getconnect_repository.dart';
import 'package:get/get.dart';

class OrderListWithGetConnectBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<IOrderListWithConnectProvider>(() => OrderListWithConnectProvider());
    Get.lazyPut<IOrderListWithConnectRepository>(() => OrderListWithConnectRepository(provider: Get.find()));
    Get.lazyPut(() => OrderListWithConnectController(repository: Get.find()));
  }
}