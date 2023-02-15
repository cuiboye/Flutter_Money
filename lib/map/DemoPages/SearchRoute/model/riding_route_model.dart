import 'base_route_model.dart';
import 'route_step_model.dart';

class RidingRouteModel extends BaseRouteModel {
  List<RouteStepModel> steps = [];

  RidingRouteModel.withModel(routeLine) : super.withModel(routeLine) {
    routeLine.steps.forEach((element) {
      RouteStepModel stepModel = RouteStepModel(image: "resoures/ride.png", instruction: element.instruction);
      steps.add(stepModel);
    });

    RouteStepModel startStepModel = RouteStepModel(image: "resoures/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel = RouteStepModel(image: "resoures/animation_red.png", instruction: "终点（${endNode?.title}）");
    steps.insert(0, startStepModel);
    steps.add(endStepModel);
  }
}