import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * App生命周期
 */
class AppRecycleLifePage extends StatefulWidget {
  @override
  _AppRecycleLifePageState createState() => _AppRecycleLifePageState();
}

class _AppRecycleLifePageState extends State<AppRecycleLifePage> with WidgetsBindingObserver{
  @override
  void initState() {
    debugPrint("initState");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Column(
          children: [

          ],
        ),
        appBar:CustomAppbar(
          title: 'App生命周期',
          context: context,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('state = $state');
    if (state == AppLifecycleState.paused) {
      debugPrint('App进入后台');
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('App进去前台');
    } else if (state == AppLifecycleState.inactive) {
      //不常用：应用程序处于非活动状态，并且未接收用户输入时调用，比如：来了个电话
    } else if (state == AppLifecycleState.detached) {
      //不常用：应用程序被挂起是调用，它不会在iOS上触发
    }
  }

  @override
  void dispose() {
    //不用的时候记得移除它
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("dispose");
    super.dispose();
  }
}
