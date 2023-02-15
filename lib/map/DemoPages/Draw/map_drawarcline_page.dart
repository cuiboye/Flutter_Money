import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/map_raised_button.dart';
import 'package:flutter_money/map/constants.dart';

/// arcline弧线绘制示例
class DrawArclinePage extends StatefulWidget {
  DrawArclinePage({Key? key}) : super(key: key);

  @override
  _DrawArclinePageState createState() => _DrawArclinePageState();
}

class _DrawArclinePageState extends BMFBaseMapState<DrawArclinePage> {
  BMFArcLine? _arcline0;
  BMFArcLine? _arcline1;
  BMFArcLine? _arcline2;

  List<BMFCoordinate> _coordinates1 = [];
  List<BMFCoordinate> _coordinates2 = [];

  bool _deleteBtnSelected = false;
  bool _updateCoordinatesBtnSelected = false;
  int _dashTypeIdx = 0;
  double _widthSliderValue = 0.5;
  double _colorSliderValue = 0.5;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    addArcline();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'arcline示例',
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
      padding: EdgeInsets.only(left: 10, bottom: 5),
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
              BMFRaisedVisibleButton(
                title: "虚线",
                onPressed: _onPressedDash,
                visible: Platform.isIOS,
              ),
              BMFElevatedButton(
                title: "坐标",
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
                  child: Text("Color", style: TextStyle(color: Colors.white)),
                ),
                Flexible(
                  child: Slider(
                    value: _colorSliderValue,
                    onChanged: _onChangedStrokeColorSlider,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 删除 / 添加
  void _onPressedDelete() {
    if (_deleteBtnSelected) {
      addArcline();
    } else {
      removeArcline();
    }

    setState(() {
      _deleteBtnSelected = !_deleteBtnSelected;
    });
  }

  /// 虚线
  void _onPressedDash() {
    _dashTypeIdx += 1;

    _arcline2?.updateLineDashType(BMFLineDashType.values[_dashTypeIdx % 3]);
  }

  /// 更新坐标
  void _onPressedUpdateCenter() {
    List<BMFCoordinate> coordinates3 = [];
    coordinates3.add(BMFCoordinate(39.945, 116.224));
    coordinates3.add(BMFCoordinate(39.905, 116.404));
    coordinates3.add(BMFCoordinate(39.945, 116.584));

    _updateCoordinatesBtnSelected = !_updateCoordinatesBtnSelected;
    _arcline2?.updateCoordinates(
        _updateCoordinatesBtnSelected ? coordinates3 : _coordinates2);
  }

  /// 更新 width
  void _onChangedWidthSlider(value) {
    setState(() {
      _widthSliderValue = value;
    });
    _arcline2?.updateWidth((value * 20).toInt());
  }

  /// 更新 Color
  void _onChangedStrokeColorSlider(value) {
    setState(() {
      _colorSliderValue = value;
    });
    _arcline2?.updateColor(Colors.red.withAlpha((255 * value).toInt()));
  }

  void addArcline() {
    // addArline0();
    addArclineWithDashLine();
    addArcline2();
  }

  void addArline0() {
    List<BMFCoordinate> coordinates0 = [];
    coordinates0.add(BMFCoordinate(40.065, 116.224));
    coordinates0.add(BMFCoordinate(40.125, 116.404));
    coordinates0.add(BMFCoordinate(40.065, 116.504));
    _arcline0 = BMFArcLine(
        coordinates: coordinates0,
        lineDashType: BMFLineDashType.LineDashTypeNone,
        width: 10,
        color: Colors.blue);
    myMapController.addArcline(_arcline0!);
  }

  void addArclineWithDashLine() {
    if (Platform.isIOS) {
      List<BMFCoordinate> coordinates1 = [];
      coordinates1.add(BMFCoordinate(40.065, 116.224));
      coordinates1.add(BMFCoordinate(40.125, 116.404));
      coordinates1.add(BMFCoordinate(40.065, 116.504));
      BMFArcLine arcline = BMFArcLine(
          coordinates: coordinates1,
          lineDashType: BMFLineDashType.LineDashTypeDot,
          width: 4,
          color: Colors.green);
      myMapController.addArcline(arcline);
      _coordinates1.addAll(coordinates1);
      _arcline1 = arcline;
    }
  }

  void addArcline2() {
    List<BMFCoordinate> coordinates2 = [];
    coordinates2.add(BMFCoordinate(39.975, 116.224));
    coordinates2.add(BMFCoordinate(39.935, 116.404));
    coordinates2.add(BMFCoordinate(39.975, 116.584));
    BMFArcLine arcLine = BMFArcLine(
        coordinates: coordinates2,
        lineDashType: BMFLineDashType.LineDashTypeNone,
        width: 10,
        color: Colors.red);
    myMapController.addArcline(arcLine);
    _coordinates2.addAll(coordinates2);
    _arcline2 = arcLine;
  }

  void removeArcline() {
    if (_arcline0 != null) {
      myMapController.removeOverlay(_arcline0!.id);
    }

    if (_arcline1 != null) {
      myMapController.removeOverlay(_arcline1!.id);
    }

    if (_arcline2 != null) {
      myMapController.removeOverlay(_arcline2!.id);
    }

    _coordinates1.clear();
    _coordinates2.clear();
  }
}
