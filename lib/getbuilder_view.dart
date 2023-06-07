/*
 * GetBuilder 手动控制
 * controller -> update
 *
 * GetBuilder和GetX的区别是：GetBuilder需要手动控制更新，GetX是自动更新的
*/
import 'package:flutter/material.dart';
import 'package:flutter_money/controller/getbuilder_controller.dart';
import 'package:get/get.dart';

class GetBuilderView extends StatelessWidget {
  GetBuilderView({Key? key}) : super(key: key);

  final controller = GetBuilderCountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetBuilder"),
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder<GetBuilderCountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetBuilder - 1");
                return Text('value -> ${_.count}');
              },
            ),
            GetBuilder<GetBuilderCountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetBuilder - 2");
                return Text('value -> ${_.count}');
              },
            ),
            Divider(),

            //
            GetBuilder<GetBuilderCountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetBuilder - 3");
                return Column(
                  children: [
                    Text('value -> ${_.count}'),
                    ElevatedButton(
                      onPressed: () {
                        _.add();
                      },
                      child: Text('GetBuilder -> add'),
                    )
                  ],
                );
              },
            ),
            Divider(),

            // count2
            GetBuilder<GetBuilderCountController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetBuilder - 4");
                return Text('value count2 -> ${_.count2}');
              },
            ),
            Divider(),

            // id2
            GetBuilder<GetBuilderCountController>(
              id: "id2",
              init: controller,
              initState: (_) {},
              builder: (_) {
                print("GetBuilder - 4");
                return Text('id2 -> value count2 -> ${_.count2}');
              },
            ),
            Divider(),

            // 按钮
            ElevatedButton(
              onPressed: () {
                controller.add();
              },
              child: Text('add'),
            ),

            ElevatedButton(
              onPressed: () {
                controller.add2();
              },
              child: Text('add2'),
            ),

            ElevatedButton(
              onPressed: () {
                controller.update();
              },
              child: Text('controller.update()'),
            ),

            ElevatedButton(
              onPressed: () {
                controller.update(["id2"]);
              },
              child: Text('controller.update(id2)'),
            ),
          ],
        ),
      ),
    );
  }
}
