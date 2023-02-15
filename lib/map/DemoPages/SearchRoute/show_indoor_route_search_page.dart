import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/general/utils.dart';
import 'common/indoor_route_search_bar.dart';

class ShowIndoorRouteSearchPage extends StatefulWidget {
  @override
  _ShowIndoorRouteSearchPageState createState() =>
      _ShowIndoorRouteSearchPageState();
}

class _ShowIndoorRouteSearchPageState
    extends BMFBaseMapState<ShowIndoorRouteSearchPage> {
  final _startController = TextEditingController(text: "F1");
  final _startLatController = TextEditingController(text: "39.917380");
  final _startLonController = TextEditingController(text: "116.37978");
  final _endController = TextEditingController(text: "F6");
  final _endLatController = TextEditingController(text: "39.917239");
  final _endLonController = TextEditingController(text: "116.37955");

  BMFPolyline? _polyline;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "室内路线",
      ),
      body: Stack(
        children: [
          generateMap(),
          IndoorRouteSearchBar(
            startLatController: _startLatController,
            startLonController: _startLonController,
            startFloorController: _startController,
            endLatController: _endLatController,
            endLonController: _endLonController,
            endFloorController: _endController,
            callback: _onTapSearch,
          ),
        ],
      ),
    );
  }

  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    BMFMapOptions options = BMFMapOptions(
      baseIndoorMapEnabled: true,
      zoomLevel: 19,
      center: BMFCoordinate(39.917380, 116.37978),
    );
    controller.updateMapOptions(options);
  }

  /// 检索
  void _onTapSearch() async {
    /// 起点
    BMFCoordinate startCoord = BMFCoordinate(
      double.parse(_startLatController.text),
      double.parse(_startLonController.text),
    );

    BMFIndoorPlanNode startNode = BMFIndoorPlanNode(
      floor: _startController.text,
      pt: startCoord,
    );

    /// 终点
    BMFCoordinate endCoord = BMFCoordinate(
      double.parse(_endLatController.text),
      double.parse(_endLonController.text),
    );
    BMFIndoorPlanNode endNode = BMFIndoorPlanNode(
      floor: _endController.text,
      pt: endCoord,
    );

    BMFIndoorRoutePlanOption option = BMFIndoorRoutePlanOption(
      from: startNode,
      to: endNode,
    );

    /// 检索对象
    BMFIndoorRouteSearch routeSearch = BMFIndoorRouteSearch();

    /// 检索结果回调
    routeSearch.onGetIndoorRouteSearchResult(
        callback: _onGetIndoorRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.indoorRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetIndoorRouteSearchResult(
      BMFIndoorRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 所有室内路线中第一条路线
    BMFIndoorRouteLine firstLine = result.routes![0];

    /// 移除marker
    myMapController.cleanAllMarkers();

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: firstLine.starting!.location!,
      title: firstLine.starting?.title,
      icon: "resoures/icon_start.png",
    );
    myMapController.addMarker(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: firstLine.terminal!.location!,
      title: firstLine.terminal?.title,
      icon: "resoures/icon_end.png",
    );
    myMapController.addMarker(endMarker);

    List<BMFCoordinate> coordinates = [];
    for (BMFIndoorRouteStep? step in firstLine.steps!) {
      if (step == null) continue;

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
      colors: [Colors.lightBlue],
      dottedLine: false,
    );
    myMapController.addPolyline(_polyline!);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds = getVisibleMapRect(coordinates);
    myMapController.setVisibleMapRectWithPadding(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.all(0),
      animated: true,
    );
  }
}
