import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/function_item.widget.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/Utils/create_share_page.dart';
import 'package:flutter_money/map/DemoPages/Utils/open_baidumap_navipage.dart';

class FlutterBMFUtilsDemo extends StatelessWidget {
  const FlutterBMFUtilsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: '实用工具',
        isBack: false,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            FunctionItem(
                label: '调起百度地图客户端',
                sublabel: 'OpenBaiduMapNaviPage',
                target: OpenBaiduMapNaviPage()),
            FunctionItem(
                label: '短串分享',
                sublabel: 'MapCreateSharePage',
                target: MapCreateSharePage()),
          ],
        ),
      ),
    );
  }
}
