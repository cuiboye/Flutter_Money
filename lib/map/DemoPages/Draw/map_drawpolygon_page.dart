import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/map_raised_button.dart';
import 'package:flutter_money/map/constants.dart';

/// polygon多边形绘制示例
class DrawPolygonPage extends StatefulWidget {
  DrawPolygonPage({Key? key}) : super(key: key);

  @override
  _DrawPolygonPageState createState() => _DrawPolygonPageState();
}

class _DrawPolygonPageState extends BMFBaseMapState<DrawPolygonPage> {
  late BMFPolygon _polygon0;
  late BMFPolygon _polygon1;
  late BMFPolygon _polygon2;

  bool _deleteBtnSelected = false;
  int _dashTypeIdx = 0;
  double _widthSliderValue = 0.25;
  double _strokeColorSliderValue = 0.5;
  double _fillColorSliderValue = 0.5;
  BMFCoordinate dashCenter = BMFCoordinate(39.965119, 116.403963);

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 添加 Polygon
    addPolygon();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'polygon示例',
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
                onPressed: _onPressUpdateLocation,
              ),
            ],
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
                  child: Text("StrokeColor",
                      style: TextStyle(color: Colors.white)),
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
      addPolygon();
    } else {
      removePolygon();
    }

    setState(() {
      _deleteBtnSelected = !_deleteBtnSelected;
    });
  }

  /// 虚线
  void _onPressedDash() {
    if (Platform.isAndroid) {
      myMapController.removeOverlay(_polygon0.id);

      /// 五角星坐标
      List<BMFCoordinate> coordinates = getStarCoordinates(dashCenter);
      _polygon0 = BMFPolygon(
          coordinates: coordinates,
          strokeColor: Colors.blueGrey,
          width: 5,
          fillColor: Colors.red,
          lineDashType: BMFLineDashType.LineDashTypeSquare);
      myMapController.addPolygon(_polygon0);
    } else {
      _dashTypeIdx += 1;
      _polygon0.updateLineDashType(BMFLineDashType.values[_dashTypeIdx % 3]);
    }
  }

  /// 圆形镂空
  void _onPressedCircleHollow() {
    List<BMFHollowShape> hollowShapes1 = [];
    List<BMFHollowShape> hollowShapes2 = [];

    /// 多边形1
    BMFCoordinate center1 = BMFCoordinate(39.920, 116.550);
    BMFHollowShape circleHollowShape1 =
        BMFHollowShape.circle(center: center1, radius: 1500);
    hollowShapes1.add(circleHollowShape1);
    _polygon1.updateHollowShapes(hollowShapes1);

    /// 多边形2
    BMFCoordinate center2 = BMFCoordinate(39.715, 116.354);
    BMFHollowShape circleHollowShape2 =
        BMFHollowShape.circle(center: center2, radius: 1500);
    hollowShapes2.add(circleHollowShape2);
    _polygon2.updateHollowShapes(hollowShapes2);
  }

  /// 多边形镂空
  void _onPressedPolygonHollow() {
    /// 多边形1
    List<BMFHollowShape> hollowShapes1 = [];

    List<BMFCoordinate> coordinates1 = List.filled(5, BMFCoordinate(0, 0));
    coordinates1[0] = BMFCoordinate(39.925, 116.525);
    coordinates1[1] = BMFCoordinate(39.885, 116.525);
    coordinates1[2] = BMFCoordinate(39.885, 116.575);
    coordinates1[3] = BMFCoordinate(39.925, 116.575);
    coordinates1[4] = BMFCoordinate(39.945, 116.550);

    BMFHollowShape polygonHollowShape1 =
        BMFHollowShape.polygon(coordinates: coordinates1);
    hollowShapes1.add(polygonHollowShape1);

    _polygon1.updateHollowShapes(hollowShapes1);

    /// 多边形2
    List<BMFHollowShape> hollowShapes2 = [];

    List<BMFCoordinate> coordinates2 = List.filled(6, BMFCoordinate(0, 0));
    coordinates2[0] = BMFCoordinate(39.735, 116.334);
    coordinates2[1] = BMFCoordinate(39.695, 116.334);
    coordinates2[2] = BMFCoordinate(39.695, 116.374);
    coordinates2[3] = BMFCoordinate(39.705, 116.394);
    coordinates2[4] = BMFCoordinate(39.725, 116.394);
    coordinates2[5] = BMFCoordinate(39.735, 116.374);

    BMFHollowShape polygonHollowShape2 =
        BMFHollowShape.polygon(coordinates: coordinates2);
    hollowShapes2.add(polygonHollowShape2);

    _polygon2.updateHollowShapes(hollowShapes2);
  }

  /// 更新 width
  void _onChangedWidthSlider(value) {
    setState(() {
      _widthSliderValue = value;
    });
    _polygon0.updateWidth((value * 20).toInt());
  }

  /// 更新 StrokeColor
  void _onChangedStrokeColorSlider(value) {
    setState(() {
      _strokeColorSliderValue = value;
    });
    _polygon0
        .updateStrokeColor(Colors.blueGrey.withAlpha((255 * value).toInt()));
  }

  /// 更新 FillColor
  void _onChangedFillColorSlider(value) {
    setState(() {
      _fillColorSliderValue = value;
    });

    _polygon0.updateFillColor(Colors.red.withAlpha((255 * value).toInt()));
  }

  /// 添加 Polygon
  void addPolygon() {
    addPolygon0();
    addPolygon1();
    addPolygon2();
  }

  void addPolygon0() {
    /// 中心点天安门
    BMFCoordinate center = BMFCoordinate(39.965119, 116.403963);

    /// 五角星坐标
    List<BMFCoordinate> coordinates = getStarCoordinates(center);

    dashCenter = center;
    _polygon0 = BMFPolygon(
        coordinates: coordinates,
        strokeColor: Colors.blueGrey,
        width: 5,
        fillColor: Colors.red);
    myMapController.addPolygon(_polygon0);
  }

  void addPolygon1() {
    List<BMFCoordinate> coordinates = List.filled(5, BMFCoordinate(0, 0));
    coordinates[0] = BMFCoordinate(39.945, 116.500);
    coordinates[1] = BMFCoordinate(39.865, 116.500);
    coordinates[2] = BMFCoordinate(39.865, 116.600);
    coordinates[3] = BMFCoordinate(39.945, 116.600);
    coordinates[4] = BMFCoordinate(39.975, 116.550);

    _polygon1 = BMFPolygon(
      coordinates: coordinates,
      strokeColor: Colors.brown,
      width: 10,
      fillColor: Colors.indigo,
    );

    myMapController.addPolygon(_polygon1);
  }

  void addPolygon2() {
    List<BMFCoordinate> coordinates = List.filled(6, BMFCoordinate(0, 0));
    coordinates[0] = BMFCoordinate(39.765, 116.304);
    coordinates[1] = BMFCoordinate(39.665, 116.304);
    coordinates[2] = BMFCoordinate(39.665, 116.404);
    coordinates[3] = BMFCoordinate(39.685, 116.424);
    coordinates[4] = BMFCoordinate(39.745, 116.424);
    coordinates[5] = BMFCoordinate(39.765, 116.404);

    _polygon2 = BMFPolygon(
      coordinates: coordinates,
      strokeColor: Colors.orange,
      width: 6,
      fillColor: Colors.lightGreen,
    );

    myMapController.addPolygon(_polygon2);
  }

  void removePolygon() {
    myMapController.removeOverlay(_polygon0.id);
    myMapController.removeOverlay(_polygon1.id);
    myMapController.removeOverlay(_polygon2.id);
  }

  /// 五角星
  List<BMFCoordinate> getStarCoordinates(BMFCoordinate center) {
    List<BMFCoordinate> coordinates = [];

    var pointCount = 10;
    double startAngle = pi / 2;
    double angle = 2.0 * pi / pointCount;

    var longRadius = 0.075;
    var shortRadius = longRadius * sin(angle / 2) / cos(angle);

    for (int i = 0; i < pointCount; i++) {
      double lat, lon;
      if (i % 2 == 0) {
        lat = longRadius * sin(startAngle + angle * i) + center.latitude;
        lon = longRadius * cos(startAngle + angle * i) + center.longitude;
      } else {
        lat = shortRadius * sin(startAngle + angle * i) + center.latitude;
        lon = shortRadius * cos(startAngle + angle * i) + center.longitude;
      }

      coordinates.add(BMFCoordinate(lat, lon));
    }

    return coordinates;
  }

  /// 更新坐标
  void _onPressUpdateLocation() {
    /// 中心点颐和园
    dashCenter = BMFCoordinate(40.004869, 116.278749);

    /// 五角星坐标
    List<BMFCoordinate> coordinates = getStarCoordinates(dashCenter);
    _polygon0.updateCoordinates(coordinates);
  }
}
