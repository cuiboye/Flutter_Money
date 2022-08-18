import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/function_item.widget.dart';

/// 有些overlay有平台区分,需要区别展示
///
/// 目前iOS不支持dot和text
Widget generatePlatformizationItem(
    bool isCurrentPlatform, String label, String sublabel, Widget widget) {
  return isCurrentPlatform
      ? FunctionItem(label: label, sublabel: sublabel, target: widget)
      : Placeholder(
          color: Colors.transparent,
          strokeWidth: 0,
          fallbackHeight: 0,
        );
}

/// 获取地图显示区域
BMFCoordinateBounds getVisibleMapRect(List<BMFCoordinate> coordinates) {
  BMFCoordinate fisrt = coordinates[0];
  double leftBottomX = fisrt.latitude;
  double leftBottomY = fisrt.longitude;
  double rightTopX = fisrt.latitude;
  double rightTopY = fisrt.longitude;

  for (BMFCoordinate coordinate in coordinates) {
    if (coordinate.latitude < leftBottomX) {
      leftBottomX = coordinate.latitude;
    }

    if (coordinate.longitude < leftBottomY) {
      leftBottomY = coordinate.longitude;
    }

    if (coordinate.latitude > rightTopX) {
      rightTopX = coordinate.latitude;
    }

    if (coordinate.longitude > rightTopY) {
      rightTopY = coordinate.longitude;
    }
  }

  BMFCoordinate leftBottom = BMFCoordinate(leftBottomX, leftBottomY);
  BMFCoordinate rightTop = BMFCoordinate(rightTopX, rightTopY);

  BMFCoordinateBounds coordinateBounds =
      BMFCoordinateBounds(northeast: rightTop, southwest: leftBottom);

  return coordinateBounds;
}
