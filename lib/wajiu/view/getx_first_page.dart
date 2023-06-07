
import 'package:flutter/material.dart';
import 'package:flutter_money/controller/first_add_second_controller.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:get/get.dart';

import 'getx_second_page.dart';

class GetxFirstPageView extends StatefulWidget {
  @override
  _GetxFirstPageViewState createState() => _GetxFirstPageViewState();
}


class _GetxFirstPageViewState extends State<GetxFirstPageView> {
@override
  void initState() {
    super.initState();
    Get.put<FirstAddSecondController>(FirstAddSecondController());

  }
  @override
  Widget build(BuildContext context) {
    FirstAddSecondController controller = Get.find<FirstAddSecondController>();
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "第一个页面",),
        body: Column(
          children: [
            GetX<FirstAddSecondController>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return Text("${controller.count}");
              },
            ),
            ElevatedButton(onPressed: (){
              controller.add();
            }, child: Text("Click")),
            ElevatedButton(onPressed: (){
              GetNavigationUtils.navigateRightToLeft(GetxSecondPageView());
            }, child: Text("跳转到第二个页面")),
          ],
        ),
      ),
    );
  }
}
