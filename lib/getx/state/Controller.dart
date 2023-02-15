import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController {
  int count = 0;
  void increment() {
    count++;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }
}
