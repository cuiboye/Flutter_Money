import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/function_item.widget.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_buildingpsearch_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_busline_search_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_district_search_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_geocode_search_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_recommend_stop_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_reversegeocode_search_page.dart';
import 'package:flutter_money/map/DemoPages/search/other_search/show_weather_search_page.dart';
import '../poi_search/show_poi_bounds_search_page.dart';
import '../poi_search/show_poi_city_search_page.dart';
import '../poi_search/show_poi_detail_search_page.dart';
import '../poi_search/show_poi_indoor_search_page.dart';
import '../poi_search/show_poi_nearby_search_page.dart';
import '../other_search/show_suggestion_search_page.dart';


class ShowSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "检索地图数据",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(child: ListView(children: [
        FunctionItem(
          label: 'POI城市内检索',
          sublabel: 'show_poi_city_search_page',
          target: ShowPOICitySearchPage(),
        ),
        FunctionItem(
          label: 'POI区域检索',
          sublabel: 'show_poi_bounds_search_page',
          target: ShowPOIBoundsSearchPage(),
        ),
        FunctionItem(
          label: 'POI周边检索',
          sublabel: 'show_poi_nearby_search_page',
          target: ShowPOINearbySearchPage(),
        ),
        FunctionItem(
          label: 'POI详情检索',
          sublabel: 'show_poi_detail_search_page',
          target: ShowPOIDetailSearchPage(),
        ),
        FunctionItem(
          label: 'POI室内检索',
          sublabel: 'show_poi_indoor_search_page',
          target: ShowPOIIndoorSearchPage(),
        ),
        FunctionItem(
          label: '关键词匹配检索',
          sublabel: 'show_suggestion_search_page',
          target: ShowSuggestionSearchPage(),
        ),
        FunctionItem(
          label: '行政区边界检索',
          sublabel: 'show_district_search_page',
          target: ShowDistrictSearchPage(),
        ),
        FunctionItem(
          label: '公交线路检索',
          sublabel: 'show_busline_search_page',
          target: ShowBuslineSearchPage(),
        ),
        FunctionItem(
          label: '地理编码检索',
          sublabel: 'show_geocode_search_page',
          target: ShowGCSearchPage(),
        ),
        FunctionItem(
          label: '逆地理编码检索',
          sublabel: 'show_reversegeocode_search_page',
          target: ShowRGCSearchPage(),
        ),
        FunctionItem(
          label: '推荐上车点',
          sublabel: 'show_recommend_stop_page',
          target: ShowRecommendStopPage(),
        ),
        FunctionItem(
          label: '天气检索',
          sublabel: 'show_recommend_stop_page',
          target: ShowWeatherSearchPage(),
        ),
        FunctionItem(
          label: '建筑物检索',
          sublabel: 'show_buildingpsearch_page.dart',
          target: ShowBuildingSearchPage(),
        ),
      ],),
    ),
    );
  }
}
