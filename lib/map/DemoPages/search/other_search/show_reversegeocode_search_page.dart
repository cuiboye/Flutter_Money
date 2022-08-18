import 'package:flutter/material.dart';

import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/other_search_params/show_reversegeocode_search_params_page.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

/// 逆地理编码
class ShowRGCSearchPage extends StatefulWidget {
  @override
  _ShowRGCSearchPageState createState() => _ShowRGCSearchPageState();
}

class _ShowRGCSearchPageState extends BMFBaseMapState<ShowRGCSearchPage> {
  final _latController = TextEditingController(text: "40.049850");
  final _lonController = TextEditingController(text: "116.279920");

  BMFReverseGeoCodeSearchOption? _reverseGeoCodeSearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "逆地理编码",
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
        builder: (context) => ShowReversegeocodeSearchParamsPage(
            callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFReverseGeoCodeSearchOption option) {
    if (option.location != null) {
      _latController.text = "${option.location?.latitude}";
      _lonController.text = "${option.location?.longitude}";
    }

    _reverseGeoCodeSearchOption = option;

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFCoordinate coordinate = BMFCoordinate(
        double.parse(_latController.text), double.parse(_lonController.text));
    BMFReverseGeoCodeSearchOption option =
        BMFReverseGeoCodeSearchOption(location: coordinate);
    if (_reverseGeoCodeSearchOption != null) {
      option.isLatestAdmin = _reverseGeoCodeSearchOption?.isLatestAdmin;
    }

    /// 检索对象
    BMFReverseGeoCodeSearch reverseGeoCodeSearch = BMFReverseGeoCodeSearch();

    /// 注册检索回调
    reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(callback: _onGetReverseGeoCodeSearchResult);

    /// 发起检索
    bool result = await reverseGeoCodeSearch.reverseGeoCodeSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索回调
  void _onGetReverseGeoCodeSearchResult(
      BMFReverseGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索结果 alert msg
    Map resultMap = result.toMap();
    List<String> alertMsgs = [];
    List? tmpList;
    _rgcResultMap.forEach((key, value) {
      String msg = value;
      if (key.contains(".")) {
        List keys = key.split(".");
        dynamic subMap = resultMap;
        for (String subKey in keys) {
          if (subMap[subKey] is List) {
            tmpList = subMap[subKey];
            if (null != tmpList && tmpList!.isNotEmpty) {
              subMap = tmpList![0];
            }
          } else if (subMap[subKey] is Map) {
            if (null != subMap && subMap.isNotEmpty) {
              subMap = subMap[subKey];
            }
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
              child: Column(
                children: [
                  BMFInputBox(
                    controller: _latController,
                    title: "纬度：",
                    placeholder: "输入纬度",
                  ),
                  BMFInputBox(
                    controller: _lonController,
                    title: "经度：",
                    placeholder: "输入经度",
                  ),
                ],
              ),
            ),
            BMFSearchBtn(
              height: 75,
              title: "搜索",
              padding: EdgeInsets.all(5),
              onTap: _onTapSearch,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _rgcResultMap = {
    "location.latitude": "纬度：",
    "location.longitude": "经度：",
    "address": "地址名称：",
    "businessCircle": "商圈名称：",
    "confidence": "可信度：",
    "addressDetail.country": "国家名称：",
    "addressDetail.province": "省份名称：",
    "addressDetail.city": "城市名称：",
    "addressDetail.district": "区县名称：",
    "addressDetail.town": "乡镇：",
    "addressDetail.streetName": "街道名称：",
    "addressDetail.streetNumber": "街道号码：",
    "addressDetail.adCode": "行政区域编码：",
    "addressDetail.countryCode": "国家代码：",
    "addressDetail.direction": "方向：",
    "addressDetail.distance": "距离：",
    "poiList.name": "POI名称：",
    "poiList.pt.latitude": "POI纬度坐标：",
    "poiList.pt.longitude": "POI经度坐标：",
    "poiList.address": "POI地址信息：",
    "poiList.phone": "POI电话号码：",
    "poiList.uid": "POI的唯一标识符：",
    "poiList.province": "POI所在省份：",
    "poiList.city": "POI所在城市：",
    "poiList.area": "POI所在行政区域：",
    "poiList.streetID": "街景ID：",
    "poiList.hasDetailInfo": "是否有详情信息：",
    "poiList.direction": "POI方向：",
    "poiList.distance": "POI距离：",
    "poiList.zipCode": "POI邮编：",
    "poiList.tag": "POI类别tag：",
    "poiRegions.regionDescription": "相对位置关系：",
    "poiRegions.regionName": "归属区域面名称：",
    "poiRegions.regionTag": "归属区域面类型：",
    "sematicDescription": "语义化结果描述：",
  };
}
