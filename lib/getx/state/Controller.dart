import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/**
 * 不要在GetxController里面调用dispose方法，它不会有任何作用，记住控制器不是Widget，你不应该 "dispose "它，它会被Get自动智能地从内存中删除。如果你在上面使用了任何流，想
 * 关闭它，只要把它插入到close方法中就可以了
 */
class Controller extends GetxController {
  int count = 0;
  void increment() {
    count++;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    //在这里关闭流
    super.onClose();
  }
}
