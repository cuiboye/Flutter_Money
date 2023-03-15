import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

/**
 * 自定义线
 */
class LineView extends StatefulWidget {
  final int line_height;
  final Color? color;

  LineView({this.line_height = 1, this.color});

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: ColorConstant.color_efefef,
    );
  }
}
