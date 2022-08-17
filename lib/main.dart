//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/ExpansionTileSample.dart';
import 'package:flutter_money/app_recyclelife_page.dart';
import 'package:flutter_money/channel/channer_main.dart';
import 'package:flutter_money/file_example.dart';
import 'package:flutter_money/flutter_widget_lifecycle.dart';
import 'package:flutter_money/inherited_widget_example.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/notification_demo.dart';
import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/provide/selector_example/provide_demo.dart';
import 'package:flutter_money/sharedpreference.dart';
import 'package:flutter_money/sqflite_demo.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'package:flutter_money/test/test.dart';
import 'package:flutter_money/test_extension_widget.dart';
import 'package:flutter_money/utils/router.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/webview_native.dart';
import 'package:flutter_money/widget/dialog_demo.dart';
import 'package:flutter_money/widget/stagger_animation_example.dart';
import 'package:flutter_money/widget/weiget_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        //MaterialApp 是Material 库中提供的 Flutter APP 框架，通过它可以设置应用的名
        //称、主题、语言、首页及路由列表等。MaterialApp也是一个 widget。
        return GetMaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
              appBar: CustomAppbar(
                title: '主页',
                showLeftArrow: false,
                callback: () => print("我是主页"),
                context: context,
              ),
              body: RouteNavigator()), //home 为 Flutter 应用的首页，它也是一个 widget。
          // routes:<String, WidgetBuilder>{
          //   RouterUtils.getRouter()
          // }
        //   getPages: [
        //     GetPage(name: "/navigation_page", page: () => NavigationDemo()),
        //     GetPage(name: "/navigation_page2", page: () => NavigationPage2()),
        //     GetPage(name: "/navigation_page3", page: () => NavigationPage3()),
        // ]);
          routes: RouterUtils.getRouter(),
          // // RouterUtils.getRouter()
          );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}

class RouteNavigator extends StatefulWidget {
  const RouteNavigator({Key? key}) : super(key: key);

  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        _item('StatelessWidget组件的使用', StatelessWidgetDemo(), 'statelesswidget'),
        _item('StatefulWidget组件的使用', StatefulWidgetDemo(), 'statefulwidget'),
        _item('布局的使用', LayoutDemoWidget(), 'layoutwidget'),
        // _item('flutter和原生通信', const PlatformChannel(), 'channel'),
        _item('打开第三方应用', LaunchPage(), 'launchpage'),
        _item('http网络请求', HttpDemo(), 'http'),
        _item('FutureBuilder使用', FutureBuilderDemo(), 'futurebuilder'),
        _item('Dio使用', DioDemo(), 'dio'),
        _item('测试扩展方法在Widget中的使用', TestExtensionWidget(),
            'test_extension_widget'),
        _item('各个组件', WeigetMain(), 'weiget_main'),
        _item('尺寸限制类容器', SizeContainer(), 'sizecontainer'),
        _item('线性布局', LinearLayout(), 'linearlayout'),
        _item('Column嵌套Column或者Row嵌套Row的情况', LinearLayout2(), 'linearlayout2'),
        _item('Flex布局', FlexLayout(), 'flex_layout'),
        _item('流式布局-Wrap，Flow', WrapAddFlow(), 'wrapaddflow'),
        _item(
            '层叠布局-Stack,Positioned', StackAddPositioned(), 'stack_positioned'),
        _item('对齐与相对定位（Align）', AlianWidget(), 'align_widget'),
        _item('容器类组件', ContainerWidget(), 'container_widget'),
        _item('空间适配', FittedBoxLayout(), 'fittedbox_layout'),
        _item('页面骨架', ScaffoldLayout(), 'scaffold_layout'),
        _item('可滚动组件', ScrollWidget(), 'scroll_widget'),
        _item('Dialog', DialogDemo(), 'dialog'),
        _item('Notification通知', NotificationDemo(), 'notification'),
        _item('SharedPreference数据存储', SharedPreferenceWidget(),
            'sharedpreference'),
        _item('测试', Test(), 'test'),
        _item('挖酒相关', WajiuMainPage(), 'wajiu_main_page'),
        _item('Provider的例子', ProvideDemo(), 'provider_example'),
        _item(
            'Provider计数器', ProvideDemo2(), 'provider_count_example'),
        _item('ChangeNotifierProvider', ProvideDemo3(),
            'changenotifier_provider_example'),
        _item('Provider_Selector相关', ProvideDemo4(),
            'changenotifier_provider_example'),
        _item('inderited_provider_example', ProvideDemo5(),
            'inderited_provider_example'),
        _item('Provider+MVVM', ProvideDemo6(), 'mvvm_provider_example'),
        _item('文件操作', FileExample(), 'file_example'),
        _item('Sqflite数据库', SqfliteDemo(), 'sqflite_example'),
        //App的生命周期
        _item('App的生命周期', AppRecycleLifePage(), 'app_recyclelife'),
        //Widget的生命周期
        _item('Widget的生命周期', WidgetLifecycle(), 'widget_recyclelife'),
        _item('navigation_page', NavigationDemo(), 'navigation_page'),
        _item('GetX_State', GetXStateDemo(), 'getx_state_demo'),
        _item('Flutter和Native通信', ChannerMain(), 'channer_main'),
        _item('Webview以及和js交互', WebViewNativeDemo(), 'channer_main'),
        _item('InheritedWidget的使用', InheritedWidgetTestRoute(), 'inderited_widget_test_router'),
        _item('异常处理', CatchError(), 'catch_error'),
        _item('多级可展开的列表', ExpansionTileSample(), 'expansiontile_sample'),
        _item('动画的基本使用', AnimationMain(), 'animation_main'),
        _item('AnimatedWidget的使用', AnimatedWidgetExample(), 'animatedwidget_example'),
        _item('AnimatedBuilder的使用', AnimatedBuilderExample(), 'animatedbuild_example'),
        _item('组合动画', StaggerAnimationExample(), 'stagger_animation'),
        _item('动画切换组件', AnimatedSwitcherExample(), 'animatedswitch_example'),
      ],
    )));
  }

  _item(String title,  dynamic page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            print("routeName:$routeName");
            Get.toNamed(routeName);
            // Navigator.pushNamed(context, routeName);
          } else {
            print("======当前页面：$page");
            Get.to(page,
                // duration: Duration(seconds: 3),
                //跳转动画，进入时从右到左，退出时从左到右
                transition: Transition.rightToLeft
            );
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}

