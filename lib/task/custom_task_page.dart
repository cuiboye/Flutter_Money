import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/task/CustomTaskController.dart';
import 'package:flutter_money/task/left_right_wight.dart';
import 'package:get/get.dart';

/**
 * 任务详情
 */
class CustomTaskPagePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
   CustomTaskController controller = Get.put(CustomTaskController());

   return Scaffold(
       appBar: AppBar(
         title: const Text("任务详情"),
       ),
       body: Column(
         children: [
           LeftRightWiget(leftText: "关联客户",rightText: "张飞"),
           LeftRightWiget(leftText: "跟进目标",rightText: "张飞2",),
           LeftRightWiget(leftText: "开始时间",rightText: controller.selectedDate,onTap: ()=>controller.selectDatePicker(context))
         ],
       )
   );
  }
}



  // void test(){
  //   final now = DateTime.now();
  //   print("$now");
  //   final berlinWallFell = DateTime.utc(1989, 11, 9);
  //   print("$berlinWallFell");
  //   final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');// 8:18pm
  //   print("$moonLanding");
  // }
