import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/DemoPages/search/other_search_params/show_suggestion_search_params_page.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

class ShowSuggestionSearchPage extends StatefulWidget {
  @override
  _ShowSuggestionSearchPageState createState() =>
      _ShowSuggestionSearchPageState();
}

class _ShowSuggestionSearchPageState
    extends BMFBaseMapState<ShowSuggestionSearchPage> {
  final _cityController = TextEditingController(text: "北京");
  final _keywordController = TextEditingController(text: "中关村");

  BMFSuggestionSearchOption? _suggestionSearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "sug检索",
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
            ShowSuggestionSearchParamsPage(callBack: _searchParamsPageCallBack),
      ),
    );
  }

  /// 自定义参数回调
  void _searchParamsPageCallBack(BMFSuggestionSearchOption option) {
    _keywordController.text = option.keyword ?? "";
    _cityController.text = option.cityname ?? "";

    _suggestionSearchOption = option;

    _onTapSearch();
  }

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFSuggestionSearchOption option = BMFSuggestionSearchOption(
        cityname: _cityController.text, keyword: _keywordController.text);
    if (_suggestionSearchOption != null) {
      option.cityLimit = _suggestionSearchOption?.cityLimit;
    }

    /// 检索对象
    BMFSuggestionSearch search = BMFSuggestionSearch();

    /// 检索回调
    search.onGetSuggestSearchResult(callback: _onGetSuggestSearchResult);

    /// 发起检索
    bool result = await search.suggestionSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetSuggestSearchResult(
      BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }
    print(result.suggestionList?.first.district);

    if (result.suggestionList == null) return;

    /// 检索结果标注
    List<BMFMarker> markers = [];
    for (BMFSuggestionInfo info in result.suggestionList!) {
      BMFMarker marker = BMFMarker.icon(
        position: info.location!,
        icon: "resoures/pin_red.png",
        title: info.key,
        subtitle: info.address,
      );
      markers.add(marker);
    }

    myMapController.cleanAllMarkers();
    myMapController.addMarkers(markers);
    myMapController.setCenterCoordinate(markers.first.position, true);

    /// 检索结果数据
    List<String> alertMsg = [];
    BMFSuggestionInfo firstInfo = result.suggestionList!.first;
    String key = "key：" + "${firstInfo.key}";
    String city = "城市：" + "${firstInfo.city}";
    String district = "区县：" + "${firstInfo.district}";
    String uid = "POI的唯一标识：" + "${firstInfo.uid}";
    String lat = "纬度：" + "${firstInfo.location?.latitude}";
    String lon = "经度：" + "${firstInfo.location?.longitude}";
    alertMsg.add(key);
    alertMsg.add(city);
    alertMsg.add(district);
    alertMsg.add(uid);
    alertMsg.add(lat);
    alertMsg.add(lon);

    showSearchResultAlertDialog(context, alertMsg.join("\n"));
  }

  /// search bar
  Widget _bottomSearchBar() {
    return SafeArea(
        child: Container(
      height: (35.0 * 2 + 5),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
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
                )
              ],
            ),
          ),
          BMFSearchBtn(
            height: (35.0 * 2 + 5),
            title: "搜索",
            padding: EdgeInsets.all(5),
            onTap: _onTapSearch,
          ),
        ],
      ),
    ));
  }
}
