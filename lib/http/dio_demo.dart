import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 第三方网络请求框架Dio的使用
 */
class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: 'Dio的使用',
          context: context,
        ),
      ),
    );
  }
}
