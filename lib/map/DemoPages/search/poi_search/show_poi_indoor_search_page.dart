import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_poi_indoor_search_params_page.dart';

class ShowPOIIndoorSearchPage extends StatefulWidget {
  @override
  _ShowPOIIndoorSearchPageState createState() =>
      _ShowPOIIndoorSearchPageState();
}

class _ShowPOIIndoorSearchPageState
    extends BMFBaseMapState<ShowPOIIndoorSearchPage> {
  final _indoorIDController =
      TextEditingController(text: "1266498491660632063");
  final _keywordController = TextEditingController(text: "小吃");

  BMFPoiIndoorSearchOption? _indoorSearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "POI室内检索",
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

  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 显示室内图
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917, 116.379),
      zoomLevel: 20,
      baseIndoorMapEnabled: true,
      showIndoorMapPoi: true,
    );
    controller.updateMapOptions(mapOptions);
  }

  /// 参数设置
  void _onTapParamsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShowPOIIndoorSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFPoiIndoorSearchOption option) {
    _indoorIDController.text = option.indoorID ?? "";
    _keywordController.text = option.keyword ?? "";

    _indoorSearchOption = option;

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFPoiIndoorSearchOption option = BMFPoiIndoorSearchOption(
      indoorID: _indoorIDController.text,
      keyword: _keywordController.text,
    );

    if (_indoorSearchOption != null) {
      option.floor = _indoorSearchOption?.floor;
      option.pageSize = _indoorSearchOption?.pageSize;
      option.pageIndex = _indoorSearchOption?.pageIndex;
    }

    /// 检索对象
    BMFPoiIndoorSearch indoorSearch = BMFPoiIndoorSearch();

    /// 检索结果回调注册
    indoorSearch.onGetPoiIndoorSearchearchResult(
        callback: _onGetPoiIndoorSearchearchResult);

    /// 发起检索
    bool result = await indoorSearch.poiIndoorSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetPoiIndoorSearchearchResult(
      BMFPoiIndoorSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索结果marker
    result.poiIndoorInfoList?.forEach((element) {
      BMFMarker marker = BMFMarker.icon(
        position: element.pt!,
        title: element.name,
        subtitle: "楼层：${element.floor}",
        icon: "resoures/pin_red.png",
      );
      myMapController.addMarker(marker);
    });

    /// 检索结果 alert msg
    Map resultMap = result.toMap();
    resultMap.remove("poiIndoorInfoList");
    Map firstpoiIndoorInfoMap = result.poiIndoorInfoList!.first.toMap();
    resultMap.addAll(firstpoiIndoorInfoMap);

    List<String> alertMsgs = [];
    _indoorResultMap.forEach((key, value) {
      String msg = value;
      if (key.contains(".")) {
        List keys = key.split(".");
        var subMap = resultMap;
        for (String subKey in keys) {
          if (subMap[subKey] is Map) {
            subMap = subMap[subKey];
          } else {
            msg += "${subMap[subKey]}";
          }
        }
      } else {
        msg += "${resultMap[key]}";
      }
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
                      controller: _indoorIDController,
                      title: "室内ID：",
                      placeholder: "输入室内ID",
                    ),
                    BMFInputBox(
                      controller: _keywordController,
                      title: "关键字：",
                      placeholder: "输入关键字",
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

  /// 检索结果弹窗数据
  Map<String, String> _indoorResultMap = {
    "totalPOINum": "检索结果总数：",
    "totalPageNum": "总页数：",
    "curPOINum": "当前页的结果数：",
    "curPageIndex": "当前页的页数索引：",
    "name": "名称：",
    "uid": "UID：",
    "indoorID": "室内ID：",
    "floor": "所在楼层：",
    "pt.latitude": "纬度：",
    "pt.longitude": "经度：",
    "phone": "电话：",
    "address": "地址：",
    "city": "城市：",
    "tag": "标签：",
    "price": "商户的价格：",
    "starLevel": "星级：",
    "grouponFlag": "是否有团购：",
    "takeoutFlag": "是否有外卖：",
    "waitedFlag": "是否排队：",
    "grouponNum": "团购数：",
    "discount": "折扣数：",
  };
}
