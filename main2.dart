// //此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
// //动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_money/app_recyclelife_page.dart';
// import 'package:flutter_money/file_example.dart';
// import 'package:flutter_money/flutter_widget_lifecycle.dart';
// import 'package:flutter_money/layout_demo.dart';
// import 'package:flutter_money/notification_demo.dart';
// import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
// import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
// import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
// import 'package:flutter_money/provide/provider_example/provide_demo.dart';
// import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
// import 'package:flutter_money/provide/selector_example/provide_demo.dart';
// import 'package:flutter_money/sharedpreference.dart';
// import 'package:flutter_money/sqflite_demo.dart';
// import 'package:flutter_money/statefulwidget_demo.dart';
// import 'package:flutter_money/test/test.dart';
// import 'package:flutter_money/test_extension_widget.dart';
// import 'package:flutter_money/utils/router.dart';
// import 'package:flutter_money/view/custom_appbar.dart';
// import 'package:flutter_money/wajiu/dsfdsfds.dart';
// import 'package:flutter_money/widget/dialog_demo.dart';
// import 'package:flutter_money/widget/weiget_main.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'channel.dart';
// import 'http/dio_demo.dart';
// import 'http/futurebuild_demo.dart';
// import 'http/http_demo.dart';
// import 'launch_page.dart';
// import 'layout/align.dart';
// import 'layout/container_widget.dart';
// import 'layout/fittedbox_layout.dart';
// import 'layout/flex_layout.dart';
// import 'layout/linearlayout.dart';
// import 'layout/linearlayout2.dart';
// import 'layout/scaffold_layout.dart';
// import 'scroll/scroll_widget.dart';
// import 'layout/size_container.dart';
// import 'layout/stack_positioned.dart';
// import 'layout/wrap_flow.dart';
// import 'statelesswidget_demo.dart';
// import 'extension.dart'; //扩展方法
// import 'extension2.dart' hide StringExtension2;
// import 'view/custom_materialapp.dart'; //扩展方法
// // import 'statefulwidget_demo.dart';
//
// //Flutter 应用中 main 函数为应用程序的入口。main 函数中调用了runApp 方法，它的功能是启
// //动Flutter应用。runApp它接受一个 Widget参数，
// //main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
//
//
// /**
//  * 这个类中使用的是系统提供的路由跳转，新的main中使用的是getx的路由跳转
//  */
// void main() {
//   //这里必须设置，否则会报：Shared preferences，No implementation found for method getAll on channel plugins.flutter.
//   SharedPreferences.setMockInitialValues({});
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //去除半透明状态栏，设置完成后需要重新运行下项目才会生效
//     if (Theme.of(context).platform == TargetPlatform.android) {
//       // android 平台
//       SystemUiOverlayStyle _style =
//           SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//       SystemChrome.setSystemUIOverlayStyle(_style);
//     }
//
//     //扩展方法
//     print("调用扩展方法");
//     print("#90F7EC".toColor());
//
//     //屏幕适配，入口初始化一次
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         //MaterialApp 是Material 库中提供的 Flutter APP 框架，通过它可以设置应用的名
//         //称、主题、语言、首页及路由列表等。MaterialApp也是一个 widget。
//         return CustomMaterialApp(
//           title: 'Flutter Demo',
//           home: Scaffold(
//               appBar: CustomAppbar(
//                 title: '主页',
//                 showLeftArrow: false,
//                 callback: () => print("我是主页"),
//                 context: context,
//               ),
//               body: RouteNavigator()), //home 为 Flutter 应用的首页，它也是一个 widget。
//           routes: RouterUtils.getRouter()
//           );
//       },
//
//       // child: const HomePage(title: 'First Method'),
//     );
//   }
// }
//
// class RouteNavigator extends StatefulWidget {
//   const RouteNavigator({Key? key}) : super(key: key);
//
//   @override
//   _RouteNavigatorState createState() => _RouteNavigatorState();
// }
//
// class _RouteNavigatorState extends State<RouteNavigator> {
//   bool byName = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//         child: SingleChildScrollView(
//             child: Column(
//       children: <Widget>[
//         SwitchListTile(
//             title: Text('${byName ? '' : '不'}通过路由名跳转'),
//             value: byName,
//             onChanged: (value) {
//               setState(() {
//                 byName = value;
//               });
//             }),
//         _item('StatelessWidget组件的使用', StatelessWidgetDemo(), 'statelesswidget'),
//         _item('StatefulWidget组件的使用', StatefulWidgetDemo(), 'statefulwidget'),
//         _item('布局的使用', LayoutDemoWidget(), 'layoutwidget'),
//         // _item('flutter和原生通信', const PlatformChannel(), 'channel'),
//         _item('打开第三方应用', LaunchPage(), 'launchpage'),
//         _item('http请求', HttpDemo(), 'http'),
//         _item('futurebuilder使用', FutureBuilderDemo(), 'futurebuilder'),
//         _item('dio使用', DioDemo(), 'dio'),
//         _item('测试扩展方法在Widget中的使用', TestExtensionWidget(),
//             'test_extension_widget'),
//         _item('各个组件', WeigetMain(), 'weiget_main'),
//         _item('尺寸限制类容器', SizeContainer(), 'sizecontainer'),
//         _item('线性布局', LinearLayout(), 'linearlayout'),
//         _item('Column嵌套Column或者Row嵌套Row的情况', LinearLayout2(), 'linearlayout2'),
//         _item('Flex布局', FlexLayout(), 'flex_layout'),
//         _item('流式布局-Wrap，Flow', WrapAddFlow(), 'wrapaddflow'),
//         _item(
//             '层叠布局-Stack,Positioned', StackAddPositioned(), 'stack_positioned'),
//         _item('对齐与相对定位（Align）', AlianWidget(), 'align_widget'),
//         _item('容器类组件', ContainerWidget(), 'container_widget'),
//         _item('空间适配', FittedBoxLayout(), 'fittedbox_layout'),
//         _item('页面骨架', ScaffoldLayout(), 'scaffold_layout'),
//         _item('可滚动组件', ScrollWidget(), 'scroll_widget'),
//         _item('Dialog', DialogDemo(), 'dialog'),
//         _item('Notification', NotificationDemo(), 'notification'),
//         _item('SharedPreference数据存储', SharedPreferenceWidget(),
//             'sharedpreference'),
//         _item('test', Test(), 'test'),
//         _item('wajiu_main_page', WajiuMainPage(), 'wajiu_main_page'),
//         _item('provider_example', ProvideDemo(), 'provider_example'),
//         _item(
//             'provider_count_example', ProvideDemo2(), 'provider_count_example'),
//         _item('changenotifier_provider_example', ProvideDemo3(),
//             'changenotifier_provider_example'),
//         _item('selector_provider_example', ProvideDemo4(),
//             'changenotifier_provider_example'),
//         _item('inderited_provider_example', ProvideDemo5(),
//             'inderited_provider_example'),
//         _item('mvvm_provider_example', ProvideDemo6(), 'mvvm_provider_example'),
//         _item('file_example', FileExample(), 'file_example'),
//         _item('sqflite_example', SqfliteDemo(), 'sqflite_example'),
//         //App的生命周期
//         _item('app_recyclelife', AppRecycleLifePage(), 'app_recyclelife'),
//         //Widget的生命周期
//         _item('widget_recyclelife', WidgetLifecycle(), 'widget_recyclelife'),
//       ],
//     )));
//   }
//
//   _item(String title, page, String routeName) {
//     return Container(
//       child: RaisedButton(
//         onPressed: () {
//           if (byName) {
//             Navigator.pushNamed(context, routeName);
//           } else {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => page));
//           }
//         },
//         child: Text(title),
//       ),
//     );
//   }
// }
