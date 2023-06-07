import 'package:flutter_money/controller/getx_with_dio_controller.dart';
import 'package:get/get.dart';

//binding:不用再在 Widget 里注入和使用，完全解耦。瑶实现自动注入，我们就需要这个类。
class GetxWithDioBinding implements Bindings {
  //dependencies()：通知路由，我们要使用该 Binding 来建立路由管理器、依赖关系和状态之间的连接。
  @override
  void dependencies() {
    Get.lazyPut<GetxWithDioController>(() => GetxWithDioController());
  }
}
