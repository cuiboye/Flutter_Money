import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_money/app_recyclelife_page.dart';
import 'package:flutter_money/channel.dart';
import 'package:flutter_money/file_example.dart';
import 'package:flutter_money/flutter_widget_lifecycle.dart';
import 'package:flutter_money/http/dio_demo.dart';
import 'package:flutter_money/http/futurebuild_demo.dart';
import 'package:flutter_money/http/http_demo.dart';
import 'package:flutter_money/launch_page.dart';
import 'package:flutter_money/layout/align.dart';
import 'package:flutter_money/layout/animatedlist.dart';
import 'package:flutter_money/layout/container_widget.dart';
import 'package:flutter_money/layout/customscrollview_add_slivers.dart';
import 'package:flutter_money/layout/fittedbox_layout.dart';
import 'package:flutter_money/layout/flex_layout.dart';
import 'package:flutter_money/layout/gridview_layout.dart';
import 'package:flutter_money/layout/linearlayout.dart';
import 'package:flutter_money/layout/linearlayout2.dart';
import 'package:flutter_money/layout/pageview.dart';
import 'package:flutter_money/layout/scaffold_layout.dart';
import 'package:flutter_money/layout/size_container.dart';
import 'package:flutter_money/layout/stack_positioned.dart';
import 'package:flutter_money/layout/tabbarview.dart';
import 'package:flutter_money/layout/wrap_flow.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/getx/navigation/navigation_demo.dart';
import 'package:flutter_money/notification_demo.dart';
import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/next_page.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/provide/selector_example/provide_demo.dart';
import 'package:flutter_money/scroll/listview_widget.dart';
import 'package:flutter_money/scroll/scroll_widget.dart';
import 'package:flutter_money/scroll/scrollbar_widget.dart';
import 'package:flutter_money/scroll/scrollcontroller.dart';
import 'package:flutter_money/scroll/singlechildscrollview.dart';
import 'package:flutter_money/sharedpreference.dart';
import 'package:flutter_money/sqflite_demo.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'package:flutter_money/statelesswidget_demo.dart';
import 'package:flutter_money/test/test.dart';
import 'package:flutter_money/test_extension_widget.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/wajiu/order_list_page.dart';
import 'package:flutter_money/widget/button_demo.dart';
import 'package:flutter_money/widget/dialog_demo.dart';
import 'package:flutter_money/widget/icon_demo.dart';
import 'package:flutter_money/widget/indicator.dart';
import 'package:flutter_money/widget/input_add_form.dart';
import 'package:flutter_money/widget/switch_selectbox_demo.dart';
import 'package:flutter_money/widget/text_demo.dart';
import 'package:flutter_money/widget/weiget_main.dart';

import '../getx/navigation/navigation_demo2.dart';
import '../getx/state/getx_state.dart';
import '../getx/state/other_page.dart';
import '../main.dart';
import '../getx/navigation/navigation_demo3.dart';


