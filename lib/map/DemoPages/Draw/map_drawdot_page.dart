import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';

/// dot圆点绘制示例
///
/// Android独有
class DrawDotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawDotPageState();
  }
}

class _DrawDotPageState extends BMFBaseMapState<DrawDotPage> {
  late BMFDot _bmfDot0;

  late BMFDot _bmfDot1;

  late BMFDot _bmfDot2;

  bool _addState = false;
  String _btnText = "删除";
  String _btnText2 = "位置";

  double _radiusSliderValue = 1;
  double _colorSliderValue = 1;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);
    if (!_addState) {
      addDot();
    }

    // controller.updateMapOptions(initMapOptions());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        home: Scaffold(
            appBar: BMFAppBar(
              title: 'dot示例',
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.start,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: defaultBtnBgColor,
                  ),
                  child: Text(
                    _btnText,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onBtnPress();
                  }),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: defaultBtnBgColor,
                  ),
                  child: Text(
                    _btnText2,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressedUpdateCenter();
                  }),
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
                  child: Text(
                    "Color",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Slider(
                    value: _colorSliderValue,
                    onChanged: _onChangedColorSlider,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onBtnPress() {
    if (_addState) {
      addDot();
      BMFMapOptions mapOptions =
          BMFMapOptions(zoomLevel: 12, center: BMFCoordinate(39.915, 116.404));
      myMapController.updateMapOptions(mapOptions);
    } else {
      removeDot();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  /// 更新位置
  void _onPressedUpdateCenter() {
    double r = Random().nextDouble();

    BMFCoordinate center0 = BMFCoordinate(39.835 + r, 116.304 + r);
    _bmfDot0.updateCenter(center0);
    BMFCoordinate center1 = BMFCoordinate(39.835 + r, 116.404 + r);
    _bmfDot1.updateCenter(center1);
    BMFCoordinate center2 = BMFCoordinate(39.835 + r, 116.504 + r);
    _bmfDot2.updateCenter(center2);

    BMFMapOptions mapOptions = BMFMapOptions(zoomLevel: 12, center: center1);
    myMapController.updateMapOptions(mapOptions);
  }

  /// 更新 FillColor
  void _onChangedColorSlider(value) {
    setState(() {
      _colorSliderValue = value;
    });

    _bmfDot0.updateColor(Colors.green.withAlpha((255 * value).toInt()));
    _bmfDot1.updateColor(Colors.black.withAlpha((255 * value).toInt()));
    _bmfDot2.updateColor(Colors.red.withAlpha((255 * value).toInt()));
  }

  /// 更新半径
  void _onChangedRadiusSlider(value) {
    setState(() {
      _radiusSliderValue = value;
    });
    _bmfDot0.updateRadius(50.0 * value);
    _bmfDot1.updateRadius(30.0 * value);
    _bmfDot2.updateRadius(40.0 * value);
  }

  void addDot() {
    addDot0();
    addDot1();
    addDot2();
  }

  void addDot0() {
    _bmfDot0 = BMFDot(
        center: BMFCoordinate(39.835, 116.304),
        radius: 50,
        color: Colors.green);

    myMapController.addDot(_bmfDot0);
  }

  void addDot1() {
    _bmfDot1 = BMFDot(
        center: BMFCoordinate(39.835, 116.404),
        radius: 30,
        color: Colors.black);

    myMapController.addDot(_bmfDot1);
  }

  void addDot2() {
    _bmfDot2 = BMFDot(
        center: BMFCoordinate(39.835, 116.504), radius: 40, color: Colors.red);

    myMapController.addDot(_bmfDot2);
  }

  void removeDot() {
    myMapController.removeOverlay(_bmfDot0.id);
    myMapController.removeOverlay(_bmfDot1.id);
    myMapController.removeOverlay(_bmfDot2.id);
  }
}

/// 设置地图参数
BMFMapOptions initMapOptions() {
  BMFMapOptions mapOptions = BMFMapOptions(
      mapType: BMFMapType.Standard,
      zoomLevel: 12,
      center: BMFCoordinate(39.915, 116.404));
  return mapOptions;
}
