import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

/**
 * getX Navigation  第三个页面
 */
class NavigationPage3 extends StatefulWidget {
  @override
  _NavigationPage3State createState() => _NavigationPage3State();
}
class _NavigationPage3State extends State<NavigationPage3>  with WidgetsBindingObserver {
  @override
  void initState() {
    print("initState");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      print('App进入后台');
    } else if (state == AppLifecycleState.resumed) {
      print('App进去前台');
    } else if (state == AppLifecycleState.inactive) {
      //不常用：应用程序处于非活动状态，并且未接收用户输入时调用，比如：来了个电话
    } else if (state == AppLifecycleState.detached) {
      //不常用：应用程序被挂起是调用，它不会在iOS上触发
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(context: context,
            title: "getX-Navigation第三个页面（第三个页面）",
          ),
          body:Column(
            children: [
              ElevatedButton(
                  onPressed: ()=>{
                    Get.back(result: "我是第三个页面返回的数据")
                  },
                  child: Text("返回")
              ),
            ],
          )
      ),
    );
  }
}
