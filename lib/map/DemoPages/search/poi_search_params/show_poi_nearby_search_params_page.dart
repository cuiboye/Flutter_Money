import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_search_filter_params_page.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

typedef SearchParamsPageCallBack = void Function(BMFPoiNearbySearchOption);

class ShowPOINearbySearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowPOINearbySearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowPOINearbySearchParamsPageState createState() =>
      _ShowPOINearbySearchParamsPageState();
}

class _ShowPOINearbySearchParamsPageState
    extends State<ShowPOINearbySearchParamsPage> {
  final _keyworkController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  final _tagsController = TextEditingController();
  final _radiusController = TextEditingController();
  final _pageIndexController = TextEditingController();
  final _pageSizeController = TextEditingController();

  int _segmentSelectedIdx = 0;
  bool _isRadiusLimitSwitchOn = false;

  BMFPoiSearchFilter? _searchFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "自定义参数",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            BMFSearchParamsInputBox(
              controller: _keyworkController,
              title: "关键字（必选）：",
              titleWidth: 135,
            ),
            BMFSearchParamsInputBox(
              controller: _latController,
              title: "纬度坐标（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _lonController,
              title: "经度坐标（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _tagsController,
              title: "分类：",
              titleWidth: 135,
            ),
            BMFSearchParamsInputBox(
              controller: _radiusController,
              title: "半径：",
              titleWidth: 135,
            ),
            BMFSearchParamsInputBox(
              controller: _pageIndexController,
              title: "分页：",
              titleWidth: 135,
            ),
            BMFSearchParamsInputBox(
              controller: _pageSizeController,
              title: "数量：",
              titleWidth: 135,
            ),
            CupertinoSegmentedControl(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              groupValue: _segmentSelectedIdx,
              children: {
                0: Text("检索基本信息"),
                1: Text("检索详细信息"),
              },
              selectedColor: Colors.blue,
              onValueChanged: (idx) {
                setState(() {
                  _segmentSelectedIdx = idx as int;
                });
              },
            ),
            _cityLimitSwitch(),
            _filterBtn(),
          ],
        ),
      ),
    );
  }

  /// 区域限制开关
  Widget _cityLimitSwitch() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "是否严格限定召回结果\n在设置检索半径范围内",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isRadiusLimitSwitchOn,
            onChanged: (isOn) {
              setState(() {
                _isRadiusLimitSwitchOn = isOn;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _filterBtn() {
    double width = (MediaQuery.of(context).size.width - 45) / 2;

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BMFSearchBtn(
            height: 34,
            width: width,
            title: "设置过滤参数",
            titleTextStyle: searchParamPageBtnTitleTextStyle,
            color: Colors.blue,
            borderRadius: 17,
            onTap: _onTapFilterParamSetting,
          ),
          SizedBox(width: 15),
          BMFSearchBtn(
            height: 34,
            width: width,
            title: "检索数据",
            titleTextStyle: searchParamPageBtnTitleTextStyle,
            color: Colors.blue,
            borderRadius: 17,
            onTap: _onTapConfirm,
          ),
        ],
      ),
    );
  }

  /// 过滤参数设置
  void _onTapFilterParamSetting() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowSearchFilterParamsPage(
                callBack: _filterParamsPageCallBack)));
  }

  /// 过滤参数回调
  void _filterParamsPageCallBack(BMFPoiSearchFilter filter) {
    _searchFilter = filter;
  }

  /// 检索数据
  void _onTapConfirm() {
    List<String>? keywords;
    if (_keyworkController.text.isNotEmpty) {
      keywords = _keyworkController.text.split(",");
    }

    BMFCoordinate? location;
    if (_latController.text.isNotEmpty && _lonController.text.isNotEmpty) {
      double lat = double.parse(_latController.text);
      double lon = double.parse(_lonController.text);
      location = BMFCoordinate(lat, lon);
    }

    BMFPoiNearbySearchOption option =
        BMFPoiNearbySearchOption(keywords: keywords, location: location);

    if (_tagsController.text.isNotEmpty) {
      option.tags = _tagsController.text.split(",").toList();
    }

    if (_radiusController.text.isNotEmpty) {
      option.radius = int.parse(_radiusController.text);
    }

    if (_pageSizeController.text.isNotEmpty) {
      option.pageSize = int.parse(_pageSizeController.text);
    }

    if (_pageIndexController.text.isNotEmpty) {
      option.pageIndex = int.parse(_pageIndexController.text);
    }

    option.scope = BMFPoiSearchScopeType.values[_segmentSelectedIdx];

    option.isRadiusLimit = _isRadiusLimitSwitchOn;

    option.filter = _searchFilter;

    if (widget.callBack != null) {
      widget.callBack!(option);
    }

    Navigator.pop(context);
  }
}
