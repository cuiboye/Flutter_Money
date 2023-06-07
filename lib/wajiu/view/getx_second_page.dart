import 'package:flutter/material.dart';
import 'package:flutter_money/controller/first_add_second_controller.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:get/get.dart';

import '../../view/custom_appbar.dart';
class GetxSecondPageView extends StatefulWidget {
  @override
  _GetxSecondPageViewState createState() => _GetxSecondPageViewState();
}

class _GetxSecondPageViewState extends State<GetxSecondPageView> {
  @override
  Widget build(BuildContext context) {
    FirstAddSecondController controller = Get.find<FirstAddSecondController>();
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "第二个页面",),
        body: Text("${controller.count}"),
      ),
    );
  }
}