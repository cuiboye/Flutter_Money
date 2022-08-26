//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/ExpansionTileSample.dart';
import 'package:flutter_money/app_recyclelife_page.dart';
import 'package:flutter_money/channel/channer_main.dart';
import 'package:flutter_money/device_info_main.dart';
import 'package:flutter_money/file_example.dart';
import 'package:flutter_money/flutter_widget_lifecycle.dart';
import 'package:flutter_money/home_page.dart';
import 'package:flutter_money/inherited_widget_example.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/notification_demo.dart';
import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/provide/selector_example/provide_demo.dart';
import 'package:flutter_money/pull_refresh.dart';
import 'package:flutter_money/sharedpreference.dart';
import 'package:flutter_money/sqflite_demo.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'package:flutter_money/test/test.dart';
import 'package:flutter_money/test_extension_widget.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/router.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/webview_native.dart';
import 'package:flutter_money/widget/dialog_demo.dart';
import 'package:flutter_money/widget/stagger_animation_example.dart';
import 'package:flutter_money/widget/weiget_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'animated_switcher.dart';
import 'animation_main.dart';
import 'animation_widget.dart';
import 'animationbuild_example.dart';
import 'catch_error.dart';
import 'channel.dart';
import 'getx/state/getx_state.dart';
import 'http/dio_demo.dart';
import 'http/futurebuild_demo.dart';
import 'http/http_demo.dart';
import 'inherited_widget_test.dart';
import 'jiguang_push_main.dart';
import 'launch_page.dart';
import 'layout/align.dart';
import 'layout/container_widget.dart';
import 'layout/fittedbox_layout.dart';
import 'layout/flex_layout.dart';
import 'layout/linearlayout.dart';
import 'layout/linearlayout2.dart';
import 'layout/scaffold_layout.dart';
import 'getx/navigation/navigation_demo.dart';
import 'getx/navigation/navigation_demo3.dart';
import 'map/map_example.dart';
import 'mediaquery_youhua.dart';
import 'scroll/scroll_widget.dart';
import 'layout/size_container.dart';
import 'layout/stack_positioned.dart';
import 'layout/wrap_flow.dart';
import 'statelesswidget_demo.dart';
import 'extension.dart'; //扩展方法
import 'extension2.dart' hide StringExtension2;
import 'view/custom_materialapp.dart'; //扩展方法
// import 'statefulwidget_demo.dart';
import 'package:get/get.dart';
//Flutter 应用中 main 函数为应用程序的入口。main 函数中调用了runApp 方法，它的功能是启
//动Flutter应用。runApp它接受一个 Widget参数，
//main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
void main() async{
  //这里必须设置，否则会报：Shared preferences，No implementation found for method getAll on channel plugins.flutter.
  SharedPreferences.setMockInitialValues({});


  //处理全局的错误
  FlutterError.onError = (FlutterErrorDetails details) async {
    // 转发至 Zone 的错误回调
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  Widget error = const Text('...rendering error...');
  error = Scaffold(body: Center(child: error));
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;

  runZoned<Future<void>>(() async {
    runApp(const MyApp());
  }, onError: (error, stackTrace) async {
    print("========> ${error.toString()}");
  });
}

void setCustomErrorPage(){
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails){
    print("========> ${flutterErrorDetails.toString()}");
    return Center(
      child: Text("Flutter 走神了"),
    );
  };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<MyApp> with NavigatorObserver{
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  void startTimeout(){
    Timer(Duration(seconds: 2), handleTimeOut);
  }

  void handleTimeOut(){//倒计时回调
    print("+++++++++++++++++++++1");
    GetNavigationUtils.navigateRightToLeftWithOff(HomePageWidget());
  }
  
  @override
  Widget build(BuildContext context) {
    //去除半透明状态栏，设置完成后需要重新运行下项目才会生效
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(_style);
    }

    //扩展方法
    print("调用扩展方法");
    print("#90F7EC".toColor());

    //屏幕适配，入口初始化一次
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        //如果使用Getx的功能，需要将GetMaterialApp替换MaterialApp
        return GetMaterialApp(
          //去除右上角的"DEBUG"水印
          debugShowCheckedModeBanner:false,
          title: 'Flutter Demo',
          home: Image.asset("images/welcome.png",fit: BoxFit.fill),
          routes: RouterUtils.getRouter(),
          // // RouterUtils.getRouter()
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}


