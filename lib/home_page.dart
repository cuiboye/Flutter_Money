//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/ExpansionTileSample.dart';
import 'package:flutter_money/app_recyclelife_page.dart';
import 'package:flutter_money/channel/channer_main.dart';
import 'package:flutter_money/device_info_main.dart';
import 'package:flutter_money/drop_select_menu/drop_select_demo_page.dart';
import 'package:flutter_money/file_example.dart';
import 'package:flutter_money/flutter_widget_lifecycle.dart';
import 'package:flutter_money/honor_demo_page.dart';
import 'package:flutter_money/inherited_widget_example.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/list_scroll_dock_page.dart';
import 'package:flutter_money/notification_demo.dart';
import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/provide/selector_example/provide_demo.dart';
import 'package:flutter_money/pull_refresh.dart';
import 'package:flutter_money/route_demo_page.dart';
import 'package:flutter_money/sharedpreference.dart';
import 'package:flutter_money/sqflite_demo.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'package:flutter_money/test/test.dart';
import 'package:flutter_money/test_extension_widget.dart';
import 'package:flutter_money/utils/router.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/wajiu/wajiu_login.dart';
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

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //扩展方法
    print("调用扩展方法");
    print("#90F7EC".toColor());

    return Scaffold(
        appBar: CustomAppbar(
          title: '主页',
          showLeftArrow: true,
          callback: () => print("我是主页"),
          context: context,
        ),
        body: RouteNavigator()); //home 为 Flutter 应用的首页，它也是一个 widget。
        // body: Text("sdfds")
    // child: const HomePage(title: 'First Method'),
    return Text("sdfdsfdsdf");
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
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("ListView和PageView花式嵌套可以查看:"),
           Text("1)ListViewNestVP 垂直  ListView 嵌套垂直  ViewPager，"),
           Text("2)VPNestListView，垂直  ViewPager 嵌套垂直 ListView"),
           Text("3)ListViewLinkListView，垂直  ListView 联动  ListView"),
           Text("4)VPListView ListView 嵌套 ViewPager 解决斜着滑动问题"),
         ],
       ),
        SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        _item('列表停靠', ListScrollDockPage(), 'listscrolldockpage'),
        _item('测试路由嵌套', RouteDemoPage(), 'routedemopage'),
        _item('下拉筛选', DropSelectDemoPage(), 'dropselectdemopage'),
        _item('StatelessWidget组件的使用', StatelessWidgetDemo(), 'statelesswidget'),
        _item('共性元素动画', HonorDemoPage(), 'honordemopage'),
        _item('wajiuLogin', WajiuLogin(), 'wajiuLogin'),
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
        _item('Provider计数器', ProvideDemo2(), 'provider_count_example'),
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
        _item('InheritedWidget的使用', InheritedWidgetTestRoute(),
            'inderited_widget_test_router'),
        _item('异常处理', CatchError(), 'catch_error'),
        _item('多级可展开的列表', ExpansionTileSample(), 'expansiontile_sample'),
        _item('动画的基本使用', AnimationMain(), 'animation_main'),
        _item('AnimatedWidget的使用', AnimatedWidgetExample(),
            'animatedwidget_example'),
        _item('AnimatedBuilder的使用', AnimatedBuilderExample(),
            'animatedbuild_example'),
        _item('组合动画', StaggerAnimationExample(), 'stagger_animation'),
        _item('动画切换组件', AnimatedSwitcherExample(), 'animatedswitch_example'),
        _item('百度地图', MapMainExample(), 'map_main_example'),
        _item('极光推送', JiguangPushMain(), 'jiguang_push'),
        _item('上拉刷新下拉加载', PullRefreshMain(), 'pull_refresh_main'),
        _item('获取设备信息', DeviceInfoMain(), 'device_info'),
        _item('MediaQuery优化', MediaQueryYouhuaExample(),
            'mediaquery_youhua_example'),
      ],
    )));
  }

  _item(String title, dynamic page, String routeName) {
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
                transition: Transition.rightToLeft);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
