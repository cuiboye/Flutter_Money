
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/layout/cart_page.dart';
import 'package:flutter_money/layout/page_item_info.dart';
import 'package:flutter_money/wajiu/pager_item_main.dart';
import 'package:flutter_money/wajiu/pager_item_mine.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../layout/pagerview_item.dart';
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 挖酒主页
 */
class WajiuMainPage extends StatefulWidget {
  @override
  _WajiuMainPageState createState() => _WajiuMainPageState();
}

class _WajiuMainPageState extends State<WajiuMainPage> {
  final _defaultColor = Colors.grey;
  final _activityColor = Colors.red;
  var _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,//默认选中页面
    keepPage: true,//保持加载的每个页面的状态
  );

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(

          body: PageView(//相当于Android中的ViewPager
            onPageChanged:(index)=>{//onPageChanged:监听PageView页面滑动
              setState(() {
                _currentIndex = index;
              })
            } ,
            controller: _controller,//相当于Android中ViewPage的滑动监听
            children: [//子页面
              PageItemMain(info: "首页"),
              PageViewItem(info: "分类"),
              PageInfoItem(info: "信息台"),
              ShopCartItem(info: "采购车"),
              PageItemMine(info: "我的"),
            ],
            // physics: NeverScrollableScrollPhysics(),//禁止左右滑动
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,//底部导航栏，当前下标
            onTap: (index) {
              _controller.jumpToPage(index);//跳转到PageView的对应页面
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,//这里需要设置为fixed，否则看不到文字
            items: [
              _itemBottomNavigation('首页', Icons.home),
              _itemBottomNavigation('分类', Icons.list),
              _itemBottomNavigation('信息台', Icons.info_rounded),
              _itemBottomNavigation('采购车', Icons.search),
              _itemBottomNavigation('我的', Icons.account_circle),
            ],
          ),
        ));
  }

  BottomNavigationBarItem _itemBottomNavigation(String title, IconData? icon) {
    return BottomNavigationBarItem(
        icon: Icon(icon,color:_defaultColor),//未选中tab
        activeIcon: Icon(icon,color:_activityColor),//选中tab
        label: title,//文字
        tooltip: ""//这个是去除当点击tab标签的时候，在tab上方弹出的toast
    );
  }
}

