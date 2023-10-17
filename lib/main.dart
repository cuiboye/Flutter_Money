//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_money/animation/custom_animation.dart';
import 'package:flutter_money/home_page.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/router.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'statefulwidget_demo.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'extension.dart';
import 'utils/sp.dart'; //扩展方法

@pragma('vm:entry-point')
void downloadCallback(
    String id,
    int status,
    int progress,
    ) {
  print(
    'Callback on background isolate: '
        'task ($id) is in status ($status) and process ($progress)',
  );

  IsolateNameServer.lookupPortByName('downloader_send_port')
      ?.send([id, status, progress]);
}

//Flutter 应用中 main 函数为应用程序的入口。main 函数中调用了runApp 方法，它的功能是启
//动Flutter应用。runApp它接受一个 Widget参数，
//main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
void main() async{
  //这里必须设置，否则会报：Shared preferences，No implementation found for method getAll on channel plugins.flutter.
  // SharedPreferences.setMockInitialValues({});//这个为flutter2.0的设置，现在不用了，2.0上使用有问题，重启app后数据获取失败

  //解决Porvider莫名其妙的一个错误，建议设置如下语句
  Provider.debugCheckInvalidValueType = null;


  //这里处理的是组件异常
  Widget error = const Text('...rendering error...');
  error = Scaffold(body: Center(child: error));
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;

  //下面这两句是初始化SharedPreference
  WidgetsFlutterBinding.ensureInitialized();
  await Sp.perInit();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(downloadCallback, step: 1);

  //处理全局的错误
  FlutterError.onError = (FlutterErrorDetails details) async {
    // 转发至 Zone 的错误回调
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  //runZoned中可以处理运行中的异常
  runZoned<Future<void>>(() async {
    // runApp(const ColorFiltered(
    //     colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
    //     child: MyApp()));//黑白屏
    runApp( const MyApp());
  }, onError: (error, stackTrace) async {
    print("========> ${error.toString()}");
  });

  PaintingBinding.instance.imageCache.maximumSize =100000;
  PaintingBinding.instance?.imageCache?.maximumSizeBytes =
      300 << 20;

  // String appMarket = EnvironmentConfig.CHANNEL;
  // String debug = EnvironmentConfig.DEBUG;
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
// class _SplashState extends State<MyApp> with NavigatorObserver{
class _SplashState extends State<MyApp>{
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
      const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent
      );
      SystemChrome.setSystemUIOverlayStyle(_style);
      print("当前设备平台为：${TargetPlatform.android}");
    }

    //扩展方法
    print("调用扩展方法");
    print("#90F7EC".toColor());
    //屏幕适配，入口初始化一次
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        //如果使用Getx的功能，需要将GetMaterialApp替换MaterialApp
        return GetMaterialApp(
            //功能图层会在当时运用的最上层，以 Flutter 引擎自绘的办法展现 GPU 与 UI 线程的履行图表
            showPerformanceOverlay: false,
            //去除右上角的"DEBUG"水印
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Image.asset("images/launchimage.jpg", fit: BoxFit.fill),//背景图
            routes: RouterUtils.getRouter(),
            //初始化EasyLoading加载圈
            builder: EasyLoading.init(),
          //国际化设置
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          //国际化设置的语言，这里设置为中文，在这里设置后，如果涉及到和日期相关需要设置国际化的话，日期组件showDatePicker中就不需要设置了
          supportedLocales: const [
            Locale('zh', 'CN'), //设置语言为中文
          ],
          // getPages: RouterUtils.getPages,//设置路由集合的另一种方法
          // initialRoute: "/main",//初始化路由
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}
//同一个类文件中的顶层办法，能够拜访类的私有变量和办法
void test(){
  EnvironmentConfig config = EnvironmentConfig();
  config._play();
  debugPrint('${config._count}');
}

class EnvironmentConfig {
  static const CHANNEL = String.fromEnvironment('CHANNEL');
  //DEBUG = Y 是调试模式，其他为生产模式
  static const DEBUG = String.fromEnvironment('DEBUG');
  var _count = 10;
  void _play(){

  }
}

class FatherInterface{
  int money = 0;
  int count = 0;
  int get getMoney =>money;
  int get getCount =>count;
}

class Son implements FatherInterface{
  @override
  int money = 0;

  @override
  // TODO: implement getMoney
  int get getMoney => throw UnimplementedError();

  @override
  int count = 0;

  @override
  // TODO: implement getCount
  int get getCount => throw UnimplementedError();

}

