import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

/**
 * 自定义线
 */
class LineView extends StatefulWidget {
  final double line_height;
  final Color? color;

  LineView({this.line_height = 1.0, this.color = ColorConstant.color_efefef});

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.line_height,
      color: widget.color,
    );
  }
}
