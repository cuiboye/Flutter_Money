import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';

/// 短串分享功能入口
class MapSharePage extends StatefulWidget {
  MapSharePage({Key? key}) : super(key: key);

  @override
  _MapSharePageState createState() => _MapSharePageState();
}

class _MapSharePageState extends BMFBaseMapState<MapSharePage> {
  var _routeShareMode = BMFRoutePlanShareURLType.WALK;

  /// 搜索城市
  final String city = '北京';

  /// 搜索关键字
  final String searchKey = '小吃';

  /// 添加地图marker数据
  BMFMarker? _addrMarker;
  List<BMFPoiInfo>? poiInfoList;
  List<BMFMarker>? poiMarkers = [];
  String? currentAddr;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 地图marker点击回调
    myMapController.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
      if (_addrMarker != null &&
          currentAddr != null &&
          _addrMarker?.id == marker.id) {
        onLocationShare(_addrMarker!);
      }
      if (poiMarkers != null && poiInfoList != null) {
        for (var i = 0; i < poiMarkers!.length; i++) {
          if (poiMarkers![i].id == marker.id) {
            currentAddr = poiInfoList![i].address;
            onPoiDetailShare(poiInfoList![i].uid!);
          }
        }
      }
    });
  }

  void onLocationShare(BMFMarker marker) async {
    BMFReverseGeoShareUrlSearch reverseGeoShareUrlSearch =
        BMFReverseGeoShareUrlSearch();
    BMFReverseGeoShareURLOption option = BMFReverseGeoShareURLOption(
        name: marker.title, snippet: '测试分享点', location: marker.position);

    bool result =
        await reverseGeoShareUrlSearch.reverseGeoShareUrlSearch(option);

    reverseGeoShareUrlSearch.onGetReverseGeoShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        return;
      }

      // /// 分享短串结果
      // Share.share("您的朋友通过百度地图SDK与您分享一个位置: " +
      //     (currentAddr ?? "") +
      //     " -- " +
      //     (result.url ?? "") +
      //     "将短串分享到");
    });

    print('result = $result');
  }

  void onRouteShare() async {
    BMFPlanNode startNode =
        BMFPlanNode(pt: BMFCoordinate(40.056885, 116.308142));
    BMFPlanNode endNode = BMFPlanNode(pt: BMFCoordinate(39.921933, 116.488962));

    BMFRoutePlanShareUrlSearch routePlanShareUrlSearch =
        BMFRoutePlanShareUrlSearch();
    BMFRoutePlanShareURLOption option = BMFRoutePlanShareURLOption(
      from: startNode,
      to: endNode,
      routePlanType: _routeShareMode,
    );

    routePlanShareUrlSearch.routePlanShareUrlSearch(option);

    routePlanShareUrlSearch.onGetRoutePlanShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        return;
      }

      /// 分享短串结果
      // Share.share(
      //     "您的朋友通过百度地图SDK与您分享一条路线，URL -- " + (result.url ?? "") + "将短串分享到");
    });
  }

  void onPoiDetailShare(String uid) async {
    BMFPoiDetailShareUrlSearch poiDetailShareUrlSearch =
        BMFPoiDetailShareUrlSearch();

    BMFPoiDetailShareURLOption option = BMFPoiDetailShareURLOption(
      uid: uid,
    );

    bool result = await poiDetailShareUrlSearch.poiDetailShareUrlSearch(option);
    print('result = $result');

    poiDetailShareUrlSearch.onGetPoiDetailShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        return;
      }

      /// 分享短串结果
      // Share.share("您的朋友通过百度地图SDK与您分享一个POI点详情: " +
      //     (currentAddr ?? "") +
      //     " -- " +
      //     (result.url ?? "") +
      //     "将短串分享到");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '短串分享',
          onBack: () {
            Navigator.pop(context);
          },
        ),
        body: Stack(children: <Widget>[generateMap(), generateControlBar()]),
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 145,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    'POI搜素结果分享',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onPoiSearchShare();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    '反向地理编码分享',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onGeoCodeShare();
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: <Widget>[
                  Radio(
                    value: BMFRoutePlanShareURLType.WALK,
                    groupValue: this._routeShareMode,
                    onChanged: (value) {
                      setState(() {
                        this._routeShareMode =
                            value as BMFRoutePlanShareURLType;
                      });
                    },
                  ),
                  Text(
                    "步行",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: BMFRoutePlanShareURLType.RIDE,
                    groupValue: this._routeShareMode,
                    onChanged: (value) {
                      setState(() {
                        this._routeShareMode =
                            value as BMFRoutePlanShareURLType;
                      });
                    },
                  ),
                  Text(
                    "骑行",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: BMFRoutePlanShareURLType.DRIVE,
                    groupValue: this._routeShareMode,
                    onChanged: (value) {
                      setState(() {
                        this._routeShareMode =
                            value as BMFRoutePlanShareURLType;
                      });
                    },
                  ),
                  Text(
                    "驾车",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: BMFRoutePlanShareURLType.TRANSIT,
                    groupValue: this._routeShareMode,
                    onChanged: (value) {
                      setState(() {
                        this._routeShareMode =
                            value as BMFRoutePlanShareURLType;
                      });
                    },
                  ),
                  Text(
                    "公交",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    '路线分享',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onRouteShare();
                  }),
              Text(
                '点击地图上的搜索结果进行短串分享',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onPoiSearchShare() async {
    /// 检索对象
    BMFPoiCitySearch poiCitySearch = BMFPoiCitySearch();

    /// 检索参数
    BMFPoiCitySearchOption citySearchOption = BMFPoiCitySearchOption(
      city: city,
      keyword: searchKey,
    );

    bool result = await poiCitySearch.poiCitySearch(citySearchOption);

    poiCitySearch.onGetPoiCitySearchResult(callback: _onGetPoiCitySearchResult);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  void _onGetPoiCitySearchResult(
      BMFPoiSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      return;
    }

    /// List<BMFMarker> poiMarkers = [];
    poiMarkers?.clear();
    poiInfoList = result.poiInfoList;

    if (result.poiInfoList == null) return;

    /// 添加poi marker
    for (BMFPoiInfo poiInfo in result.poiInfoList!) {
      BMFMarker marker = BMFMarker.icon(
          position: poiInfo.pt!,
          title: poiInfo.name,
          icon: "resoures/animation_red.png");
      poiMarkers?.add(marker);
    }

    myMapController.cleanAllMarkers();
    myMapController.addMarkers(poiMarkers!);
    myMapController.setCenterCoordinate(poiMarkers!.first.position, true);
  }

  void onGeoCodeShare() async {
    /// 检索参数
    BMFReverseGeoCodeSearchOption option = BMFReverseGeoCodeSearchOption(
      location: BMFCoordinate(39.961848, 116.374661),
    );

    /// 检索对象
    BMFReverseGeoCodeSearch reverseGeoCodeSearch = BMFReverseGeoCodeSearch();

    bool result = await reverseGeoCodeSearch.reverseGeoCodeSearch(option);

    reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(
        callback: _onGetReverseGeoCodeSearchResult);

    print('result = $result');
  }

  void _onGetReverseGeoCodeSearchResult(
      BMFReverseGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      return;
    }
    myMapController.cleanAllMarkers();
    _addrMarker = BMFMarker.icon(
      position: result.location!,
      icon: 'resoures/icon_mark.png',
      title: result.address,
    );
    currentAddr = result.address;
    print(result.toMap());
    myMapController.addMarker(_addrMarker!);
    myMapController.setCenterCoordinate(_addrMarker!.position, true);
  }
}
