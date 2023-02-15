import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/map_raised_button.dart';
import 'package:flutter_money/map/constants.dart';

/// circle圆形绘制示例
class DrawCirclePage extends StatefulWidget {
  DrawCirclePage({Key? key}) : super(key: key);

  @override
  _DrawCirclePageState createState() => _DrawCirclePageState();
}

class _DrawCirclePageState extends BMFBaseMapState<DrawCirclePage> {
  BMFCircle? _circle0;
  BMFCircle? _circle1;
  BMFCircle? _circle2;

  bool _addState = false;
  bool _deleteBtnSelected = false;
  int _dashTypeIdx = 0;
  double _radiusSliderValue = 0.5;
  double _widthSliderValue = 0.25;
  double _strokeColorSliderValue = 0.5;
  double _fillColorSliderValue = 0.5;
  double r = 0;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);
    if (!_addState) {
      addCircle();
      _addState = true;
    }

    controller.updateMapOptions(_mapOptions);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'circle示例',
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
                title: _deleteBtnSelected ? "添加" : "删除",
                onPressed: _onPressedDelete,
              ),
              BMFElevatedButton(
                title: "虚线",
                onPressed: _onPressedDash,
              ),
              BMFElevatedButton(
                title: "圆镂空",
                onPressed: _onPressedCircleHollow,
              ),
              BMFElevatedButton(
                title: "方镂空",
                onPressed: _onPressedPolygonHollow,
              ),
              BMFElevatedButton(
                title: "位置",
                onPressed: _onPressedUpdateCenter,
              ),
            ],
          ),
          Container(
            height: 25,
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text(
                    "Radius",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Slider(
                    value: _radiusSliderValue,
                    onChanged: _onChangedRadiusSlider,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 25,
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text("Width", style: TextStyle(color: Colors.white)),
                ),
                Flexible(
                  child: Slider(
                    value: _widthSliderValue,
                    onChanged: _onChangedWidthSlider,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 25,
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text(
                    "StrokeColor",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Slider(
                    value: _strokeColorSliderValue,
                    onChanged: _onChangedStrokeColorSlider,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 25,
            child: Row(
              children: [
                Container(
                  width: 80,
                  child:
                      Text("FillColor", style: TextStyle(color: Colors.white)),
                ),
                Flexible(
                  child: Slider(
                    value: _fillColorSliderValue,
                    onChanged: _onChangedFillColorSlider,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 删除 / 添加
  void _onPressedDelete() {
    if (_deleteBtnSelected) {
      addCircle();
    } else {
      removeCircle();
    }

    setState(() {
      _deleteBtnSelected = !_deleteBtnSelected;
    });
  }

  /// 虚线
  void _onPressedDash() {
    _dashTypeIdx += 1;

    if (Platform.isAndroid) _circle0?.updateDottedLine(true);
    _circle0?.updateLineDashType(BMFLineDashType.values[_dashTypeIdx % 3]);
  }

  /// 圆形镂空
  void _onPressedCircleHollow() {
    List<BMFHollowShape> hollowShapes = [];
    BMFHollowShape circleHollowShape =
        BMFHollowShape.circle(center: _circle0?.center, radius: 100);
    hollowShapes.add(circleHollowShape);
    _circle0?.updateHollowShapes(hollowShapes);
  }

  /// 多边形镂空
  void _onPressedPolygonHollow() {
    List<BMFHollowShape> hollowShapes = [];
    List<BMFCoordinate> coordinates = List.filled(4, BMFCoordinate(0, 0));

    coordinates[0] = BMFCoordinate(40.055056 + r, 116.309102 + r);
    coordinates[1] = BMFCoordinate(40.055056 + r, 116.307102 + r);
    coordinates[2] = BMFCoordinate(40.057056 + r, 116.307102 + r);
    coordinates[3] = BMFCoordinate(40.057056 + r, 116.309102 + r);

    BMFHollowShape polygonHollowShape =
        BMFHollowShape.polygon(coordinates: coordinates);
    hollowShapes.add(polygonHollowShape);

    _circle0?.updateHollowShapes(hollowShapes);
  }

  /// 更新位置
  void _onPressedUpdateCenter() {
    r = Random().nextDouble();

    BMFCoordinate center = BMFCoordinate(40.056056 + r, 116.308102 + r);
    _circle0?.updateCenter(center);

    BMFMapOptions mapOptions = BMFMapOptions(zoomLevel: 15, center: center);
    myMapController.updateMapOptions(mapOptions);
  }

  /// 更新半径
  void _onChangedRadiusSlider(value) {
    setState(() {
      _radiusSliderValue = value;
    });
    if (Platform.isIOS) {
      _circle0?.updateHollowShapes([]); // 更新半径先去掉镂空，镂空面积比circle大时会有问题
    }
    _circle0?.updateRadius(500.0 * value);
  }

  /// 更新 width
  void _onChangedWidthSlider(value) {
    setState(() {
      _widthSliderValue = value;
    });
    _circle0?.updateWidth((value * 20).toInt());
  }

  /// 更新 StrokeColor
  void _onChangedStrokeColorSlider(value) {
    setState(() {
      _strokeColorSliderValue = value;
    });
    _circle0?.updateStrokeColor(Colors.green.withAlpha((255 * value).toInt()));
  }

  /// 更新 FillColor
  void _onChangedFillColorSlider(value) {
    setState(() {
      _fillColorSliderValue = value;
    });

    _circle0?.updateFillColor(Colors.amber.withAlpha((255 * value).toInt()));
  }

  void addCircle() {
    addCircle0();
    // addCircle1();
    addCircle2();
  }

  void addCircle0() {
    _circle0 = BMFCircle(
      center: BMFCoordinate(40.056056, 116.308102),
      radius: 500,
      width: 5,
      strokeColor: Colors.green.withAlpha((255 * 0.5).toInt()),
      fillColor: Colors.amber.withAlpha((255 * 0.5).toInt()),
      lineDashType: BMFLineDashType.LineDashTypeNone,
    );

    myMapController.addCircle(_circle0!);
    if (_addState) {
      myMapController.updateMapOptions(BMFMapOptions(
        center: BMFCoordinate(40.056056, 116.318102),
        mapType: BMFMapType.Standard,
        zoomLevel: 15,
      ));
    }
  }

  void addCircle1() {
    _circle1 = BMFCircle(
        center: BMFCoordinate(39.965, 116.404),
        radius: 4000,
        width: 6000,
        strokeColor: Colors.blue,
        fillColor: Colors.deepPurpleAccent,
        lineDashType: BMFLineDashType.LineDashTypeDot);
    myMapController.addCircle(_circle1!);
  }

  void addCircle2() {
    _circle2 = BMFCircle(
      center: BMFCoordinate(40.056056, 116.328102),
      radius: 400,
      width: 5,
      strokeColor: Colors.blue,
      fillColor: Colors.brown,
      lineDashType: BMFLineDashType.LineDashTypeNone,
    );

    myMapController.addCircle(_circle2!);
  }

  void removeCircle() {
    r = 0;
    if (_circle0 != null) myMapController.removeOverlay(_circle0!.id);
    if (_circle1 != null) myMapController.removeOverlay(_circle1!.id);
    if (_circle2 != null) myMapController.removeOverlay(_circle2!.id);
  }
}

/// 设置地图参数
BMFMapOptions _mapOptions = BMFMapOptions(
  mapType: BMFMapType.Standard,
  zoomLevel: 15,
  center: BMFCoordinate(40.056056, 116.318102),
);
