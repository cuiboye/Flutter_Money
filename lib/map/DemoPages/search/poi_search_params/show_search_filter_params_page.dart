import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

typedef FilterParamsPageCallBack = void Function(BMFPoiSearchFilter);

class ShowSearchFilterParamsPage extends StatefulWidget {
  final FilterParamsPageCallBack? callBack;

  const ShowSearchFilterParamsPage({Key? key, this.callBack}) : super(key: key);

  @override
  _ShowSearchFilterParamsPageState createState() =>
      _ShowSearchFilterParamsPageState();
}

class _ShowSearchFilterParamsPageState
    extends State<ShowSearchFilterParamsPage> {
  /// 行业
  int _industryTypeSelectedIdx = 0;

  /// 排序依据
  int _sortBasisIdx = 0;

  /// 排序规则
  int _sortRuleSelectedIdx = 0;

  /// 是否有团购
  bool _isGrouponSwitchOn = false;

  /// 是否有打折
  bool _isDiscountSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "过滤条件",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: ListView(
          children: [
            _industryTypeSegmentControl(),
            SizedBox(height: 20),
            _sortBasisPicker(),
            SizedBox(height: 30),
            _sortRuleSegmentControl(),
            SizedBox(height: 10),
            _grouponSwitch(),
            SizedBox(height: 10),
            _discountSwitch(),
            SizedBox(height: 30),
            _filterBtn()
          ],
        ),
      ),
    );
  }

  /// 所属行业
  Widget _industryTypeSegmentControl() {
    return CupertinoSegmentedControl(
      groupValue: _industryTypeSelectedIdx,
      children: {
        0: Text("宾馆"),
        1: Text("餐饮"),
        2: Text("生活娱乐"),
      },
      selectedColor: Colors.blue,
      onValueChanged: (idx) {
        setState(() {
          _industryTypeSelectedIdx = idx as int;
        });
      },
    );
  }

  ///  排序依据 picker
  Widget _sortBasisPicker() {
    return Container(
      height: 80,
      alignment: Alignment.bottomCenter,
      child: CupertinoPicker(
          itemExtent: 40,
          diameterRatio: 1.5,
          children: _getSortBasisPickerData(),
          onSelectedItemChanged: (idx) {
            _sortBasisIdx = idx;
          }),
    );
  }

  /// 排序依据 picker 数据
  List<Widget> _getSortBasisPickerData() {
    switch(_industryTypeSelectedIdx) {
      case 0:
        return _sortBasisHOTEL;
      case 1:
        return _sortBasisCATER;
      case 2:
        return _sortBasisLIFE;
      default:
        return _sortBasisHOTEL;
    }
  }

  /// 排序规则
  Widget _sortRuleSegmentControl() {
    return CupertinoSegmentedControl(
      groupValue: _sortRuleSelectedIdx,
      children: {
        0: Text("降序排列"),
        1: Text("升序排列"),
      },
      selectedColor: Colors.blue,
      onValueChanged: (idx) {
        setState(() {
          _sortRuleSelectedIdx = idx as int;
        });
      },
    );
  }

  /// 团购开关
  Widget _grouponSwitch() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "是否有团购：",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isGrouponSwitchOn,
            onChanged: (isOn) {
              setState(() {
                _isGrouponSwitchOn = isOn;
              });
            },
          )
        ],
      ),
    );
  }

  /// 打折开关
  Widget _discountSwitch() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "是否有打折：",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isDiscountSwitchOn,
            onChanged: (isOn) {
              setState(() {
                _isDiscountSwitchOn = isOn;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _filterBtn() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BMFSearchBtn(
            height: 34,
            width: 150,
            title: "确定",
            titleTextStyle: searchParamPageBtnTitleTextStyle,
            color: Colors.blue,
            borderRadius: 17,
            onTap: _onTapConfirm,
          )
        ],
      ),
    );
  }

  /// 确定
  void _onTapConfirm() {
    BMFPoiSearchFilter filter = BMFPoiSearchFilter();
    filter.industryType = BMFPoiIndustryType.values[_industryTypeSelectedIdx];
    int sortBasisIdx = _sortBasisIdx;
    if (_industryTypeSelectedIdx == 1) {
      sortBasisIdx += _sortBasisHOTEL.length;
    } else if (_industryTypeSelectedIdx == 2) {
      sortBasisIdx = sortBasisIdx + _sortBasisHOTEL.length + _sortBasisCATER.length;
    }
    filter.sortBasis = BMFPoiSortBasisType.values[sortBasisIdx];
    filter.sortRule = BMFPoiSortRuleType.values[_sortRuleSelectedIdx];
    filter.isGroupon = _isGrouponSwitchOn;
    filter.isDiscount = _isDiscountSwitchOn;

    if (widget.callBack != null) {
      widget.callBack!(filter);
    }

    Navigator.pop(context);
  }

  /// 宾馆
  List<Widget> _sortBasisHOTEL = [
    Text("默认排序"),
    Text("按价格排序"),
    Text("按距离排序（只对周边有效）"),
    Text("按好评排序"),
    Text("按星级排序"),
    Text("按卫生认排序"),
  ];

  /// 餐饮
  List<Widget> _sortBasisCATER = [
    Text("默认排序"),
    Text("按价格排序"),
    Text("按距离排序（只对周边有效）"),
    Text("按口味排序"),
    Text("按好评排序"),
    Text("按服务排序"),
  ];

  /// 生活娱乐
  List<Widget> _sortBasisLIFE = [
    Text("默认排序"),
    Text("按价格排序"),
    Text("按距离排序（只对周边有效）"),
    Text("按好评排序"),
    Text("按服务排序"),
  ];
}
