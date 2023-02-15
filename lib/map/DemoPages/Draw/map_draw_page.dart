import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/function_item.widget.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_makercollision_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawarcline_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawcircle_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawdot_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawground_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawmaker_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawpolygon_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawpolyline_page.dart';
import 'package:flutter_money/map/DemoPages/Draw/map_drawtext_page.dart';
import 'package:flutter_money/map/general/utils.dart';

import 'map_drawgeodesicline_page.dart';
import 'map_drawgradientline_page.dart';
import 'map_drawmultipoint_page.dart';
import 'map_drawprism_page.dart';
import 'map_drawtrace_page.dart';

/// 在地图绘制入口
class MapDrawPage extends StatelessWidget {
  const MapDrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BMFAppBar(
          title: '在地图上绘制',
          isBack: false,
        ),
        body: Container(
            child: ListView(children: <Widget>[
          FunctionItem(
            label: 'marker示例',
            sublabel: 'marker绘制及事件响应',
            target: DrawMarkerPage(),
          ),
          FunctionItem(
            label: 'marker碰撞检测',
            sublabel: 'marker碰撞检测',
            target: DrawCollisionDetectionPage(),
          ),
          FunctionItem(
            label: 'polyline示例',
            sublabel: 'polyline绘制及事件响应',
            target: DrawPolylinePage(),
          ),
          FunctionItem(
            label: 'arcline示例',
            sublabel: '弧线绘制',
            target: DrawArclinePage(),
          ),
          FunctionItem(
            label: 'polygon示例',
            sublabel: '多边形绘制',
            target: DrawPolygonPage(),
          ),
          FunctionItem(
            label: 'circle示例',
            sublabel: '圆形绘制',
            target: DrawCirclePage(),
          ),
          generatePlatformizationItem(
              Platform.isAndroid, 'dot示例', '圆点绘制', DrawDotPage()),
          FunctionItem(
              label: 'ground示例', sublabel: '图片覆盖物绘制', target: DrawGroundPage()),
          generatePlatformizationItem(
              Platform.isAndroid, 'text示例', '文本绘制', DrawTextPage()),
          FunctionItem(
            label: '大地曲线示例',
            sublabel: '大地曲线绘制',
            target: DrawGeodesicLinePage(),
          ),
          FunctionItem(
            label: '渐变线示例',
            sublabel: 'draw_gradientline_page',
            target: DrawGradientLinePage(),
          ),
          FunctionItem(
            label: '3D棱柱示例',
            sublabel: '3D棱柱绘制',
            target: DrawPrismOverlayPage(),
          ),
          FunctionItem(
            label: '海量点示例',
            sublabel: '海量点绘制',
            target: DrawMultiPointOverlayPage(),
          ),
          FunctionItem(
            label: '动态轨迹示例',
            sublabel: '动态轨迹绘制',
            target: DrawTraceOverlayPage(),
          ),
        ])));
  }
}
