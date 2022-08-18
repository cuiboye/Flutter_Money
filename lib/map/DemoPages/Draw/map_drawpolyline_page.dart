import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_money/map/CustomWidgets/map_raised_button.dart';
import 'package:flutter_money/map/general/alert_dialog_utils.dart';
import 'package:flutter_money/map/constants.dart';

/// polyline折线绘制示例
class DrawPolylinePage extends StatefulWidget {
  DrawPolylinePage({Key? key}) : super(key: key);

  @override
  _DrawPolylinePageState createState() => _DrawPolylinePageState();
}

class _DrawPolylinePageState extends BMFBaseMapState<DrawPolylinePage> {
  late BMFPolyline _texturesPolyline;
  late BMFPolyline _colorsPolyline;
  List<BMFPolyline> _polylines = [];

  bool _deleteBtnSelected = false;
  int _dashTypeIdx = 1;
  int _capTypeIdx = 0;
  int _joinTypeIdx = 0;
  double _sliderValue = 0.5;
  bool _state = false;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    addPolyline();

    /// 地图点击覆盖物回调，目前只支持polyline
    /// polyline 只返回了id
    myMapController.setMapOnClickedOverlayCallback(
        callback: (BMFPolyline polyline) {
      print('地图点击覆盖物回调，只支持polyline=${polyline.toMap()}');
      showToast(context, "polyline点击");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
            title: 'polyline示例',
            onBack: () {
              Navigator.pop(context);
            }),
        body: Stack(
          children: <Widget>[
            generateMap(),
            generateControlBar(),
          ],
        ),
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      color: Color(int.parse(Constants.controlBarColor)),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                title: "更改虚线类型",
                onPressed: _onPressedDash,
              ),
              BMFElevatedButton(
                title: "更新纹理",
                onPressed: _onUpdateTexture,
              ),
              BMFElevatedButton(
                title: "clickable",
                onPressed: _onPressedClick,
              ),
              BMFElevatedButton(
                title: "JoinType",
                onPressed: _onPressedJoin,
              ),
              BMFElevatedButton(
                title: "CapType",
                onPressed: _onPressedCap,
              ),
              BMFElevatedButton(
                title: "更新坐标",
                onPressed: _onPressedUpdateCoordinates,
              ),
            ],
          ),
          Container(
            height: 30,
            child: Row(
              children: [
                Text(
                  "width",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    onChanged: _slideOnChanged,
                  ),
                ),
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
      addPolyline();
    } else {
      clearPolyline();
    }

    setState(() {
      _deleteBtnSelected = !_deleteBtnSelected;
    });
  }

  /// 虚线
  void _onPressedDash() {
    _dashTypeIdx += 1;
    if (Platform.isAndroid) {
      if (0 == _dashTypeIdx % 3) {
        _colorsPolyline.updateDottedLine(false);
      } else {
        _colorsPolyline.updateDottedLine(true);
      }
    }
    _colorsPolyline
        .updateLineDashType(BMFLineDashType.values[_dashTypeIdx % 3]);
  }

  /// 纹理
  void _onUpdateTexture() {
    List<int> indexs = [3, 2, 1, 0];
    _texturesPolyline.updateIndexs(indexs);
  }

  /// 点击
  void _onPressedClick() {
    if (Platform.isIOS) {
      showToast(context, "Android独有属性，iOS polyline默认可点击，目前不支持通过该属性设置可点击状态");
      return;
    }
    _polylines.forEach((element) {
      element.updateClickable(!(_colorsPolyline.clickable ?? true));
    });
    showToast(context,
        "Polyline.clickable更改为${!(_colorsPolyline.clickable ?? true)}");
  }

  /// cap
  void _onPressedCap() {
    _capTypeIdx += 1;
    _polylines.forEach((element) {
      element.updateLineCapType(BMFLineCapType.values[_capTypeIdx % 2]);
    });

    if (_dashTypeIdx % 3 != 0) {
      showToast(context, "lineCapType不支持虚线");
    }
  }

  /// 拐角
  void _onPressedJoin() {
    _joinTypeIdx += 1;
    _polylines.forEach((element) {
      element.updateLineJoinType(BMFLineJoinType.values[_joinTypeIdx % 4]);
    });

    if (_dashTypeIdx % 3 != 0) {
      showToast(context, "lineJoinType不支持虚线");
    }
  }

  /// 更新经纬度坐标
  void _onPressedUpdateCoordinates() {
    if (!_state) {
      _state = true;
      List<BMFCoordinate> coordinates = [];
      coordinates.add(BMFCoordinate(39.845, 116.304));
      coordinates.add(BMFCoordinate(39.805, 116.354));
      coordinates.add(BMFCoordinate(39.835, 116.394));
      coordinates.add(BMFCoordinate(39.785, 116.454));
      coordinates.add(BMFCoordinate(39.845, 116.504));

      if (Platform.isIOS) {
        List<int> indexs = [2, 3, 2, 3];
        _colorsPolyline.updateCoordinates(coordinates, indexs: indexs);
      } else {
        _colorsPolyline.updateCoordinates(coordinates);
      }
    }
  }

  /// 更新 polyline width
  void _slideOnChanged(value) {
    setState(() {
      _sliderValue = value;
    });

    /// 先更新width 再设置虚线有问题
    _polylines.forEach((element) {
      element.updateWidth((value * 30).toInt());
    });
  }

  /// 添加polyline
  void addPolyline() {
    addTexturesPolyline();
    addColorsPolyline();
  }

  /// 添加纹理渲染polyline
  void addTexturesPolyline() {
    List<BMFCoordinate> coordinates = [];
    coordinates.add(BMFCoordinate(39.965, 116.304));
    coordinates.add(BMFCoordinate(39.925, 116.354));
    coordinates.add(BMFCoordinate(39.955, 116.394));
    coordinates.add(BMFCoordinate(39.905, 116.454));
    coordinates.add(BMFCoordinate(39.965, 116.504));

    List<int> indexs = [0, 1, 2, 3];

    List<String> textures = [];
    textures.add('resoures/traffic_texture_smooth.png');
    textures.add('resoures/traffic_texture_slow.png');
    textures.add('resoures/traffic_texture_unknown.png');
    textures.add('resoures/traffic_texture_smooth.png');

    _texturesPolyline = BMFPolyline(
      coordinates: coordinates,
      indexs: indexs,
      textures: textures,
      width: 16,
      lineCapType: BMFLineCapType.LineCapButt,
      lineJoinType: BMFLineJoinType.LineJoinRound,
    );
    myMapController.addPolyline(_texturesPolyline);
    _polylines.add(_texturesPolyline);
  }

  /// 添加颜色渲染polyline
  void addColorsPolyline() {
    List<BMFCoordinate> coordinates = [];
    coordinates.add(BMFCoordinate(39.865, 116.304));
    coordinates.add(BMFCoordinate(39.825, 116.354));
    coordinates.add(BMFCoordinate(39.855, 116.394));
    coordinates.add(BMFCoordinate(39.805, 116.454));
    coordinates.add(BMFCoordinate(39.865, 116.504));

    List<int> indexs = [2, 3, 2, 3];

    List<Color> colors = [];
    colors.add(Colors.blue);
    colors.add(Colors.orange);
    colors.add(Colors.red);
    colors.add(Colors.green);

    _colorsPolyline = BMFPolyline(
        coordinates: coordinates,
        indexs: indexs,
        colors: colors,
        width: 16,
        lineDashType: BMFLineDashType.LineDashTypeSquare,
        lineCapType: BMFLineCapType.LineCapButt,
        lineJoinType: BMFLineJoinType.LineJoinRound);
    myMapController.addPolyline(_colorsPolyline);
    _polylines.add(_colorsPolyline);
  }

  /// 删除polyline
  void clearPolyline() {
    _polylines.forEach((element) {
      myMapController.removeOverlay(element.id);
    });
    _polylines.clear();
  }
}
