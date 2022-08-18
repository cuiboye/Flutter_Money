import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/general/utils.dart';
import 'common/route_detail_page.dart';
import 'common/route_plan_search_result_item.dart';
import 'common/route_info_footer.dart';
import 'common/route_search_bar.dart';
import 'model/bus_route_model.dart';

class ShowBusRouteSearchPage extends StatefulWidget {
  @override
  _ShowBusRouteSearchPageState createState() => _ShowBusRouteSearchPageState();
}

class _ShowBusRouteSearchPageState
    extends BMFBaseMapState<ShowBusRouteSearchPage> {
  /// 起点
  final _startController = TextEditingController(text: "百度大厦");

  /// 终点
  final _endController = TextEditingController(text: "北京西站");

  /// 城市
  final _cityController = TextEditingController(text: "北京");

  /// 路线 polyline
  BMFPolyline? _polyline;

  bool _isShowSearchResultList = false;
  bool _isShowRouteInfoFooter = false;
  BusRouteModel? _routeModel;

  List<BusRouteModel> _routes = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "市内公交路线",
      ),
      body: Stack(
        children: [
          generateMap(),
          RouteSearchBar(
            startCityController: _cityController,
            startController: _startController,
            endCityController: _cityController,
            endController: _endController,
            callback: _onTapSearch,
          ),
          _searchResultListView(),
          _routeInfoFooter(),
        ],
      ),
    );
  }

  /// 检索
  void _onTapSearch() async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(name: _startController.text);

    /// 终点
    BMFPlanNode endNode = BMFPlanNode(name: _endController.text);

    BMFTransitRoutePlanOption option = BMFTransitRoutePlanOption(
      from: startNode,
      to: endNode,
      city: _cityController.text,
    );

    /// 检索对象
    BMFTransitRouteSearch routeSearch = BMFTransitRouteSearch();

    /// 检索结果回调
    routeSearch.onGetTransitRouteSearchResult(
        callback: _onGetTransitRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.transitRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetTransitRouteSearchResult(
      BMFTransitRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    print(result.toMap());

    _routes.clear();

    result.routes?.forEach((element) {
      BusRouteModel model = BusRouteModel.withModel(element);
      _routes.add(model);
    });

    setState(() {
      _isShowSearchResultList = true;
      _isShowRouteInfoFooter = false;
    });
  }

  /// 路线 Polyline
  void _addRoutePolyline() {
    if (_routeModel == null) return;

    List<BMFMarker> markers = [];

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: _routeModel!.startNode!.location!,
      title: _routeModel!.startNode!.title,
      icon: "resoures/icon_start.png",
    );
    markers.add(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: _routeModel!.endNode!.location!,
      title: _routeModel!.endNode!.title,
      icon: "resoures/icon_end.png",
    );
    markers.add(endMarker);

    /// 入口marker
    _routeModel?.transferSteps.forEach((element) {
      BMFMarker marker = BMFMarker.icon(
        position: element.entrace!.location!,
        title: element.instruction,
        icon: "resoures/pin_red.png",
      );
      markers.add(marker);
    });

    /// 添加marker
    myMapController.addMarkers(markers);

    /// 添加路线polyline
    if (_polyline != null) {
      myMapController.removeOverlay(_polyline!.id);
    }

    _polyline = BMFPolyline(
      width: 8,
      coordinates: _routeModel!.routeCoordinates!,
      indexs: [0],
      textures: ["resoures/traffic_texture_smooth.png"],
      dottedLine: false,
    );
    myMapController.addPolyline(_polyline!);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds =
        getVisibleMapRect(_polyline!.coordinates);

    myMapController.setVisibleMapRectWithPadding(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.only(top: 65.0, bottom: 70, left: 10, right: 10),
      animated: true,
    );
  }

  /// 点击搜索结果列表item
  void _onTapRoutePlanSearchResultItem(int idx) {
    setState(() {
      _isShowSearchResultList = false;
      _isShowRouteInfoFooter = true;
      _routeModel = _routes[idx];
    });

    _addRoutePolyline();
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

  /// 搜索结果列表
  Widget _searchResultListView() {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: _isShowSearchResultList,
        child: Container(
          color: Color(0xFFf7f7f7),
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: _routes.length,
          ),
        ),
      ),
    );
  }

  /// 搜索结果列表item
  Widget _itemBuilder(BuildContext context, int index) {
    BusRouteModel routeModel = _routes[index];

    return RoutePlanSearchResultItem(
      duration: routeModel.duration,
      distance: routeModel.distance,
      vehicleInfoTitles: routeModel.vehicleInfoTitles,
      passStationNum: routeModel.passStationNum,
      stationName: routeModel.stationName,
      onTap: () => _onTapRoutePlanSearchResultItem(index),
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
