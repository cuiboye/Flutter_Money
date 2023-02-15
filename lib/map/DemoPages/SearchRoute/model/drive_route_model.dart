import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

import 'base_route_model.dart';
import 'route_step_model.dart';

class DriveRouteModel extends BaseRouteModel {
  String? lightNum;
  String? congestionMetres;

  List<BMFPlanNode>? wayPoints;
  List<RouteStepModel>? steps = [];
  List<int>? trafficIndexList = [];

  DriveRouteModel.withModel(BMFDrivingRouteLine routeLine) : super.withModel(routeLine) {
    lightNum = "${routeLine.lightNum}";
    congestionMetres = "${routeLine.congestionMetres}";

    routeLine.steps?.forEach((element) {
      routeCoordinates?.addAll(element.points!);
      trafficIndexList?.addAll(element.traffics != null ? element.traffics! : [1]);

      RouteStepModel stepModel = RouteStepModel(image: "resoures/driving.png", instruction: element.instruction!);
      steps?.add(stepModel);
    });
    wayPoints = routeLine.wayPoints;

    RouteStepModel startStepModel = RouteStepModel(image: "resoures/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel = RouteStepModel(image: "resoures/animation_red.png", instruction: endNode?.title != null ? "终点（${endNode!.title}）" : "终点");
    steps?.insert(0, startStepModel);
    steps?.add(endStepModel);
  }
}