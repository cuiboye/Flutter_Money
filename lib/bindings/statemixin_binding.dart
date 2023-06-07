
import 'package:flutter_money/controller/statemixin_controller.dart';
import 'package:flutter_money/provide/statemixin_provider.dart';
import 'package:get/get.dart';

class StateMixinBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StateMixinProvider>(() => StateMixinProvider());
    Get.lazyPut<StateMinxinController>(() => StateMinxinController(provider: Get.find()));
  }
}