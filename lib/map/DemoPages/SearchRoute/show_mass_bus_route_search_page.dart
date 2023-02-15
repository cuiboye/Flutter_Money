import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/common/route_search_bar.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/model/mass_bus_route_filter_menu_controller.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/general/utils.dart';
import 'common/mass_bus_route_filter_menu.dart';
import 'common/route_detail_page.dart';
import 'common/route_info_footer.dart';
import 'model/mass_bus_route_model.dart';

class ShowMassBusRouteSearchPage extends StatefulWidget {
  @override
  _ShowMassBusRouteSearchPageState createState() =>
      _ShowMassBusRouteSearchPageState();
}

class _ShowMassBusRouteSearchPageState
    extends BMFBaseMapState<ShowMassBusRouteSearchPage> {
  final _startController = TextEditingController(text: "百度大厦");
  final _startCityController = TextEditingController(text: "北京");
  final _endController = TextEditingController(text: "避暑山庄");
  final _endCityController = TextEditingController(text: "河北");

  final _filterMenuController = MassBusRouteFilterMenuController();

  BMFPolyline? _polyline;

  bool _isShowRouteInfoFooter = false;
  bool _isShowSearchResultList = false;
  MassBusRouteModel? _selectedRouteModel;
  List<MassBusRouteModel> _routes = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "跨城公交路线",
      ),
      body: Stack(
        children: [
          generateMap(),
          _searchBar(),
          _searchResultListView(),
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

    BMFMassTransitRoutePlanOption option = BMFMassTransitRoutePlanOption(
      from: startNode,
      to: endNode,
      incityPolicy: _filterMenuController.incityPolicy,
      intercityPolicy: _filterMenuController.intercityPolicy,
      intercityTransPolicy: _filterMenuController.intercityTransPolicy,
    );

    /// 检索对象
    BMFMassTransitRouteSearch routeSearch = BMFMassTransitRouteSearch();

    /// 检索结果回调
    routeSearch.onGetMassTransitRouteSearchResult(
        callback: _onGetMassTransitRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.massTransitRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetMassTransitRouteSearchResult(
      BMFMassTransitRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    print(result.toMap());

    _routes.clear();

    result.routes?.forEach((element) {
      MassBusRouteModel model = MassBusRouteModel.withModel(element);
      _routes.add(model);
    });

    setState(() {
      _isShowSearchResultList = true;
      _isShowRouteInfoFooter = false;
    });
  }

  /// 点击详情
  void _onTapDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteDetailPage(
          routeModel: _selectedRouteModel,
        ),
      ),
    );
  }

  /// 路线 Polyline
  void _addRoutePolyline() {
    List<BMFMarker> markers = [];

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: _selectedRouteModel!.startNode!.location!,
      title: _selectedRouteModel?.startNode?.title,
      icon: "resoures/icon_start.png",
    );
    markers.add(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: _selectedRouteModel!.endNode!.location!,
      title: _selectedRouteModel?.endNode?.title,
      icon: "resoures/icon_end.png",
    );
    markers.add(endMarker);

    /// 添加marker
    myMapController.cleanAllMarkers();
    myMapController.addMarkers(markers);

    /// 添加路线polyline
    if (_polyline != null) {
      myMapController.removeOverlay(_polyline!.id);
    }

    _polyline = BMFPolyline(
      width: 8,
      coordinates: _selectedRouteModel!.routeCoordinates!,
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

  /// 路线信息
  Widget _routeInfoFooter() {
    return Positioned(
      left: 15,
      right: 15,
      bottom: 15,
      child: Visibility(
        visible: _isShowRouteInfoFooter,
        child: RouteInfoFooter(
          duration: _selectedRouteModel?.duration,
          distance: _selectedRouteModel?.distance,
          onTapDetailBtn: _onTapDetail,
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
    MassBusRouteModel model = _routes[index];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "路线${index + 1}：",
                style: _itemTitleStyle,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "${model.duration}",
                style: _itemSubTitleStyle,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "票价：${model.price}",
                style: _itemSubTitleStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () => _onTapRouteItem(index),
    );
  }

  /// 点击搜索结果列表item
  void _onTapRouteItem(int idx) {
    setState(() {
      _isShowSearchResultList = false;
      _isShowRouteInfoFooter = true;
      _selectedRouteModel = _routes[idx];
    });

    _addRoutePolyline();
  }

  /// search bar
  Widget _searchBar() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RouteSearchBar(
            startCityController: _startCityController,
            startController: _startController,
            endCityController: _endCityController,
            endController: _endController,
            callback: _onTapSearch,
          ),
          MassBusRouteFilterMenu(
            controller: _filterMenuController,
          ),
        ],
      ),
    );
  }
}

final _itemTitleStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
final _itemSubTitleStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
