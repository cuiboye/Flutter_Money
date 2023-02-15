import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/other_search_params/show_geocode_search_params_page.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

/// 地理编码
class ShowGCSearchPage extends StatefulWidget {
  @override
  _ShowGCSearchPageState createState() => _ShowGCSearchPageState();
}

class _ShowGCSearchPageState extends BMFBaseMapState<ShowGCSearchPage> {
  final _cityController = TextEditingController(text: "北京");
  final _addressController = TextEditingController(text: "百度大厦");

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "地理编码",
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
            ShowGeocodeSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFGeoCodeSearchOption option) {
    _cityController.text = option.city ?? "";
    _addressController.text = option.address ?? "";

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFGeoCodeSearchOption option = BMFGeoCodeSearchOption(
        city: _cityController.text, address: _addressController.text);

    /// 检索对象
    BMFGeocodeSearch geocodeSearch = BMFGeocodeSearch();

    /// 注册检索结果回调
    geocodeSearch.onGetGeoCodeSearchResult(callback: _onGetGeoCodeSearchResult);

    /// 发起检索
    bool result = await geocodeSearch.geoCodeSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索回调
  void _onGetGeoCodeSearchResult(
      BMFGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    /// 检索结果 marker
    BMFMarker marker = BMFMarker.icon(
      position: result.location!,
      title: _addressController.text,
      icon: "resoures/pin_red.png",
    );
    myMapController.cleanAllMarkers();
    myMapController.addMarker(marker);
    myMapController.setCenterCoordinate(result.location!, true);

    /// 检索结果 alert msg
    List<String> alertMsgs = [];
    String lat = "纬度：" + "${result.location?.latitude}";
    String lon = "经度：" + "${result.location?.longitude}";
    String precise = "是否精确查找：" + "${result.precise}";
    String confidence = "可信度：" + "${result.confidence}";
    String level = "地址类型：" + "${result.level}";
    alertMsgs.add(lat);
    alertMsgs.add(lon);
    alertMsgs.add(precise);
    alertMsgs.add(confidence);
    alertMsgs.add(level);
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
                    controller: _addressController,
                    title: "地址：",
                    placeholder: "输入地址",
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
}
