import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/function_item.widget.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/show_driving_route_search_page.dart';

import 'show_bus_route_search_page.dart';
import 'show_indoor_route_search_page.dart';
import 'show_mass_bus_route_search_page.dart';
import 'show_riding_route_search_page.dart';
import 'show_walk_route_search_page.dart';

class ShowSearchRoutePage extends StatefulWidget {
  @override
  _ShowSearchRoutePageState createState() => _ShowSearchRoutePageState();
}

class _ShowSearchRoutePageState extends State<ShowSearchRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "路线规划",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        child: ListView(
          children: [
            FunctionItem(
              label: '市内公交路线规划',
              sublabel: '该示例演示了市内公交路线检索功能',
              target: ShowBusRouteSearchPage(),
            ),
            FunctionItem(
              label: '跨城公交路线规划',
              sublabel: '该示例演示了跨城公交路线检索功能',
              target: ShowMassBusRouteSearchPage(),
            ),
            FunctionItem(
              label: '驾车路线规划',
              sublabel: '该示例演示了驾车路线规划检索功能',
              target: ShowDrivingRouteSearchPage(),
            ),
            FunctionItem(
              label: '步行路线规划',
              sublabel: '该示例演示了步行路线规划检索功能',
              target: ShowWalkRouteSearchPage(),
            ),
            FunctionItem(
              label: '骑行路线规划',
              sublabel: '该示例演示了骑行路线规划检索功能',
              target: ShowRidingRouteSearchPage(),
            ),
            FunctionItem(
              label: '室内路线规划',
              sublabel: '该示例演示了室内路线规划检索功能',
              target: ShowIndoorRouteSearchPage(),
            ),
          ],
        ),
      ),
    );
  }
}
