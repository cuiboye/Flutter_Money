import 'base_route_model.dart';
import 'route_step_model.dart';

class WalkRouteModel extends BaseRouteModel {
  List<RouteStepModel> steps = [];

  WalkRouteModel.withModel(routeLine) : super.withModel(routeLine) {
    routeLine.steps.forEach((element) {
      RouteStepModel stepModel = RouteStepModel(image: "resoures/walk.png", instruction: element.instruction);
      steps.add(stepModel);
    });

    RouteStepModel startStepModel = RouteStepModel(image: "resoures/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel = RouteStepModel(image: "resoures/animation_red.png", instruction: "终点（${endNode?.title}）");
    steps.insert(0, startStepModel);
    steps.add(endStepModel);
  }
}