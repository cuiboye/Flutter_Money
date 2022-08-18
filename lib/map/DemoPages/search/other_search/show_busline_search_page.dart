import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/other_search_params/show_busline_search_params_page.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/general/utils.dart';

/// 公交线路检索
class ShowBuslineSearchPage extends StatefulWidget {
  @override
  _ShowBuslineSearchPageState createState() => _ShowBuslineSearchPageState();
}

class _ShowBuslineSearchPageState
    extends BMFBaseMapState<ShowBuslineSearchPage> {
  final _cityController = TextEditingController(text: "北京");
  final _busUIDController =
      TextEditingController(text: "566982672f9427deb23c814d");

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "公交线路检索",
        actions: [
          BMFSearchBtn(
            title: "详细参数",
            onTap: () {
              _onTapParamsPage(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: generateMap(),
          ),
          _bottomSearchBar(),
        ],
      ),
    );
  }

  /// 参数设置
  void _onTapParamsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShowBuslineSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFBusLineSearchOption option) {
    _cityController.text = option.city ?? "";
    _busUIDController.text = option.busLineUid ?? "";

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFBusLineSearchOption option = BMFBusLineSearchOption(
      city: _cityController.text,
      busLineUid: _busUIDController.text,
    );

    /// 检索对象
    BMFBusLineSearch buslineSearch = BMFBusLineSearch();

    /// 检索回调注册
    buslineSearch.onGetBuslineSearchResult(callback: _onGetBuslineSearchResult);

    /// 发起检索
    bool result = await buslineSearch.busLineSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetBuslineSearchResult(
      BMFBusLineResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索结果 annotation
    List<BMFMarker> stationMarkers = [];
    result.busStations?.forEach((element) {
      BMFMarker marker = BMFMarker.icon(
        position: element.location!,
        title: element.title,
        icon: "resoures/pin_red.png",
      );
      stationMarkers.add(marker);
    });
    myMapController.cleanAllMarkers();
    myMapController.addMarkers(stationMarkers);

    /// 检索结果 polyline
    BMFPolyline polyline = BMFPolyline(
      coordinates: result.busSteps!.first.points!,
      colors: [Colors.blue],
      indexs: [0],
      dottedLine: false,
    );
    myMapController.addPolyline(polyline);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds =
        getVisibleMapRect(result.busSteps!.first.points!);

    myMapController.setVisibleMapRectWithPadding(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.all(10),
      animated: true,
    );

    /// 检索结果alert msg
    Map resultMap = result.toMap();
    List<String> alertMsgs = [];
    _buslineResultMap.forEach((key, value) {
      String msg = value + "${resultMap[key]}";
      alertMsgs.add(msg);
    });
    String alertMsg = alertMsgs.join("\n");
    showSearchResultAlertDialog(context, alertMsg);
  }

  /// search bar
  Widget _bottomSearchBar() {
    return SafeArea(
      child: Container(
        height: 75,
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    BMFInputBox(
                      controller: _cityController,
                      title: "          城市：",
                      placeholder: "输入城市",
                    ),
                    BMFInputBox(
                      controller: _busUIDController,
                      title: "公交线UID：",
                      placeholder: "输入UID",
                    ),
                  ],
                ),
              ),
            ),
            BMFSearchBtn(
              height: 75,
              title: "搜索",
              padding: EdgeInsets.all(5),
              onTap: _onTapSearch,
            )
          ],
        ),
      ),
    );
  }

  Map<String, String> _buslineResultMap = {
    "busLineName": "线路名称：",
    "busLineDirection": "线路方向：",
    "uid": "线路ID：",
    "startTime": "首班车时间：",
    "endTime": "末班车时间：",
    "basicPrice": "起步票价：",
    "totalPrice": "全程票价：",
  };
}
