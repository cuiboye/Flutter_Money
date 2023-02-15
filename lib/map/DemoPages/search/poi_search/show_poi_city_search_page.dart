import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_poi_city_search_params_page.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import '../../../CustomWidgets/input_box.dart';

/// POI城市内检索
class ShowPOICitySearchPage extends StatefulWidget {
  @override
  _ShowPOICitySearchPageState createState() => _ShowPOICitySearchPageState();
}

class _ShowPOICitySearchPageState
    extends BMFBaseMapState<ShowPOICitySearchPage> {
  final _cityController = TextEditingController(text: "北京");
  final _keywordController = TextEditingController(text: "小吃");

  /// 自定义检索参数
  BMFPoiCitySearchOption? _citySearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: BMFAppBar(
        title: "POI城市内检索",
        onBack: () {
          Navigator.pop(context);
        },
        actions: [
          BMFSearchBtn(
            title: "详细参数",
            color: Color(int.parse(Constants.actionBarColor)),
            onTap: () {
              _onTapParamsPage(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: generateMap(),
            ),
            _bottomSearchBar()
          ],
        ),
      ),
    );
  }

  /// 参数设置
  void _onTapParamsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShowPOICitySearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFPoiCitySearchOption option) {
    _cityController.text = option.city ?? "";
    _keywordController.text = option.keyword ?? "";

    _citySearchOption = option;

    _onTapSearch();
  }

  /// 搜索
  void _onTapSearch() async {
    /// 检索参数
    BMFPoiCitySearchOption citySearchOption = BMFPoiCitySearchOption(
        city: _cityController.text,
        keyword: _keywordController.text,
        scope: BMFPoiSearchScopeType.DETAIL_INFORMATION);

    if (_citySearchOption != null) {
      citySearchOption.tags = _citySearchOption?.tags;
      citySearchOption.pageIndex = _citySearchOption?.pageIndex;
      citySearchOption.pageSize = _citySearchOption?.pageSize;
      citySearchOption.scope = _citySearchOption?.scope;
      citySearchOption.isCityLimit = _citySearchOption?.isCityLimit;
      citySearchOption.filter = _citySearchOption?.filter;
    }

    /// 检索对象
    BMFPoiCitySearch citySearch = BMFPoiCitySearch();

    /// 检索回调
    citySearch.onGetPoiCitySearchResult(callback: _onGetPoiCitySearchResult);

    /// 发起检索
    bool result = await citySearch.poiCitySearch(citySearchOption);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索回调
  void _onGetPoiCitySearchResult(
      BMFPoiSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 添加poi marker
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
    myMapController.setCenterCoordinate(markers.first.position, true);

    /// 处理alert数据
    Map resultMap = {
      "totalPageNum": result.totalPageNum,
      "curPageIndex": result.curPageIndex,
      "totalPOINum": result.totalPOINum,
      "curPOINum": result.curPOINum,
    };
    Map fistPoiInfo = result.poiInfoList!.first.toMap();
    Map? detailInfo = fistPoiInfo["detailInfo"];
    fistPoiInfo.remove("detailInfo");
    resultMap.addAll(fistPoiInfo);

    if (null != detailInfo) {
      resultMap.addAll(detailInfo);
    }

    List<String> texts = [];
    _cityResultMap.forEach((key, value) {
      String? tmpStr;
      if (key.contains(".")) {
        String key0 = key.substring(0, key.indexOf("."));
        Map? keyMap = resultMap[key0];
        String key1 = key.substring(key.indexOf(".") + 1);
        if (null != keyMap) {
          tmpStr = "${keyMap[key1]}";
        }
      } else {
        tmpStr = "${resultMap[key]}";
      }

      String text;
      if (null != tmpStr) {
        text = value + tmpStr;
      } else {
        text = value;
      }
      texts.add(text);
    });

    String alertMsg = texts.join("\n");

    /// 检索结果alert
    showSearchResultAlertDialog(context, alertMsg);
  }

  /// search bar
  Widget _bottomSearchBar() {
    return SafeArea(
      child: Container(
        height: (35.0 * 2 + 5.0),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    BMFInputBox(
                      controller: _cityController,
                      title: "    城市：",
                      placeholder: "输入城市",
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
              height: (35.0 * 2 + 5.0),
              title: "搜索",
              padding: EdgeInsets.all(5),
              onTap: _onTapSearch,
            )
          ],
        ),
      ),
    );
  }

  Map<String, String> _cityResultMap = {
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
