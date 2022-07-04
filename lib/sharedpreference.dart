
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

class SharedPreferenceWidget extends StatefulWidget {
  @override
  _SharedPreferenceWidgetState createState() => _SharedPreferenceWidgetState();
}

class _SharedPreferenceWidgetState extends State<SharedPreferenceWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Column(
          children: [

          ],
        ),
        appBar:CustomAppbar(
          title: 'sharedpreference存储数据',
          context: context,
        ),
      ),
    );
  }
}
