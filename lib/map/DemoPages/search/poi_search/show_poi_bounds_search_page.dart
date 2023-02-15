import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_poi_bounds_search_params_page.dart';

class ShowPOIBoundsSearchPage extends StatefulWidget {
  @override
  _ShowPOIBoundsSearchPageState createState() =>
      _ShowPOIBoundsSearchPageState();
}

class _ShowPOIBoundsSearchPageState
    extends BMFBaseMapState<ShowPOIBoundsSearchPage> {
  final _leftLatController = TextEditingController(text: "40.049557");
  final _leftLonController = TextEditingController(text: "116.279295");
  final _rightLatController = TextEditingController(text: "40.056057");
  final _rightLonController = TextEditingController(text: "116.308102");
  final _keywordController = TextEditingController(text: "小吃,学校");

  BMFPoiBoundSearchOption? _boundSearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "POI区域检索",
        onBack: () {
          Navigator.pop(context);
        },
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
            ShowPOIBoundsSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFPoiBoundSearchOption option) {
    _keywordController.text = option.keywords?.join(",") ?? "";

    if (option.leftBottom != null) {
      _leftLatController.text = "${option.leftBottom?.latitude}";
      _leftLonController.text = "${option.leftBottom?.longitude}";
    }

    if (option.rightTop != null) {
      _rightLatController.text = "${option.rightTop?.latitude}";
      _rightLonController.text = "${option.rightTop?.longitude}";
    }

    _boundSearchOption = option;

    _onTapSearch();
  }

  /// 搜索
  void _onTapSearch() async {
    /// 检索参数
    BMFCoordinate? leftBottom;
    BMFCoordinate? rightTop;
    if (_leftLatController.text.isNotEmpty &&
        _leftLonController.text.isNotEmpty) {
      leftBottom = BMFCoordinate(double.parse(_leftLatController.text),
          double.parse(_leftLonController.text));
    }

    if (_leftLatController.text.isNotEmpty &&
        _leftLonController.text.isNotEmpty) {
      rightTop = BMFCoordinate(double.parse(_rightLatController.text),
          double.parse(_rightLonController.text));
    }

    List<String> keywords = _keywordController.text.split(",").toList();

    /// 检索参数对象
    BMFPoiBoundSearchOption option = BMFPoiBoundSearchOption(
        leftBottom: leftBottom,
        rightTop: rightTop,
        keywords: keywords,
        scope: BMFPoiSearchScopeType.DETAIL_INFORMATION);
    if (_boundSearchOption != null) {
      option.tags = _boundSearchOption?.tags;
      option.pageSize = _boundSearchOption?.pageSize;
      option.pageIndex = _boundSearchOption?.pageIndex;
      option.scope = _boundSearchOption?.scope;
      option.filter = _boundSearchOption?.filter;

      print(option.filter?.sortBasis);
    }

    /// 检索对象
    BMFPoiBoundSearch boundSearch = BMFPoiBoundSearch();

    /// 检索回调
    boundSearch.onGetPoiBoundsSearchResult(
        callback: _onGetPoiBoundsSearchResult);

    /// 发起检索
    bool result = await boundSearch.poiBoundsSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 搜索结果
  void _onGetPoiBoundsSearchResult(
      BMFPoiSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索结果标注
    List<BMFMarker> markers = [];
    for (BMFPoiInfo poiInfo in result.poiInfoList!) {
      BMFMarker marker = BMFMarker.icon(
        position: poiInfo.pt!,
        title: poiInfo.name,
        subtitle: poiInfo.address,
        icon: "resoures/pin_red.png",
      );
      markers.add(marker);
    }
    myMapController.cleanAllMarkers();
    myMapController.addMarkers(markers);
    myMapController.setCenterCoordinate(markers[0].position, true);

    /// 检索结果 alert msg
    Map resultMap = result.toMap();
    Map firstPOIMap = resultMap["poiInfoList"][0];
    Map? detailInfoMap = firstPOIMap["detailInfo"];
    resultMap.remove("poiInfoList");
    firstPOIMap.remove("detailInfo");
    resultMap.addAll(firstPOIMap);
    if (null != detailInfoMap) {
      resultMap.addAll(detailInfoMap);
    }

    List<String> alertMsgs = [];
    _boundsResultMap.forEach((key, value) {
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
        height: (35.0 * 5 + 5.0),
        margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    BMFInputBox(
                        controller: _leftLatController,
                        title: "左下纬度：",
                        placeholder: "输入纬度"),
                    BMFInputBox(
                        controller: _leftLonController,
                        title: "左下经度：",
                        placeholder: "输入精度"),
                    BMFInputBox(
                        controller: _rightLatController,
                        title: "右上纬度：",
                        placeholder: "输入纬度"),
                    BMFInputBox(
                        controller: _rightLonController,
                        title: "右上经度：",
                        placeholder: "输入精度"),
                    BMFInputBox(
                        controller: _keywordController,
                        title: "    关键字：",
                        placeholder: "输入关键字")
                  ],
                ),
              ),
            ),
            BMFSearchBtn(
              height: (35.0 * 5 + 5),
              title: "搜索",
              padding: EdgeInsets.all(5),
              onTap: _onTapSearch,
            )
          ],
        ),
      ),
    );
  }

  /// 检索结果 alert 数据
  Map<String, String> _boundsResultMap = {
    "totalPOINum": "检索结果总数：",
    "totalPageNum": "总页数：",
    "curPOINum": "当前页的结果数：",
    "curPageIndex": "当前页的页数索引：",
    "name": "名称：",
    "pt.latitude": "纬度：",
    "pt.longitude": "经度：",
    "address": "地址：",
    "phone": "电话：",
    "uid": "UID：",
    "province": "省份：",
    "city": "城市：",
    "area": "行政区域：",
    "streetID": "街景图ID：",
    "hasDetailInfo": "是否有详细信息：",
    "distance": "距离中心点的距离：",
    "type": "类型：",
    "tag": "标签：",
    "naviLocation.latitude": "导航引导点坐标纬度：",
    "naviLocation.longitude": "导航引导点坐标经度：",
    "detailURL": "详情页URL：",
    "price": "商户的价格：",
    "openingHours": "营业时间：",
    "overallRating": "总体评分：",
    "tasteRating": "口味评分：",
    "serviceRating": "服务评分：",
    "environmentRating": "环境评分：",
    "facilityRating": "星级评分：",
    "hygieneRating": "卫生评分：",
    "technologyRating": "技术评分：",
    "imageNumber": "图片数目：",
    "grouponNumber": "团购数目：",
    "discountNumber": "优惠数目：",
    "commentNumber": "评论数目：",
    "favoriteNumber": "收藏数目：",
    "checkInNumber": "签到数目：",
  };
}
