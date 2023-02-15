import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/input_box.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

class ShowBuildingSearchPage extends StatefulWidget {
  @override
  _ShowBuildingSearchPageState createState() => _ShowBuildingSearchPageState();
}

class _ShowBuildingSearchPageState extends BMFBaseMapState<ShowBuildingSearchPage> {
  final _latController = TextEditingController(text: "23.02738");
  final _lonController = TextEditingController(text: "113.748139");

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '地图建筑物检索',
        ),
        body: Column(
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

  /// 检索
  void _onTapSearch() async {
    /// 检索参数
    BMFCoordinate coordinate = BMFCoordinate(
        double.parse(_latController.text), double.parse(_lonController.text));
    BMFBuildingSearchOption option =
    BMFBuildingSearchOption(location: coordinate);

    /// 检索对象
    BMFBuildingSearch buildingSearch = BMFBuildingSearch();

    /// 注册检索回调
    buildingSearch.onGetBuildingSearchResult(callback: _onBuildingSearchResult);

    /// 发起检索
    bool result = await buildingSearch.buildingSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索回调
  void _onBuildingSearchResult(
      BMFBuildingSearchResult result, BMFSearchErrorCode errorCode) {
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
    _buildingResultMap.forEach((key, value) {
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

  Map<String, String> _buildingResultMap = {
    "buildingList.height": "高度：",
    "buildingList.paths": "加密的面：",
    "buildingList.center": "加密的中心点：",
    "buildingList.accuracy": "准确度：",
  };
}

