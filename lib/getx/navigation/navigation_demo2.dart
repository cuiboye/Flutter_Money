import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'navigation_demo3.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

/**
 * getX Navigation  第二个页面
 */
class NavigationPage2 extends StatefulWidget {
  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationPage2> {

  @override
  void initState() {
    //接收参数
    String arguments = Get.arguments;
    print("initState: ${arguments}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //在这里接收参数
    String arguments = Get.arguments;
    print("${arguments}");
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(context: context,
            title: "getX-Navigation（第二个页面）",
          ),
          body:Column(
            children: [
              ElevatedButton(
                  onPressed: ()=>{GetNavigationUtils.navigateRightToLeftWithAllOff(NavigationPage3())},
                  child: Text("跳转到第三个页面,从第三个页面点击返回将返回到第一个页面")
              ),
              ElevatedButton(
                  onPressed: ()=>{GetNavigationUtils.navigateRightToLeftWithOff(NavigationPage3())},
                  child: Text("跳转到下一个页面，这个页面销毁")
              ),
              ElevatedButton(
                  onPressed: ()=>{
                    Get.back(result: "我是第二个页面返回的数据")
                  },
                  child: Text("返回到第一个页面，携带参数")
              ),
            ],
          )
      ),
    );
  }
}
