import 'package:flutter/material.dart';
import 'package:flutter_money/controller/count_controller.dart';
import 'package:get/get.dart';

class GetxControllerDemo extends StatelessWidget {
  GetxControllerDemo({Key? key}) : super(key: key);

  final controller = CountController();

  @override
  Widget build(BuildContext context) {
    print("GetxControllerDemo-build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx"),
      ),
      body: Center(
        child: Column(
          children: [
            GetX<CountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetX - 1");
                return Text('value 1 -> ${_.count}');
              },
            ),
            GetX<CountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetX - 2");
                return Text('value 2 -> ${_.count}');
              },
            ),
            Divider(),

            //
            GetX<CountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetX - 3");
                return Column(
                  children: [
                    Text('value 3 -> ${_.count}'),
                    ElevatedButton(
                      onPressed: () {
                        _.add();
                      },
                      child: Text('count1'),
                    )
                  ],
                );
              },
            ),
            Divider(),

            // count2
            GetX<CountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetX - 4");
                return Text('value 4 -> ${_.count2}');
              },
            ),
            Divider(),

            // 按钮
            ElevatedButton(
              onPressed: () {
                controller.add();
              },
              child: Text('count1'),
            ),

            ElevatedButton(
              onPressed: () {
                controller.add2();
              },
              child: Text('count2'),
            ),
          ],
        ),
      ),
    );
  }
}
