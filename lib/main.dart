//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/layout/animatedlist.dart';
import 'package:flutter_money/layout/customscrollview_add_slivers.dart';
import 'package:flutter_money/layout/tabbarview.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/notification_demo.dart';
import 'package:flutter_money/scroll/listview_widget.dart';
import 'package:flutter_money/scroll/scrollbar_widget.dart';
import 'package:flutter_money/scroll/scrollcontroller.dart';
import 'package:flutter_money/scroll/singlechildscrollview.dart';
import 'package:flutter_money/sharedpreference.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'package:flutter_money/test/test.dart';
import 'package:flutter_money/test_extension_widget.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/wajiu/personal_page.dart';
import 'package:flutter_money/widget/button_demo.dart';
import 'package:flutter_money/widget/dialog_demo.dart';
import 'package:flutter_money/widget/icon_demo.dart';
import 'package:flutter_money/widget/indicator.dart';
import 'package:flutter_money/widget/input_add_form.dart';
import 'package:flutter_money/widget/switch_selectbox_demo.dart';
import 'package:flutter_money/widget/text_demo.dart';
import 'package:flutter_money/widget/weiget_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'channel.dart';
import 'http/dio_demo.dart';
import 'http/futurebuild_demo.dart';
import 'http/http_demo.dart';
import 'launch_page.dart';
import 'layout/align.dart';
import 'layout/container_widget.dart';
import 'layout/fittedbox_layout.dart';
import 'layout/flex_layout.dart';
import 'layout/gridview_layout.dart';
import 'layout/linearlayout.dart';
import 'layout/linearlayout2.dart';
import 'layout/pageview.dart';
import 'layout/scaffold_layout.dart';
import 'scroll/scroll_widget.dart';
import 'layout/size_container.dart';
import 'layout/stack_positioned.dart';
import 'layout/wrap_flow.dart';
import 'statelesswidget_demo.dart';
import 'extension.dart';//扩展方法
import 'extension2.dart' hide StringExtension2;
import 'view/custom_materialapp.dart';//扩展方法
// import 'statefulwidget_demo.dart';

