import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';

import '../../constants.dart';

/// 室内地图示例
class ShowIndoorMapPage extends StatefulWidget {
  ShowIndoorMapPage({Key? key}) : super(key: key);

  @override
  _ShowIndoorMapPageState createState() => _ShowIndoorMapPageState();
}

class _ShowIndoorMapPageState extends BMFBaseMapState<ShowIndoorMapPage> {
  /// 地图controller
  bool _isShowIndoorPoi = true;
  bool _isShowIndoorMap = true;
  bool _isShowFloorListView = false;
  int? _floorSelectedIdx;
  BMFBaseIndoorMapInfo? _indoorMapInfo;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 获取室内图信息
    getCurrentIndoorInfo();

    /// 地图View进入/移出室内图会调用此方法
    /// flag YES:进入室内图，false：移出室内图
    /// baseIndoorMapInfo 室内图信息
    myMapController.setMapInOrOutBaseIndoorMapCallback(
        callback: (bool flag, BMFBaseIndoorMapInfo baseIndoorMapInfo) {
      setState(() {
        _indoorMapInfo = baseIndoorMapInfo;
        _isShowFloorListView = flag;
      });
      print(
          '地图View进入/移出室内图会调用此方法\n flag=$flag + MapInfo=${baseIndoorMapInfo.toMap()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
          appBar: BMFAppBar(
            title: '室内地图示例',
            onBack: () {
              Navigator.pop(context);
            },
          ),
          body: Container(
            child: Stack(children: <Widget>[
              generateMap(),
              generateControlBar(),
              _floorListView(),
            ]),
          )),
    );
  }

  /// 设置地图参数
  @override
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.379341),
        zoomLevel: 19,
        mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
        baseIndoorMapEnabled: _isShowIndoorMap,
        showIndoorMapPoi: _isShowIndoorPoi);
    return mapOptions;
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 60,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Switch(
              value: _isShowIndoorPoi,
              activeColor: Colors.blue,
              onChanged: (bool value) async {
                setState(() {
                  _isShowIndoorPoi = value;
                });
                // 是否显示室内标注
                await myMapController.showBaseIndoorMapPoi(_isShowIndoorPoi);
              }),
          Text(
            '显示室内Poi',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 20),
          Switch(
              value: _isShowIndoorMap,
              activeColor: Colors.blue,
              onChanged: (bool value) async {
                setState(() {
                  _isShowIndoorMap = value;
                  _isShowFloorListView = value;
                });
                // 是否展示室内地图
                await myMapController.showBaseIndoorMap(_isShowIndoorMap);

                //室内图的开启和关闭会同时开启和关闭室内poi，所以这里重新设置下室内poi状态，保持室内poi显示和开关状态一致
                await myMapController.showBaseIndoorMapPoi(_isShowIndoorPoi);
              }),
          Text(
            '显示室内地图',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// 楼层ListView
  Widget _floorListView() {
    return Visibility(
      visible: _isShowFloorListView,
      child: Positioned(
        left: 10,
        bottom: 50,
        child: Container(
          width: 35,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(width: 1.0, color: Colors.grey.withAlpha(100))),
          child: ListView.builder(
            itemBuilder: _floorListItemBuilder,
            itemCount: _indoorMapInfo?.listStrFloors?.length,
          ),
        ),
      ),
    );
  }

  Widget _floorListItemBuilder(BuildContext context, int index) {
    var floor = "";
    if (_indoorMapInfo != null) {
      floor = _indoorMapInfo!.listStrFloors![index];
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        color:
            _floorSelectedIdx == index ? Colors.lightBlueAccent : Colors.white,
        child: Text(
          floor,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      onTap: () => _onTapFloorItem(index, floor),
    );
  }

  void _onTapFloorItem(int idx, String floorID) {
    setState(() {
      _floorSelectedIdx = idx;
    });

    switchBaseIndoorMapFloor(floorID, _indoorMapInfo!.strID ?? "");
  }

  /// 获取当前室内信息
  void getCurrentIndoorInfo() async {
    BMFBaseIndoorMapInfo? info =
        await myMapController.getFocusedBaseIndoorMapInfo();
    setState(() {
      _indoorMapInfo = info;
      if (info != null && info.listStrFloors != null) {
        _isShowFloorListView = info.listStrFloors!.length > 0;
      }
    });
    print('获取当前室内信息info=${_indoorMapInfo?.toMap()}');
  }

  /// 切换室内楼层
  void switchBaseIndoorMapFloor(String floorId, String indoorId) async {
    BMFSwitchIndoorFloorError error =
        await myMapController.switchBaseIndoorMapFloor(floorId, indoorId);
    print('切换室内楼层error=$error');
  }
}
