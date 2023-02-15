import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/model/mass_bus_route_filter_menu_controller.dart';

class MassBusRouteFilterMenu extends StatefulWidget {
  final MassBusRouteFilterMenuController? controller;

  const MassBusRouteFilterMenu({Key? key, this.controller}) : super(key: key);

  @override
  _MassBusRouteFilterMenuState createState() => _MassBusRouteFilterMenuState();
}

class _MassBusRouteFilterMenuState extends State<MassBusRouteFilterMenu> {
  String _incityPolicyValue = "推荐";
  String _intercityPolicyValue = "时间短";
  String _intercityTransPolicyValue = "火车优先";

  List<DropdownMenuItem> _incityPolicyItems = [];
  List<DropdownMenuItem> _intercityPolicyItems = [];
  List<DropdownMenuItem> _intercityTransPolicyItems = [];

  @override
  void initState() {
    super.initState();

    /// 市内公交换乘策略策略
    _incityPolicy.forEach((element) {
      DropdownMenuItem item = DropdownMenuItem(
        child: Text(
          element,
        ),
        value: element,
      );
      _incityPolicyItems.add(item);
    });

    /// 跨城公交换乘策略
    _intercityPolicy.forEach((element) {
      DropdownMenuItem item = DropdownMenuItem(
        child: Text(element),
        value: element,
      );
      _intercityPolicyItems.add(item);
    });

    /// 跨城交通方式策略
    _intercityTransPolicy.forEach((element) {
      DropdownMenuItem item = DropdownMenuItem(
        child: Text(element),
        value: element,
      );
      _intercityTransPolicyItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: EdgeInsets.only(left: 5),
      color: Color(0xFFE5E5E5).withAlpha(160),
      child: Column(
        children: [
          Container(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "市内公交换乘策略：",
                  style: _textStyle,
                ),
                DropdownButton<dynamic>(
                  value: _incityPolicyValue,
                  style: _textStyle,
                  underline: SizedBox(),
                  items: _incityPolicyItems,
                  onChanged: (value) {
                    setState(() {
                      _incityPolicyValue = value as String;
                    });

                    var idx = _incityPolicy.indexOf(value);
                    widget.controller?.incityPolicy =
                        BMFMassTransitIncityPolicy.values[idx];
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "跨城公交换乘策略：",
                  style: _textStyle,
                ),
                DropdownButton<dynamic>(
                  value: _intercityPolicyValue,
                  style: _textStyle,
                  underline: SizedBox(),
                  items: _intercityPolicyItems,
                  onChanged: (value) {
                    setState(() {
                      _intercityPolicyValue = value as String;
                    });

                    var idx = _intercityPolicy.indexOf(value);

                    widget.controller?.intercityPolicy =
                        BMFMassTransitIntercityPolicy.values[idx];
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "跨城交通方式策略：",
                  style: _textStyle,
                ),
                DropdownButton<dynamic>(
                  value: _intercityTransPolicyValue,
                  style: _textStyle,
                  dropdownColor: Colors.white,
                  underline: SizedBox(),
                  items: _intercityTransPolicyItems,
                  onChanged: (value) {
                    setState(() {
                      _intercityTransPolicyValue = value as String;
                    });

                    var idx = _intercityTransPolicy.indexOf(value);
                    widget.controller?.intercityTransPolicy =
                        BMFMassTransitIntercityTransPolicy.values[idx];
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 市内公交换乘策略策略
  List _incityPolicy = [
    "推荐",
    "少换乘",
    "少步行",
    "不坐地铁",
    "较快捷",
    "地铁优先",
  ];

  /// 跨城公交换乘策略
  List _intercityPolicy = [
    "时间短",
    "出发早",
    "价格低",
  ];

  /// 跨城交通方式策略
  List _intercityTransPolicy = [
    "火车优先",
    "飞机优先",
    "大巴优先",
  ];
}

final _textStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);