//Flutter 应用中 main 函数为应用程序的入口。main 函数中调用了runApp 方法，它的功能是启
//动Flutter应用。runApp它接受一个 Widget参数，
//main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
void main() {
  //这里必须设置，否则会报：Shared preferences，No implementation found for method getAll on channel plugins.flutter.
  SharedPreferences.setMockInitialValues({});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //去除半透明状态栏，设置完成后需要重新运行下项目才会生效
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemUiOverlayStyle _style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(_style);
    }

    //扩展方法
    print("调用扩展方法");
    print("#90F7EC".toColor());

    //屏幕适配，入口初始化一次
    return ScreenUtilInit(
      designSize: const Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        //MaterialApp 是Material 库中提供的 Flutter APP 框架，通过它可以设置应用的名
        //称、主题、语言、首页及路由列表等。MaterialApp也是一个 widget。
        return CustomMaterialApp(
          title: 'Flutter Demo',
          home:  Scaffold(
              appBar: CustomAppbar(
                title: '主页',
                showLeftArrow: false,
                callback: () => print("我是主页"), context: context,
              ),
              body: RouteNavigator()
          ),//home 为 Flutter 应用的首页，它也是一个 widget。
          routes:  <String,WidgetBuilder>{
            "statelesswidget":(BuildContext context) => StatelessWidgetDemo(),
            "statefulwidget":(BuildContext context) => StatefulWidgetDemo(),
            "layoutwidget":(BuildContext context) => LayoutDemoWidget(),
            "channel":(BuildContext context) => const PlatformChannel(),
            "launchpage":(BuildContext context) =>  LaunchPage(),
            "http":(BuildContext context) =>  HttpDemo(),
            "dio":(BuildContext context) =>  DioDemo(),
            "futurebuilder":(BuildContext context) =>  FutureBuilderDemo(),
            "test_extension_widget":(BuildContext context) =>  TestExtensionWidget(),
            "weiget_main":(BuildContext context) =>  WeigetMain(),
            "text":(BuildContext context) =>  TextDemo(),
            "button":(BuildContext context) =>  ButtonDemo(),
            "icon":(BuildContext context) =>  IconDemo(),
            "switchaddselectBox":(BuildContext context) =>  SwitchAddSelectBox(),
            "inputaddform":(BuildContext context) =>  InputAddForm(),//输入框和form
            "indicator":(BuildContext context) =>  IndicatorWidget(),//进度指示器
            "sizecontainer":(BuildContext context) =>  SizeContainer(),//尺寸限制类容器
            "linearlayout":(BuildContext context) =>  LinearLayout(),//线性布局
            "linearlayout2":(BuildContext context) =>  LinearLayout2(),//Column嵌套Column或者Row嵌套Row的情况
            "flex_layout":(BuildContext context) =>  FlexLayout(),//Flex布局
            "wrapaddflow":(BuildContext context) =>  WrapAddFlow(),//流式布局-Wrap，Flow
            "stack_positioned":(BuildContext context) =>  StackAddPositioned(),//流式布局-Wrap，Flow
            "align_widget":(BuildContext context) =>  AlianWidget(),//对齐与相对定位（Align）
            "container_widget":(BuildContext context) =>  ContainerWidget(),//容器类组件
            "fittedbox_layout":(BuildContext context) =>  FittedBoxLayout(),//空间适配
            "scaffold_layout":(BuildContext context) =>  ScaffoldLayout(),// 页面骨架
            "scroll_widget":(BuildContext context) =>  ScrollWidget(),// 可滚动组件
            "scrollbar_widget":(BuildContext context) =>  ScrollBarWidget(),// ScrollBar
            "singlechildscrollview":(BuildContext context) =>  SinglechildScrollViewWidget(),// ScrollBar
            "listview_widget":(BuildContext context) =>  ListViewWidget(),// ListView
            "scrollcontroller_widget":(BuildContext context) =>  ScrollControllerWidget(),// ScrollController控制器
            // ignore: equal_keys_in_map
            "animatedlist":(BuildContext context) =>  AnimatedListLayout(),// AnimatedList
            "gridview":(BuildContext context) =>  GridViewLayout(),// gridview
            "pageview":(BuildContext context) =>  PageViewLayout(),// PageView
            "tabbarview":(BuildContext context) =>  TabBarViewLayout(),// PageView
            "customscrollview_slivers":(BuildContext context) =>  CustomScrollViewAddSlivers(),// CustomScrollView 和 Slivers
            "dialog":(BuildContext context) =>  DialogDemo(),// 对话框
            "dialog":(BuildContext context) =>  NotificationDemo(),// Notification
            "sharedpreference":(BuildContext context) =>  SharedPreferenceWidget(),// Notification
            "test":(BuildContext context) =>  Test(),// Test
            "wajiu_main_page":(BuildContext context) =>  WajiuMainPage(),// Test
          },
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
                  title:Text('${byName ? '' : '不'}通过路由名跳转'),
                  value: byName,
                  onChanged: (value) {
                    setState(() {
                      byName = value;
                    });
                  }),
              _item('StatelessWidget组件的使用', StatelessWidgetDemo(), 'statelesswidget'),
              _item('StatefulWidget组件的使用', StatefulWidgetDemo(), 'statefulwidget'),
              _item('布局的使用', LayoutDemoWidget(), 'layoutwidget'),
              _item('flutter和原生通信', const PlatformChannel(), 'channel'),
              _item('打开第三方应用', LaunchPage(), 'launchpage'),
              _item('http请求', HttpDemo(), 'http'),
              _item('futurebuilder使用', FutureBuilderDemo(), 'futurebuilder'),
              _item('dio使用', DioDemo(), 'dio'),
              _item('测试扩展方法在Widget中的使用', TestExtensionWidget(), 'test_extension_widget'),
              _item('各个组件', WeigetMain(), 'weiget_main'),
              _item('尺寸限制类容器', SizeContainer(), 'sizecontainer'),
              _item('线性布局', LinearLayout(), 'linearlayout'),
              _item('Column嵌套Column或者Row嵌套Row的情况', LinearLayout2(), 'linearlayout2'),
              _item('Flex布局', FlexLayout(), 'flex_layout'),
              _item('流式布局-Wrap，Flow', WrapAddFlow(), 'wrapaddflow'),
              _item('层叠布局-Stack,Positioned', StackAddPositioned(), 'stack_positioned'),
              _item('对齐与相对定位（Align）', AlianWidget(), 'align_widget'),
              _item('容器类组件', ContainerWidget(), 'container_widget'),
              _item('空间适配', FittedBoxLayout(), 'fittedbox_layout'),
              _item('页面骨架', ScaffoldLayout(), 'scaffold_layout'),
              _item('可滚动组件', ScrollWidget(), 'scroll_widget'),
              _item('Dialog', DialogDemo(), 'dialog'),
              _item('Notification', NotificationDemo(), 'notification'),
              _item('SharedPreference数据存储', SharedPreferenceWidget(), 'sharedpreference'),
              _item('test', Test(), 'test'),
              _item('wajiu_main_page', WajiuMainPage(), 'wajiu_main_page'),
            ],
          ),
    )
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}

