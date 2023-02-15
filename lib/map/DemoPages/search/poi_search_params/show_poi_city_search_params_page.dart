import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/DemoPages/search/poi_search_params/show_search_filter_params_page.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

typedef SearchParamsPageCallBack = void Function(BMFPoiCitySearchOption);

class ShowPOICitySearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowPOICitySearchParamsPage({Key? key, this.callBack}) : super(key: key);

  @override
  _ShowPOICitySearchParamsPageState createState() =>
      _ShowPOICitySearchParamsPageState();
}

class _ShowPOICitySearchParamsPageState
    extends State<ShowPOICitySearchParamsPage> {
  int _segmentSelectedIdx = 0;
  bool _isCityLimitSwitchOn = false;

  final _cityController = TextEditingController();
  final _keyworkController = TextEditingController();
  final _tagController = TextEditingController();
  final _pageSizeController = TextEditingController();
  final _pageIndexController = TextEditingController();

  BMFPoiSearchFilter? _searchFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(title: "自定义参数"),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            BMFSearchParamsInputBox(
              controller: _keyworkController,
              title: "关键字（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _cityController,
              title: "城市（必选）：",
              titleWidth: 123,
            ),
            BMFSearchParamsInputBox(
              controller: _tagController,
              title: "分类：",
              titleWidth: 123,
            ),
            BMFSearchParamsInputBox(
              controller: _pageSizeController,
              title: "分页页码：",
              titleWidth: 123,
            ),
            BMFSearchParamsInputBox(
              controller: _pageIndexController,
              title: "召回数量：",
              titleWidth: 123,
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
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "区域数据返回是否限制",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isCityLimitSwitchOn,
            onChanged: (isOn) {
              setState(() {
                _isCityLimitSwitchOn = isOn;
              });
            },
          )
        ],
      ),
    );
  }

  /// 过滤参数设置
  void _onTapFilterParamSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSearchFilterParamsPage(callBack: _filterParamsPageCallBack)));
  }

  /// 过滤参数回调
  void _filterParamsPageCallBack(BMFPoiSearchFilter filter) {
    _searchFilter = filter;
  }

  /// 检索数据
  void _onTapConfirm() {
    BMFPoiCitySearchOption citySearchOption = BMFPoiCitySearchOption(city: _cityController.text, keyword: _keyworkController.text);
    citySearchOption.tags = _tagController.text.isNotEmpty
        ? _tagController.text.split(",").toList()
        : null;
    citySearchOption.scope = BMFPoiSearchScopeType.values[_segmentSelectedIdx];
    citySearchOption.isCityLimit = _isCityLimitSwitchOn;

    if (_pageSizeController.text.isNotEmpty) {
      citySearchOption.pageSize = int.parse(_pageSizeController.text);
    }

    if (_pageIndexController.text.isNotEmpty) {
      citySearchOption.pageIndex = int.parse(_pageIndexController.text);
    }

    citySearchOption.filter = _searchFilter;

    if (widget.callBack != null) {
      widget.callBack!(citySearchOption);
    }

    Navigator.pop(context);
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
          )
        ],
      ),
    );
  }
}
