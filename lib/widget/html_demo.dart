import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 加载html代码
 */
class HtmlDemo extends StatefulWidget {
  const HtmlDemo({super.key});

  @override
  State<HtmlDemo> createState() => _HtmlDemoState();
}

class _HtmlDemoState extends State<HtmlDemo> {
  //r为保持字符串中的原始内容，不转义
  String htmlContent = r'<p><img class="wscnph" src="https://xd-file.summergate.com/summergate-wine-shop-management/test/2023/06/19/038449bb3008f04e6726524ade1f8a29_29.jpg?x-oss-process=image/resize,w_750/quality,q_90" /></p>';

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "加载Html代码",),
        body: SingleChildScrollView(
          child: Html(data: htmlContent),
        ),
      ),
    );
  }
}
