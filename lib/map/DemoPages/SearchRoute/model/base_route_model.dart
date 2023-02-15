import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

class BaseRouteModel {
  String? duration;
  String? distance;
  BMFRouteNode? startNode;
  BMFRouteNode? endNode;
  List<BMFCoordinate>? routeCoordinates = [];

  BaseRouteModel({this.duration, this.distance});

  BaseRouteModel.withModel(routeLine) {
    if (routeLine.duration.minutes > 0) {
      duration = "${routeLine.duration.minutes}分钟";
    }
    if (routeLine.duration.hours > 0) {
      duration = "${routeLine.duration.hours}小时";
    }
    if (routeLine.duration.hours > 0 && routeLine.duration.minutes > 0) {
      duration = "${routeLine.duration.hours}小时${routeLine.duration.minutes}分";
    }

    if (routeLine.distance < 100) {
      distance = "${routeLine.distance}米";
    } else {
      distance = (routeLine.distance / 1000.0).toStringAsFixed(1) + "公里";
    }

    startNode = routeLine.starting;
    endNode = routeLine.terminal;
  }
}