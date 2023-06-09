import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/bindings/getx_with_dio_binding.dart';
import 'package:flutter_money/bindings/orderlist_with_getconnect_binding.dart';
import 'package:flutter_money/bindings/statemixin_binding.dart';
import 'package:flutter_money/controller/getx_work_controller.dart';
import 'package:flutter_money/getbuilder_view.dart';
import 'package:flutter_money/getx/state/other_page.dart';
import 'package:flutter_money/getx_work_view.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/valuebuilder_view.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/view/statemixin_view.dart';
import 'package:flutter_money/wajiu/view/getconnect_pagev_view.dart';
import 'package:flutter_money/wajiu/view/getx_first_page.dart';
import 'package:flutter_money/wajiu/view/getx_with_dio_view.dart';
import 'package:flutter_money/widget/getx_obs_demo.dart';
import 'package:flutter_money/widget/getxcontroller_demo.dart';
import 'package:get/get.dart';

import 'Controller.dart';

/**
 * getx-响应式状态管理器
 *
 */
class GetXStateDemo extends StatefulWidget {
  @override
  _GetXStateDemoState createState() => _GetXStateDemoState();
}

class _GetXStateDemoState extends State<GetXStateDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(context: context,
            title: "getX-Navigation（第一个页面）",
          ),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () =>
                      GetNavigationUtils.navigateRightToLeft(GetXObsDemo()),
                  child: Text(".obs测试")
              ),
              ElevatedButton(
                  onPressed: () =>
                      GetNavigationUtils.navigateRightToLeft(GetxControllerDemo()),
                  child: Text("通过Getx-Controller来改变状态")
              ),
              ElevatedButton(
                  onPressed: () =>
                      GetNavigationUtils.navigateRightToLeft(GetBuilderView()),
                  child: Text("通过GetxBuilder-Controller来,改变状态")
              ),
              ElevatedButton(
                  onPressed: () =>
                      GetNavigationUtils.navigateRightToLeft(StateWorkersView()),
                  child: Text("通过Getx-works来改变状态")
              ),
              ElevatedButton(
                  onPressed: () =>
                  Get.to(GetXWithDioView(), binding: GetxWithDioBinding()),
                  // GetNavigationUtils.navigateRightToLeft(GetXWithDioView()),
                  child: Text("通过Getx+GetView+Bindings+Controller+Dio获取网络数据")
              ),
              ElevatedButton(
                  onPressed: () =>
                      Get.to(GetxFirstPageView()),
                  child: Text("两个页面共享数据")
              ),
              ElevatedButton(
                  onPressed: () =>
                      Get.to(GetConnectPageView(),binding: OrderListWithGetConnectBinding()),
                  child: Text("SuperController（GetConnect）+GetView+Bindings+GetConnect（Dio）")
              ),
              ElevatedButton(
                  onPressed: () =>
                      Get.to(StateMixinView(""),binding: StateMixinBinding()),
                  child: Text("StateMixin+change()")
              ),
            ],
          )
      ),
    );
  }
}


