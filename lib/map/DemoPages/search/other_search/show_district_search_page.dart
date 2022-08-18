import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/other_search_params/show_district_search_params_page.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

/// 行政区边界检索
class ShowDistrictSearchPage extends StatefulWidget {
  @override
  _ShowDistrictSearchPageState createState() => _ShowDistrictSearchPageState();
}

class _ShowDistrictSearchPageState
    extends BMFBaseMapState<ShowDistrictSearchPage> {
  final _cityController = TextEditingController(text: "北京");
  final _districtController = TextEditingController(text: "朝阳区");

  List<BMFPolygon> _polygons = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "行政区边界检索",
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
          _bottomSearchBar()
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
            ShowDistrictSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFDistrictSearchOption option) {
    _cityController.text = option.city ?? "";
    _districtController.text = option.district ?? "";

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFDistrictSearchOption option = BMFDistrictSearchOption(
      city: _cityController.text,
      district: _districtController.text,
    );

    /// 检索对象
    BMFDistrictSearch districtSearch = BMFDistrictSearch();

    /// 检索回调
    districtSearch.onGetDistrictSearchResult(
        callback: _onGetDistrictSearchResult);

    /// 发起检索
    bool result = await districtSearch.districtSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetDistrictSearchResult(
      BMFDistrictSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 移除polygon
    for (BMFPolygon polygon in _polygons) {
      myMapController.removeOverlay(polygon.id);
    }
    _polygons.clear();

    /// 检索结果polygon
    List? paths = result.paths;
    if (paths == null) return;

    for (List<BMFCoordinate> coords in paths) {
      BMFPolygon polygon = BMFPolygon(
        coordinates: coords,
        width: 1,
        fillColor: Colors.blue.withAlpha(76),
        strokeColor: Colors.blue,
      );
      myMapController.addPolygon(polygon);
      myMapController.setCenterCoordinate(result.center!, true);
      _polygons.add(polygon);
    }

    /// 检索结果alert msg
    List<String> alertMsgs = [];
    String code = "行政区域编码：" + "${result.code}";
    String name = "行政区域名称：" + "${result.name}";
    String center = "行政区域中心点：" +
        "${result.center?.latitude}" +
        "\n" +
        "${result.center?.longitude}";
    alertMsgs.add(code);
    alertMsgs.add(name);
    alertMsgs.add(center);
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
              child: Column(
                children: [
                  BMFInputBox(
                    controller: _cityController,
                    title: "城市：",
                    placeholder: "输入城市",
                  ),
                  BMFInputBox(
                    controller: _districtController,
                    title: "区县：",
                    placeholder: "输入区县",
                  ),
                ],
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
}
