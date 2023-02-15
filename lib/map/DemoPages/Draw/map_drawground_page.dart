import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/map_raised_button.dart';

import '../../constants.dart';

/// ground图片图层绘制示例
///
/// Android独有
class DrawGroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawGroundPageState();
  }
}

class _DrawGroundPageState extends BMFBaseMapState<DrawGroundPage> {
  late BMFGround _bmfGround0;
  late BMFGround _bmfGround1;

  bool _addState = false;
  String _btnText = "删除";
  double _transparencyValue = 0.8;

  /// 点击更改bounds区域
  double r = 0;

  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addGround();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        home: Scaffold(
            appBar: BMFAppBar(
              title: 'ground示例',
              onBack: () {
                Navigator.pop(context);
              },
            ),
            body: Stack(
                children: <Widget>[generateMap(), generateControlBar()])));
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      color: Color(int.parse(Constants.controlBarColor)),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.start,
            children: [
              BMFElevatedButton(
                title: _btnText,
                onPressed: onBtnPress,
              ),
              BMFRaisedVisibleButton(
                title: "位置",
                onPressed: _onPressUpdateLocation,
                visible: Platform.isAndroid,
              ),
              BMFRaisedVisibleButton(
                visible: Platform.isAndroid,
                title: "图片",
                onPressed: _onPressUpdateImage,
              ),
              BMFRaisedVisibleButton(
                visible: Platform.isAndroid,
                title: "地理区域",
                onPressed: _onPressUpdateBounds,
              ),
            ],
          ),
          Visibility(
            visible: Platform.isAndroid,
            child: Container(
              height: 25,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Text(
                      "透明度",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Flexible(
                    child: Slider(
                      value: _transparencyValue,
                      onChanged: _onChangedTransparency,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onBtnPress() {
    if (_addState) {
      addGround();
      BMFMapOptions mapOptions =
          BMFMapOptions(zoomLevel: 12, center: BMFCoordinate(39.915, 116.404));
      myMapController.updateMapOptions(mapOptions);
    } else {
      removeGround();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  void addGround() {
    addGround0();
    addGround1();
  }

  /// 添加ground0
  void addGround0() {
    BMFCoordinate southwest = BMFCoordinate(40.00235, 116.330338);
    BMFCoordinate northeast = BMFCoordinate(40.147246, 116.464977);
    BMFCoordinateBounds bounds =
        BMFCoordinateBounds(southwest: southwest, northeast: northeast);

    _bmfGround0 = BMFGround(
        image: 'resoures/groundIcon.png',
        bounds: bounds,
        transparency: 0.8,
        width: 200,
        height: 200);
    myMapController.addGround(_bmfGround0);
  }

  /// 添加ground1
  void addGround1() {
    BMFCoordinate southwest = BMFCoordinate(39.82235, 116.330338);
    BMFCoordinate northeast = BMFCoordinate(39.847246, 116.464977);
    BMFCoordinateBounds bounds =
        BMFCoordinateBounds(southwest: southwest, northeast: northeast);

    _bmfGround1 = BMFGround(
        image: 'resoures/groundIcon.png', bounds: bounds, transparency: 0.8);

    myMapController.addGround(_bmfGround1);
  }

  /// 删除ground
  void removeGround() {
    myMapController.removeOverlay(_bmfGround0.id);
    myMapController.removeOverlay(_bmfGround1.id);
  }

  /// 更新位置
  void _onPressUpdateLocation() {
    double r = Random().nextDouble();

    BMFCoordinate center0 = BMFCoordinate(40.00235 + r, 116.330338 + r);
    _bmfGround0.updatePosition(center0);
    BMFCoordinate center1 = BMFCoordinate(39.82235 + r, 116.330338 + r);
    _bmfGround1.updatePosition(center1);

    BMFMapOptions mapOptions = BMFMapOptions(zoomLevel: 12, center: center1);
    myMapController.updateMapOptions(mapOptions);
  }

  /// 更新图片
  void _onPressUpdateImage() {
    _bmfGround0.updateImage('resoures/glass.png');
    _bmfGround1.updateImage('resoures/glass.png');
  }

  /// 更新透明度
  void _onChangedTransparency(value) {
    setState(() {
      _transparencyValue = value;
    });

    _bmfGround0.updateTransparency(value);
    _bmfGround1.updateTransparency(value);
  }

  /// 更新地理区域
  void _onPressUpdateBounds() {
    r += 0.02;

    BMFCoordinate southwest0 = BMFCoordinate(40.00235 + r, 116.330338 + r);
    BMFCoordinate northeast0 = BMFCoordinate(40.147246 + r, 116.464977 + r);
    BMFCoordinateBounds bounds0 =
        BMFCoordinateBounds(southwest: southwest0, northeast: northeast0);
    _bmfGround0.updateBounds(bounds0);

    BMFCoordinate southwest1 = BMFCoordinate(39.82235 + r, 116.330338 + r);
    BMFCoordinate northeast1 = BMFCoordinate(39.847246 + r, 116.464977 + r);
    BMFCoordinateBounds bounds1 =
        BMFCoordinateBounds(southwest: southwest1, northeast: northeast1);
    _bmfGround1.updateBounds(bounds1);

    BMFMapOptions mapOptions = BMFMapOptions(
        zoomLevel: 12, center: BMFCoordinate(40.00235 + r, 116.330338 + r));
    myMapController.updateMapOptions(mapOptions);
  }
}

/// 设置地图参数
BMFMapOptions initMapOptions() {
  BMFMapOptions mapOptions = BMFMapOptions(
      mapType: BMFMapType.Standard,
      zoomLevel: 13,
      center: BMFCoordinate(39.915, 116.404));
  return mapOptions;
}
