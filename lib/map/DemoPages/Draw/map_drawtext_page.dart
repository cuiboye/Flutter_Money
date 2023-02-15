import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/constants.dart';

/// text文本绘制示例
///
/// Android独有
class DrawTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawTextPageState();
  }
}

class _DrawTextPageState extends BMFBaseMapState<DrawTextPage> {
  late BMFText _bmfText0;
  late BMFText _bmfText1;

  bool _addState = false;
  String _btnText = "删除";
  double _rotateValue = 0;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addText();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        home: Scaffold(
      appBar: BMFAppBar(
        title: 'text示例',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(children: <Widget>[generateMap(), generateControlBar()]),
    ));
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
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    _btnText,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onBtnPress();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    "位置",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressedUpdateCenter();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    "更新文本",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressedUpdateText();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    "背景颜色",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressUpdateBgColor();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    "字体颜色",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressUpdateTextColor();
                  }),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: defaultBtnBgColor),
                  child: Text(
                    "字体大小",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _onPressUpdateTextSize();
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
                    "Rotate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Slider(
                    value: _rotateValue,
                    onChanged: _onChangedRotate,
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
      addText();
      BMFMapOptions mapOptions =
          BMFMapOptions(zoomLevel: 12, center: BMFCoordinate(39.915, 116.404));
      myMapController.updateMapOptions(mapOptions);
    } else {
      removeText();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  void addText() {
    addText0();
    addText1();
  }

  void addText0() {
    BMFCoordinate position = new BMFCoordinate(39.83235, 116.350338);

    _bmfText0 = BMFText(
        text: 'hello world',
        position: position,
        bgColor: Colors.blue,
        fontColor: Colors.red,
        fontSize: 50,
        typeFace: BMFTypeFace(
            familyName: BMFFamilyName.sMonospace,
            textStype: BMFTextStyle.BOLD_ITALIC),
        alignY: BMFVerticalAlign.ALIGN_BOTTOM,
        alignX: BMFHorizontalAlign.ALIGN_LEFT);

    myMapController.addText(_bmfText0);
  }

  void addText1() {
    BMFCoordinate position = new BMFCoordinate(39.73235, 116.350338);

    _bmfText1 = BMFText(
        text: '欢迎使用百度地图SDK',
        position: position,
        bgColor: Colors.red,
        fontColor: Colors.white,
        fontSize: 50,
        typeFace: BMFTypeFace(
            familyName: BMFFamilyName.sSansSerif,
            textStype: BMFTextStyle.NORMAL),
        alignY: BMFVerticalAlign.ALIGN_CENTER_VERTICAL,
        alignX: BMFHorizontalAlign.ALIGN_CENTER_HORIZONTAL,
        rotate: 0.0);

    myMapController.addText(_bmfText1);
  }

  void removeText() {
    myMapController.removeOverlay(_bmfText0.id);
    myMapController.removeOverlay(_bmfText1.id);
  }

  /// 更新字体大小
  void _onPressUpdateTextSize() {
    _bmfText0.updateFontSize(30);
    _bmfText1.updateFontSize(40);
  }

  /// 更新字体颜色
  void _onPressUpdateTextColor() {
    _bmfText0.updateFontColor(Colors.brown);
    _bmfText1.updateFontColor(Colors.lightGreen);
  }

  /// 更新背景颜色
  void _onPressUpdateBgColor() {
    _bmfText0.updateBgColor(Colors.pink);
    _bmfText1.updateBgColor(Colors.blue);
  }

  /// 更新文本
  void _onPressedUpdateText() {
    _bmfText0.updateText("HELLO WORLD");
    _bmfText1.updateText("欢迎使用text示例");
  }

  /// 更新位置
  void _onPressedUpdateCenter() {
    double r = Random().nextDouble();

    BMFCoordinate center0 = BMFCoordinate(39.83235 + r, 116.350338 + r);
    _bmfText0.updatePosition(center0);
    BMFCoordinate center1 = BMFCoordinate(39.73235 + r, 116.350338 + r);
    _bmfText1.updatePosition(center1);

    BMFMapOptions mapOptions = BMFMapOptions(zoomLevel: 12, center: center1);
    myMapController.updateMapOptions(mapOptions);
  }

  /// 更新 rotate
  void _onChangedRotate(value) {
    setState(() {
      _rotateValue = value;
    });

    _bmfText0.updateRotate(360.0 * value);
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
