import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';

/// 天气检索
class ShowWeatherSearchPage extends StatefulWidget {
  @override
  _ShowWeatherSearchPageState createState() => _ShowWeatherSearchPageState();
}

class _ShowWeatherSearchPageState
    extends BMFBaseMapState<ShowWeatherSearchPage> {
  String _districtValue = '110105';
  BMFCoordinate center = BMFCoordinate(39.90923, 116.447428);

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    myMapController.setMapRegionDidChangeWithReasonCallback(callback:
        (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      if (BMFRegionChangeReason.Gesture == regionChangeReason) {
        onReverseGeoSearch(mapStatus.targetGeoPt!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "天气检索",
      ),
      body: Stack(
        children: [
          Align(
            child: generateMap(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: generateControlBar(),
          ),
          Align(
            child: Image(
              alignment: Alignment.center,
              image: AssetImage("resoures/water_drop.png"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 50,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '行政区域id: ' + _districtValue,
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    '检索天气',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onWeatherSearch();
                  }),
            ],
          )
        ],
      ),
    );
  }

  void onWeatherSearch() async {
    BMFWeatherSearch weatherSearch = BMFWeatherSearch();

    BMFWeatherSearchOption weatherSearchOption = BMFWeatherSearchOption(
      districtID: _districtValue,
      dataType: BMFWeatherDataType.All,
      languageType: BMFLanguageType.Chinese,
      serverType: BMFWeatherServerType.Default,
    );

    bool result = await weatherSearch.weatherSearch(weatherSearchOption);
    print('result = $result');
    weatherSearch.onGetWeatherSearchResult(callback:
        (BMFWeatherSearchResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        var error = "检索失败" + "errorCode:${errorCode.toString()}";
        showToast(context, error);
        print(error);
        return;
      }
      BMFWeatherSearchNow? realTimeResult = result.realTimeWeather;
      if (realTimeResult == null) {
        return;
      }
      Map resultMap = realTimeResult.toMap();
      List<String> alertMsgs = [];
      _weatherResultMap.forEach((key, value) {
        String tmpStr;
        if (key.contains(".")) {
          String key0 = key.substring(0, key.indexOf("."));
          String key1 = key.substring(key.indexOf(".") + 1);
          tmpStr = value;
          tmpStr += "${resultMap[key0]}" + key1;
        } else {
          tmpStr = value;
          tmpStr += "${resultMap[key]}";
        }

        alertMsgs.add(tmpStr);
      });

      String alertMsg = alertMsgs.join("\n");
      showSearchResultAlertDialog(context, alertMsg);
      print(result.toMap());
    });
  }

  void onReverseGeoSearch(BMFCoordinate target) async {
    /// 检索参数
    BMFReverseGeoCodeSearchOption option = BMFReverseGeoCodeSearchOption(
      location: target,
      radius: 500,
    );

    /// 检索对象
    BMFReverseGeoCodeSearch reverseGeoCodeSearch = BMFReverseGeoCodeSearch();

    Future future = reverseGeoCodeSearch.reverseGeoCodeSearch(option);
    future.then((value) => {print('result = $value')});

    reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(callback:
        (BMFReverseGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        var error = "检索失败" + "errorCode:${errorCode.toString()}";
        showToast(context, error);
        print(error);
        return;
      }
      if (result.addressDetail == null) {
        return;
      }
      setState(() {
        _districtValue = result.addressDetail!.adCode ?? "";
      });
    });
  }

  /// 检索结果 alert 数据
  Map<String, String> _weatherResultMap = {
    "relativeHumidity.%": "相对湿度：",
    "sensoryTemp.℃": "体感温度：",
    "phenomenon": "天气现象：",
    "windDirection": "风向：",
    "windPower": "风力：",
    "temperature.℃": "温度：",
    "updateTime": "更新时间：",
  };
}
