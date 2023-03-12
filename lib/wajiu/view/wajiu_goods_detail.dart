import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/view/wajiu_detail_appbar.dart';
import 'package:flutter_money/wajiu/widget/wajiu_detail_banner_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WajiuGoodsDetail extends StatefulWidget {
  @override
  _WajiuGoodsDetailState createState() => _WajiuGoodsDetailState();
}

class _WajiuGoodsDetailState extends State<WajiuGoodsDetail> {
  ///AppBar 的背景色透明度
  int appBarColorAlpha = 0;

  ///记录滚动距离
  double scrollPix = 0;

  ///是否需要显示停靠
  bool showStickItem = false;

  ///头部区域高度
  double headerHeight = 264;

  ///头部区域偏离图片高度
  double headerRectMargin = 40;

  ///头部信息框高度
  double headerRectHeight = 60;

  ///头部区域
  _buildHeader() {
    ///状态栏高度
    double statusBarHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

    ///头部区域去除marin、appbar、状态栏之后的高度
    double dynamicValue =
        headerHeight - headerRectMargin - kToolbarHeight - statusBarHeight;

    ///计算 margin 的撑开动画效果，用于视觉偏差
    ///计算停靠 item 的显示标志 showStickItem
    double marginEdge = 0;
    if (scrollPix >= dynamicValue) {
      marginEdge = 10 - (scrollPix - dynamicValue);
      marginEdge = math.max(0, marginEdge);
      if (marginEdge == 0) {
        showStickItem = true;
      } else {
        showStickItem = false;
      }
    } else {
      marginEdge = 10;
      showStickItem = false;
    }

    return Container(
      color: ColorConstant.color_ffffff,
      height: headerHeight,
      width: double.infinity,
      child: Swiper(
        itemCount: 5,
        autoplay: true, //是否自动轮播
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
                  return NLIndicator(config.activeIndex, 5);
                })), //指示器
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            "images/wajiu_detail_test_pic.jpeg",
            fit: BoxFit.fitHeight,
          );
        },
      ),
    );
  }

  ///处理滑动监听
  _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    scrollPix = notification.metrics.pixels;
    var curAlpha = 0;
    if (notification.metrics.pixels <= 0) {
      curAlpha = 0;
    } else {
      curAlpha = ((notification.metrics.pixels / 180) * 255).toInt();
      if (curAlpha > 255) {
        curAlpha = 255;
      }
    }
    setState(() {
      print("$curAlpha");
      appBarColorAlpha = curAlpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Container(
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification && notification.depth==0) {
                _handleScrollUpdateNotification(notification);
              }
              return false;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader();
                }else if(index == 1){
                  return Container(
                    height: 150,
                    child: Text("sdfdsf"),
                  );
                }
                return Container(
                  height: 500,
                  child: Text("sdfdsf"),
                );
              },
              itemCount: 3,
            ),

          ),
        ),
        appBar: WajiuDetailAppBar(context:context,title:"dsfdsfds",alphaBg:appBarColorAlpha)
      ),

    );
  }
}
