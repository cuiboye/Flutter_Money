import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_search_filter_params_page.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';

typedef SearchParamsPageCallBack = void Function(BMFPoiBoundSearchOption);

class ShowPOIBoundsSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowPOIBoundsSearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowPOIBoundsSearchParamsPageState createState() =>
      _ShowPOIBoundsSearchParamsPageState();
}

class _ShowPOIBoundsSearchParamsPageState
    extends State<ShowPOIBoundsSearchParamsPage> {
  final _keyworkController = TextEditingController();
  final _lbLatController = TextEditingController();
  final _lbLonController = TextEditingController();
  final _rtLatSizeController = TextEditingController();
  final _rtLonIndexController = TextEditingController();
  final _tagsController = TextEditingController();
  final _pageIndexController = TextEditingController();
  final _pageSizeController = TextEditingController();

  int _segmentSelectedIdx = 0;

  BMFPoiSearchFilter? _searchFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(title: "自定义参数"),
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
              titleWidth: 155,
            ),
            BMFSearchParamsInputBox(
              controller: _lbLatController,
              title: "左下角纬度（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _lbLonController,
              title: "左下角经度（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _rtLatSizeController,
              title: "右上角纬度（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _rtLonIndexController,
              title: "右上角经度（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _tagsController,
              title: "分类：",
              titleWidth: 155,
            ),
            BMFSearchParamsInputBox(
              controller: _pageIndexController,
              title: "分页：",
              titleWidth: 155,
            ),
            BMFSearchParamsInputBox(
              controller: _pageSizeController,
              title: "数量：",
              titleWidth: 155,
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
            _filterBtn(),
          ],
        ),
      ),
    );
  }

  Widget _filterBtn() {
    double width = (MediaQuery.of(context).size.width - 45) / 2;
    return Container(
      margin: EdgeInsets.only(top: 10),
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
    List<String> keywords = _keyworkController.text.split(",");

    BMFCoordinate? leftBottom;
    if (_lbLatController.text.isNotEmpty && _lbLonController.text.isNotEmpty) {
      leftBottom = BMFCoordinate(
        double.parse(_lbLatController.text),
        double.parse(_lbLonController.text),
      );
    }

    BMFCoordinate? rightTop;
    if (_rtLatSizeController.text.isNotEmpty &&
        _rtLonIndexController.text.isNotEmpty) {
      rightTop = BMFCoordinate(
        double.parse(_rtLatSizeController.text),
        double.parse(_rtLonIndexController.text),
      );
    }

    BMFPoiBoundSearchOption boundSearchOption = BMFPoiBoundSearchOption(
      keywords: keywords,
      leftBottom: leftBottom,
      rightTop: rightTop,
    );

    if (_tagsController.text.isNotEmpty) {
      boundSearchOption.tags = _tagsController.text.split(",");
    }

    if (_pageSizeController.text.isNotEmpty) {
      boundSearchOption.pageSize = int.parse(_pageSizeController.text);
    }

    if (_pageIndexController.text.isNotEmpty) {
      boundSearchOption.pageIndex = int.parse(_pageIndexController.text);
    }

    boundSearchOption.scope = BMFPoiSearchScopeType.values[_segmentSelectedIdx];

    boundSearchOption.filter = _searchFilter;

    if (widget.callBack != null) {
      widget.callBack!(boundSearchOption);
    }

    Navigator.pop(context);
  }
}
