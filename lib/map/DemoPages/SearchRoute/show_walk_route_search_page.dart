import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/general/utils.dart';
import 'common/route_detail_page.dart';
import 'common/route_info_footer.dart';
import 'common/route_search_bar.dart';
import 'model/walk_route_model.dart';

class ShowWalkRouteSearchPage extends StatefulWidget {
  @override
  _ShowWalkRouteSearchPageState createState() =>
      _ShowWalkRouteSearchPageState();
}

class _ShowWalkRouteSearchPageState
    extends BMFBaseMapState<ShowWalkRouteSearchPage> {
  final _startController = TextEditingController(text: "百度科技园");
  final _startCityController = TextEditingController(text: "北京市");
  final _endController = TextEditingController(text: "西二旗地铁站");
  final _endCityController = TextEditingController(text: "北京市");

  BMFPolyline? _polyline;
  bool _isShowRouteInfoFooter = false;
  WalkRouteModel? _routeModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "步行路线",
      ),
      body: Stack(
        children: [
          generateMap(),
          RouteSearchBar(
            startCityController: _startCityController,
            startController: _startController,
            endCityController: _endCityController,
            endController: _endController,
            callback: _onTapSearch,
          ),
          _routeInfoFooter(),
        ],
      ),
    );
  }

  /// 检索
  void _onTapSearch() async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(
      name: _startController.text,
      cityName: _startCityController.text,
    );

    /// 终点
    BMFPlanNode endNode = BMFPlanNode(
      name: _endController.text,
      cityName: _endCityController.text,
    );

    BMFWalkingRoutePlanOption option = BMFWalkingRoutePlanOption(
      from: startNode,
      to: endNode,
    );

    /// 检索对象
    BMFWalkingRouteSearch routeSearch = BMFWalkingRouteSearch();

    /// 检索结果回调
    routeSearch.onGetWalkingRouteSearchResult(
        callback: _onGetWalkingRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.walkingRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetWalkingRouteSearchResult(
      BMFWalkingRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 所有步行路线中第一条路线
    BMFWalkingRouteLine firstLine = result.routes![0];
    _routeModel = WalkRouteModel.withModel(firstLine);

    setState(() {
      _isShowRouteInfoFooter = true;
    });

    /// 移除marker
    myMapController.cleanAllMarkers();

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: _routeModel!.startNode!.location!,
      title: _routeModel?.startNode?.title,
      icon: "resoures/icon_start.png",
    );

    myMapController.addMarker(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: _routeModel!.endNode!.location!,
      title: _routeModel?.endNode?.title,
      icon: "resoures/icon_end.png",
    );
    myMapController.addMarker(endMarker);

    List<BMFCoordinate> coordinates = [];
    for (BMFWalkingStep? step in firstLine.steps!) {
      if (null == step) {
        continue;
      }

      /// 路线经过的路段坐标点
      if (null != step.points) {
        coordinates.addAll(step.points!);
      }
    }

    if (_polyline != null) {
      myMapController.removeOverlay(_polyline!.id);
    }

    /// 添加路线polyline
    _polyline = BMFPolyline(
      coordinates: coordinates,
      indexs: [0],
      textures: ["resoures/traffic_texture_smooth.png"],
      dottedLine: false,
    );
    myMapController.addPolyline(_polyline!);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds = getVisibleMapRect(coordinates);
    myMapController.setVisibleMapRectWithPadding(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.only(top: 65.0, bottom: 70, left: 10, right: 10),
      animated: true,
    );
  }

  /// 点击详情
  void _onTapDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteDetailPage(
          routeModel: _routeModel,
        ),
      ),
    );
  }

  /// 路线信息
  Widget _routeInfoFooter() {
    return Positioned(
      left: 15,
      right: 15,
      bottom: 15,
      child: Visibility(
        visible: _isShowRouteInfoFooter,
        child: RouteInfoFooter(
          duration: _routeModel?.duration,
          distance: _routeModel?.distance,
          onTapDetailBtn: _onTapDetail,
        ),
      ),
    );
  }
}
