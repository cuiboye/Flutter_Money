import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/model/base_route_model.dart';
import 'route_step_model.dart';

class BusRouteModel extends BaseRouteModel {
  String? passStationNum;
  String? stationName;
  List<String> vehicleInfoTitles = [];
  List<BMFTransitStep> transferSteps = [];
  List<RouteStepModel> steps = [];

  BusRouteModel.withModel(routeLine) : super.withModel(routeLine) {

    int stop = 0;

    routeLine.steps?.forEach((element) {
      if (element.stepType != BMFTransitStepType.WAKLING) {
        stop += element.vehicleInfo.passStationNum as int;
        vehicleInfoTitles.add(element.vehicleInfo?.title);
        routeCoordinates?.addAll(element.points);
        transferSteps.add(element);
      }

      RouteStepModel stepModel = RouteStepModel(image: _stepImages[element.stepType.index], instruction: element.instruction);
      steps.add(stepModel);
    });
    passStationNum = "$stop站";
    if (routeLine.starting.title != null) {
      stationName = "${routeLine.starting.title}上车";
    }

    RouteStepModel startStepModel = RouteStepModel(image: "resoures/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel = RouteStepModel(image: "resoures/animation_red.png", instruction: "终点（${endNode?.title}）");
    steps.insert(0, startStepModel);
    steps.add(endStepModel);
  }
}

final _stepImages = [
  "resoures/bus.png",
  "resoures/subway.png",
  "resoures/walk.png",
];
