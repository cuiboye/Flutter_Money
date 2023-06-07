import 'package:flutter/material.dart';
import 'package:flutter_money/controller/getx_work_controller.dart';
import 'package:get/get.dart';

/*
 * GetBuilder 手动控制
 * controller -> update
*/

class StateWorkersView extends StatelessWidget {
  StateWorkersView({Key? key}) : super(key: key);

  final controller = GetXWorkCountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetBuilder"),
      ),
      body: Center(
        child: Column(
          children: [
            // 显示
            GetX<GetXWorkCountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return Text('value -> ${_.count}');
              },
            ),

            // 按钮
            ElevatedButton(
              onPressed: () {
                controller.add();
              },
              child: Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
