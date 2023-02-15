import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';

class OpenBaiduMapNaviPage extends StatefulWidget {
  OpenBaiduMapNaviPage({Key? key}) : super(key: key);

  @override
  _OpenBaiduMapNaviPageState createState() => _OpenBaiduMapNaviPageState();
}

class _OpenBaiduMapNaviPageState extends State<OpenBaiduMapNaviPage> {
  List<ListTile> _listTiles = [];

  @override
  void initState() {
    super.initState();
    _getListTiles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: BMFAppBar(
        title: '调起百度地图客户端示例',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Scrollbar(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1, color: Colors.blue);
          },
          itemBuilder: _openNaviListItemBuilder,
          itemCount: _listTiles.length,
        ),
      ),
    ));
  }

  Widget _openNaviListItemBuilder(BuildContext context, int index) {
    return _listTiles[index];
  }

  void _getListTiles() {
    _listTiles.add(ListTile(
        title: Text("启动百度地图（驾车导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.DriveNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（新能源车导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.NewEngDriveNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（货车导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.TruckNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（摩托车导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.MotorNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（步行导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.WalkNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（骑行导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.RideNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（步行AR导航）"),
        onTap: () {
          onOpenBaiduNaviNative(BMFNaviType.ARWalkNavi);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（全景图示例）"),
        onTap: () {
          onOpenBaiduMapPanorama();
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（Poi周边）"),
        onTap: () {
          onOpenBaiduMapPoiNear();
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（Poi详情）"),
        onTap: () {
          onOpenBaiduMapPoiDetail();
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（步行路线规划）"),
        onTap: () {
          onOpenBaiduMapRoute(BMFOpenRouteType.WalkingRoute);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（公交路线规划）"),
        onTap: () {
          onOpenBaiduMapRoute(BMFOpenRouteType.TransitRoute);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（驾车路线规划）"),
        onTap: () {
          onOpenBaiduMapRoute(BMFOpenRouteType.DrivingRoute);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（新能源车路线规划）"),
        onTap: () {
          onOpenBaiduMapRoute(BMFOpenRouteType.NewEngDriveoute);
        }));
    _listTiles.add(ListTile(
        title: Text("启动百度地图（货车路线规划）"),
        onTap: () {
          onOpenBaiduMapRoute(BMFOpenRouteType.TruckRoute);
        }));
    setState(() {});
  }

  void onOpenBaiduNaviNative(BMFNaviType naviType) async {
    print("onOpenBaiduNaviNative enter");

    // 我的位置
    BMFCoordinate coordinate1 = BMFCoordinate(39.998691, 116.508936);
    String startName = "我的位置";
    // 百度大厦坐标
    String endName = "百度大厦";
    BMFCoordinate coordinate2 = BMFCoordinate(40.056858, 116.308194);

    BMFOpenNaviOption naviOption = BMFOpenNaviOption(
        startCoord: coordinate1,
        endCoord: coordinate2,
        startName: startName,
        endName: endName,
        naviType: naviType,
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com', // 指定返回自定义scheme
        appName: 'baidumap', // 应用名称
        isSupportWeb:
            false); // 调起百度地图客户端驾车导航失败后（步行、骑行导航设置该参数无效），是否支持调起web地图，默认：true

    BMFOpenErrorCode? flag = await BMFOpenMapUtils.openBaiduMapNavi(naviOption);
    print('open - navi - errorCode = $flag');
  }

  void onOpenBaiduMapPanorama() async {
    BMFOpenPanoramaOption panoramaOption = BMFOpenPanoramaOption(
        poiUid: '61de9e42100f17f0611809de',
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
        isSupportWeb: true);
    BMFOpenErrorCode? flag =
        await BMFOpenMapUtils.openBaiduMapPanorama(panoramaOption);
    print('open - panorama - errorCode = $flag');
  }

  void onOpenBaiduMapPoiNear() async {
    BMFOpenPoiNearOption poiNearOption = BMFOpenPoiNearOption(
        location: BMFCoordinate(40.056858, 116.308194),
        radius: 500,
        keyword: '小吃',
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
        isSupportWeb: true);
    BMFOpenErrorCode? flag =
        await BMFOpenMapUtils.openBaiduMapPoiNear(poiNearOption);
    print('open - poinear - errorCode = $flag');
  }

  void onOpenBaiduMapRoute(BMFOpenRouteType routeType) async {
    // 天安门坐标
    BMFCoordinate startCoord = BMFCoordinate(39.915291, 116.403857);
    String startName = "天安门";
    // 百度大厦坐标
    String endName = "百度大厦";
    BMFCoordinate endCoord = BMFCoordinate(40.05685, 116.308194);
    BMFOpenRouteOption routeOption = BMFOpenRouteOption(
        startCoord: startCoord,
        startName: startName,
        endCoord: endCoord,
        endName: endName,
        routeType: routeType,
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com', // 指定返回自定义scheme
        isSupportWeb: true);
    BMFOpenErrorCode? flag =
        await BMFOpenMapUtils.openBaiduMapRoute(routeOption);
    print('open - route - errorCode = $flag');
  }

  void onOpenBaiduMapPoiDetail() async {
    BMFOpenPoiDetailOption poiDetailOption = BMFOpenPoiDetailOption(
        poiUid: '61de9e42100f17f0611809de',
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
        isSupportWeb: true);
    BMFOpenErrorCode? flag =
        await BMFOpenMapUtils.openBaiduMapPoiDetail(poiDetailOption);
    print('open - poidetail - errorCode = $flag');
  }
}
