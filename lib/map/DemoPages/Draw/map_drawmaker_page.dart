import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';

/// marker绘制示例
class DrawMarkerPage extends StatefulWidget {
  DrawMarkerPage({
    Key? key,
  }) : super(key: key);

  @override
  _DrawMarkerPageState createState() => _DrawMarkerPageState();
}

class DragState {
  ///开始拖拽
  static const String sDragStart = "dragStart";

  /// 正在拖拽
  static const String sDragging = "dragging";

  ///拖拽完成
  static const String sDragEnd = "dragEnd";
}

class _DrawMarkerPageState extends BMFBaseMapState<DrawMarkerPage> {
  /// 地图controller
  late BMFMarker _marker;
  late BMFMarker _marker0;
  late BMFMarker _marker1;
  List<BMFMarker>? _markers;
  String? _markerID;
  String? _action;
  String? _state;
  bool _show = true;
  BMFCoordinate? _coordinates;

  final BMFCoordinate _startPos = BMFCoordinate(39.928617, 116.30329);
  final BMFCoordinate _endPos = BMFCoordinate(39.928617, 116.50329);

  bool _addState = false;
  String _btnText = "删除";

  Timer? _timer;

  bool enable = false;
  bool dragable = false;

  bool startState = true;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addMarkers();
    }

    /// 地图marker选中回调
    myMapController.setMaptDidSelectMarkerCallback(
        callback: (BMFMarker marker) {
      print('mapDidSelectMarker--\n');

      setState(() {
        _markerID = marker.id;
        _action = "选中";
      });
    });

    /// 地图marker取消选中回调
    myMapController.setMapDidDeselectMarkerCallback(
        callback: (BMFMarker marker) {
      print('mapDidDeselectMarker');

      setState(() {
        _markerID = marker.id;
        _action = "取消选中";
      });
    });

    /// 地图marker点击回调
    myMapController.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
      print('mapClickedMarker--\n marker = ${marker.toMap()}');
      setState(() {
        _markerID = marker.id;
        _action = "点击";
      });
    });

    /// 拖拽marker点击回调
    myMapController.setMapDragMarkerCallback(callback: (BMFMarker marker,
        BMFMarkerDragState newState, BMFMarkerDragState oldState) {
      // String state = extra['state'];
      // dynamic centerMap = extra['center'];
      // print('drag mapClickedMarker--\n marker = $id');
      // setState(() {
      //   _markerID = id;
      //   _action = "拖拽";
      //   _state = state;
      //   _coordinates = BMFCoordinate.coordinate().fromMap(centerMap);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
          appBar: generateAppBar(),
          body: Stack(children: <Widget>[
            generateMap(),
            generateControlBar(),
          ])),
    );
  }

  /// 添加大头针
  void addMarker() {
    BMFMarker marker = BMFMarker.icon(
        position: BMFCoordinate(39.928617, 116.40329),
        title: 'flutterMaker',
        subtitle: 'test',
        identifier: 'flutter_marker',
        icon: 'resoures/icon_end.png');
    // bool result;
    myMapController.addMarker(marker);
    _marker = marker;
  }

  BMFAppBar generateAppBar() {
    return BMFAppBar(
        title: 'marker示例',
        onBack: () {
          cancelTimer();
          Navigator.pop(context);
        });
  }

  Container generateMarkerInfo() {
    Text text;
    if (null == _markerID || _markerID!.isEmpty) {
      text = Text('');
    } else if (_action != "拖拽") {
      text = Text('当前marker id:$_markerID, 操作类型: $_action');
    } else if (_state != DragState.sDragging && null != _coordinates) {
      double? latitude = _coordinates?.latitude;
      double? longtitude = _coordinates?.longitude;
      text = Text(
          '当前marker id:$_markerID, 操作类型:$_action 状态:$_state x:$latitude y:$longtitude');
    } else {
      text = Text('当前marker id:$_markerID, 操作类型:$_action 状态:$_state');
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 400,
      height: 40,
      child: text,
    );
  }

  /// 创建地图
  @override
  Container generateMap() {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: initMapOptions(),
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 60,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              style: ButtonStyle(backgroundColor: defaultBtnBgColor),
              child: Text(
                _btnText,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                onBtnPress();
              }),
        ],
      ),
    );
  }

  void onBtnPress() {
    if (_addState) {
      addMarkers();
    } else {
      removeMarkers();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  /// 创建更新属性栏
  Row generateUpdateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(child: Text('更新位置'), onPressed: () {}),
        Switch(
            value: _show,
            activeColor: Colors.green,
            onChanged: (bool value) {
              setState(() {
                _show = value;
              });
            }),
        Text('锁定屏幕位置'),
      ],
    );
  }

  /// 删除大头针
  void removeMarker() {
    myMapController.removeMarker(_marker);
  }

  /// 批量添加大头针
  Future<void> addMarkers() async {
    if (_markers == null || _markers!.isEmpty) {
      BMFLog.d('dragable:$dragable', tag: '_DrawMarkerPageState');

      ByteData bytes = await rootBundle.load('resoures/icon_ugc_start.png');
      Uint8List iconData = bytes.buffer.asUint8List();

      _marker0 = BMFMarker.iconData(
          position: BMFCoordinate(39.928617, 116.40329),
          title: '第一个',
          subtitle: 'test',
          identifier: 'flutter_marker',
          iconData: iconData,
          enabled: enable,
          draggable: dragable);

      _marker1 = BMFMarker.icon(
          position: _startPos,
          title: '第二个',
          subtitle: 'test',
          identifier: 'flutter_marker',
          icon: 'resoures/icon_binding_point.png',
          enabled: enable,
          draggable: dragable);

      _markers = [];
      _markers?.add(_marker0);
      _markers?.add(_marker1);
      myMapController.addMarkers(_markers!);

      _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (startState) {
          _marker0.updateIcon("resoures/icon_ugc_start.png");
          _marker1.updatePosition(_startPos);
          startState = !startState;
        } else {
          _marker0.updateIcon("resoures/icon_ugc_end.png");
          _marker1.updatePosition(_endPos);
          startState = !startState;
        }
      });
    }
  }

  /// 批量删除大头针
  void removeMarkers() {
    _timer?.cancel();
    _timer = null;
    myMapController.removeMarkers(_markers!);
    _markers?.clear();
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
