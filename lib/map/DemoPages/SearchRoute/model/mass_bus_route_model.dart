import 'dart:io';

import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

import 'base_route_model.dart';
import 'route_step_model.dart';

class MassBusRouteModel extends BaseRouteModel {
  String? passStationNum;
  String? stationName;
  String? price;
  List<RouteStepModel>? steps = [];

  MassBusRouteModel.withModel(BMFMassTransitRouteLine routeLine)
      : super.withModel(routeLine) {
    price = "${routeLine.price}元";
    routeLine.steps?.forEach((element) {
      element.steps?.forEach((subElement) {
        /// Android用BMFBusVehicleInfo.type 区分高铁/公交 1：高铁 0：公交
        if (Platform.isAndroid) {
          if ((subElement.stepType == BMFMassTransitType.BUSLINE ||
              subElement.stepType == BMFMassTransitType.SUBWAY) &&
              subElement.vehicleInfo != null
              && subElement.vehicleInfo is BMFBusVehicleInfo) {
            if ( (subElement.vehicleInfo as BMFBusVehicleInfo).type == 1 ) {
              subElement.stepType = BMFMassTransitType.SUBWAY;
            }
          }
        }

        RouteStepModel stepModel = RouteStepModel(
            image: _icons[subElement.stepType!.index],
            instruction: subElement.instructions!);
        steps?.add(stepModel);
        routeCoordinates?.addAll(subElement.points!);
      });
    });

    RouteStepModel startStepModel = RouteStepModel(
        image: "resoures/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel =
        RouteStepModel(image: "resoures/animation_red.png", instruction: "终点");
    steps?.insert(0, startStepModel);
    steps?.add(endStepModel);
  }
}

final _icons = [
  "resoures/subway.png",
  "resoures/train.png",
  "resoures/plane.png",
  "resoures/bus.png",
  "resoures/driving.png",
  "resoures/walk.png",
  "resoures/bus.png",
];