class RouterUtils {
  static Map<String, WidgetBuilder> getRouter() {
    Map<String, WidgetBuilder>? routes = {
      "main": (BuildContext context) => MyApp(),
      "statelesswidget": (BuildContext context) => StatelessWidgetDemo(),
      "statefulwidget": (BuildContext context) => StatefulWidgetDemo(),
      "layoutwidget": (BuildContext context) => LayoutDemoWidget(),
      // "channel": (BuildContext context) => const PlatformChannel(),
      "launchpage": (BuildContext context) => LaunchPage(),
      "http": (BuildContext context) => HttpDemo(),
      "dio": (BuildContext context) => DioDemo(), //Dio的使用
      "futurebuilder": (BuildContext context) => FutureBuilderDemo(),
      "test_extension_widget": (BuildContext context) => TestExtensionWidget(),
      "weiget_main": (BuildContext context) => WeigetMain(),
      "text": (BuildContext context) => TextDemo(),
      "button": (BuildContext context) => ButtonDemo(),
      "icon": (BuildContext context) => IconDemo(),
      "switchaddselectBox": (BuildContext context) => SwitchAddSelectBox(),
      "inputaddform": (BuildContext context) => InputAddForm(),
      //输入框和form
      "indicator": (BuildContext context) => IndicatorWidget(),
      //进度指示器
      "sizecontainer": (BuildContext context) => SizeContainer(),
      //尺寸限制类容器
      "linearlayout": (BuildContext context) => LinearLayout(),
      //线性布局
      "linearlayout2": (BuildContext context) => LinearLayout2(),
      //Column嵌套Column或者Row嵌套Row的情况
      "flex_layout": (BuildContext context) => FlexLayout(),
      //Flex布局
      "wrapaddflow": (BuildContext context) => WrapAddFlow(),
      //流式布局-Wrap，Flow
      "stack_positioned": (BuildContext context) => StackAddPositioned(),
      //流式布局-Wrap，Flow
      "align_widget": (BuildContext context) => AlianWidget(),
      //对齐与相对定位（Align）
      "container_widget": (BuildContext context) => ContainerWidget(),
      //容器类组件
      "fittedbox_layout": (BuildContext context) => FittedBoxLayout(),
      //空间适配
      "scaffold_layout": (BuildContext context) => ScaffoldLayout(),
      // 页面骨架
      "scroll_widget": (BuildContext context) => ScrollWidget(),
      // 可滚动组件
      "scrollbar_widget": (BuildContext context) => ScrollBarWidget(),
      // ScrollBar
      "singlechildscrollview": (BuildContext context) =>
          SinglechildScrollViewWidget(),
      // ScrollBar
      "listview_widget": (BuildContext context) => ListViewWidget(),
      // ListView
      "scrollcontroller_widget": (BuildContext context) =>
          ScrollControllerWidget(),
      // ScrollController控制器
      // ignore: equal_keys_in_map
      "animatedlist": (BuildContext context) => AnimatedListLayout(),
      // AnimatedList
      "gridview": (BuildContext context) => GridViewLayout(),
      // gridview
      "pageview": (BuildContext context) => PageViewLayout(),
      // PageView
      "tabbarview": (BuildContext context) => TabBarViewLayout(),
      // TabBarView
      "customscrollview_slivers": (BuildContext context) =>
          CustomScrollViewAddSlivers(),
      // CustomScrollView 和 Slivers
      "dialog": (BuildContext context) => DialogDemo(),
      // 对话框
      "dialog": (BuildContext context) => NotificationDemo(),
      // Notification
      "sharedpreference": (BuildContext context) => SharedPreferenceWidget(),
      // Notification
      "test": (BuildContext context) => Test(),
      // Test
      "wajiu_main_page": (BuildContext context) => WajiuMainPage(),
      "wajiu_order_list_page": (BuildContext context) => OrderListPage(),
      // Test
      "provider_example": (BuildContext context) => ProvideDemo(),
      //ChangeNotifierProvider 计数器
      "provider_count_example": (BuildContext context) => ProvideDemo2(),
      // Provider
      "changenotifier_provider_example": (BuildContext context) =>
          ProvideDemo3(),
      // ChangeNotifierProvider
      "selector_provider_example": (BuildContext context) => ProvideDemo4(),
      // Selector
      "inderited_provider_example": (BuildContext context) => ProvideDemo5(),
      // InheritedContext
      "mvvm_provider_example": (BuildContext context) => ProvideDemo6(),
      // InheritedContext
      "next_page": (BuildContext context) => NextPage(),
      "file_example": (BuildContext context) => FileExample(),
      "sqflite_example": (BuildContext context) => SqfliteDemo(),
      //App生命周期
      "app_recyclelife": (BuildContext context) => AppRecycleLifePage(),
      "widget_recyclelife": (BuildContext context) => WidgetLifecycle(),
      "navigation_page": (BuildContext context) => NavigationDemo(),
      "navigation_page2": (BuildContext context) => NavigationPage2(),
      "navigation_page3": (BuildContext context) => NavigationPage3(),
      "getx_state_demo": (BuildContext context) => GetXStateDemo(),
      "getx_state_demo": (BuildContext context) => GetXStateDemo(),
      "getx_state_other": (BuildContext context) => OtherPage(),
    };
    return routes;
  }
}
