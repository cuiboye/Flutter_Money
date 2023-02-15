import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_poi_detail_search_params_page.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

class ShowPOIDetailSearchPage extends StatefulWidget {
  @override
  _ShowPOIDetailSearchPageState createState() =>
      _ShowPOIDetailSearchPageState();
}

class _ShowPOIDetailSearchPageState
    extends BMFBaseMapState<ShowPOIDetailSearchPage> {
  final _uidController =
      TextEditingController(text: "ba97895c02a6ddc7f60e775f");

  BMFPoiDetailSearchOption? _detailSearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "POI详情检索",
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
            ShowPOIDetailSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFPoiDetailSearchOption option) {
    if (option.poiUIDs != null) {
      _uidController.text = option.poiUIDs!.join(",");
    }

    _detailSearchOption = option;

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    List<String> poiUIDs = _uidController.text.split(",").toList();
    BMFPoiDetailSearchOption option =
        BMFPoiDetailSearchOption(poiUIDs: poiUIDs);
    if (_detailSearchOption != null) {
      option.scope = _detailSearchOption!.scope;
    }

    /// 检索对象
    BMFPoiDetailSearch detaiSearch = BMFPoiDetailSearch();

    /// 检索回调注册
    detaiSearch.onGetPoiDetailSearchResult(
        callback: _onGetPoiDetailSearchResult);

    /// 发起检索
    bool result = await detaiSearch.poiDetailSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetPoiDetailSearchResult(
      BMFPoiDetailSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索数据 alert msg
    Map resultMap = {"totalPOINum": result.totalPOINum};
    Map firstPOIInfoMap = result.poiInfoList!.first.toMap();
    Map detailInfo = firstPOIInfoMap["detailInfo"];
    firstPOIInfoMap.remove("detailInfo");
    resultMap.addAll(firstPOIInfoMap);
    resultMap.addAll(detailInfo);

    List<String> alertMsgs = [];
    _detailResultMap.forEach((key, value) {
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
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Expanded(
              child: BMFInputBox(
                controller: _uidController,
                title: "POI的UID：",
                placeholder: "输入UID",
              ),
            ),
            BMFSearchBtn(
              height: 40,
              title: "搜索",
              padding: EdgeInsets.all(5),
              onTap: _onTapSearch,
            )
          ],
        ),
      ),
    );
  }

  /// 检索结果alert 数据
  Map<String, String> _detailResultMap = {
    "totalPOINum": "检索结果总数：",
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
