//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/home_page.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/router.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'statefulwidget_demo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'extension.dart'; //扩展方法
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

  PaintingBinding.instance.imageCache.maximumSize =100000;
  PaintingBinding.instance?.imageCache?.maximumSizeBytes =
      300 << 20;
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

  void handleTimeOut(){//倒计时结束回调
    print("+++++++++++++++++++++1");
    //TODO HomePageWidget这个为测试用的页面
    GetNavigationUtils.navigateRightToLeftWithOff(HomePageWidget());
    // GetNavigationUtils.navigateRightToLeftWithOff(WajiuMainPage());
  }
  
  @override
  Widget build(BuildContext context) {
    //去除半透明状态栏，设置完成后需要重新运行下项目才会生效
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(_style);
      print("当前设备平台为：${TargetPlatform.android}");
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
          home: Image.asset("images/launchimage.jpg",fit: BoxFit.fill),
          routes: RouterUtils.getRouter(),
          // // RouterUtils.getRouter()
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}


