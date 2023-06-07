import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:get/get.dart';

class GetXObsDemo extends StatelessWidget{
  RxInt count = 0.obs;//使一个对象可观察，对象变化的时候刷新组件
  // obs、extension、RxInt、Rx
  @override
  Widget build(BuildContext context) {
    print("build");
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "obs测试",),
        body: Column(
          children: [
            Obx(() => Text("count1 -> " + count.toString())),
            // Obx((){
            //   return Text("count1 -> ${count.toString()}" + );
            // }),
            ElevatedButton(
              onPressed: () {
                count.value++;
              },
              child: Text("add"),
            ),
          ],
        )
      ),
    );
  }
}