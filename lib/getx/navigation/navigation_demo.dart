import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/model/navigation_params.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:provider/provider.dart';

import 'navigation_demo2.dart';

/**
 * getX Navigation跳转操作
 */
class NavigationDemo extends StatefulWidget {
  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    print("=============> NavigationDemo build");
    return ChangeNotifierProvider<NavigationParams>(
      //create为监听的模型
        create: (_) => NavigationParams(),
        child: CustomMaterialApp(
          home: Scaffold(
            appBar: CustomAppbar(context: context,
              title: "getX-Navigation（第一个页面）",
            ),
            body: Column(
              children: [
                ElevatedButton(
                    onPressed: () =>
                        GetNavigationUtils.navigateWithName(
                            "navigation_page2"),
                    child: Text("通过名称跳转")
                ),
                ElevatedButton(
                    onPressed: () =>
                        GetNavigationUtils.navigateRightToLeft(
                            NavigationPage2()),
                    child: Text("通过非名称跳转")
                ),
                ElevatedButton(
                    onPressed: () =>
                        GetNavigationUtils.navigateRightToLeftWithParams(
                            NavigationPage2(),"第一个页面的参数")?.then((value) => {
                              print("$value")
                        }),
                    child: Text("通过非名称跳转，传递参数")
                ),
                Text("dsds"),
              ],
            )
          ),
        )
    );
  }

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
}
