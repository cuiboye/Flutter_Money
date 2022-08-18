import 'package:flutter/material.dart';
import 'input_box.dart';

class BMFSearchParamsInputBox extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final double? titleWidth;

  const BMFSearchParamsInputBox({Key? key, this.controller, this.title, this.titleWidth}) : super(key: key);

  @override
  _BMFSearchParamsInputBoxState createState() => _BMFSearchParamsInputBoxState();
}

class _BMFSearchParamsInputBoxState extends State<BMFSearchParamsInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BMFInputBox(
        controller: widget.controller,
        title: widget.title,
        titleStyle: _titleTextStyle,
        titleWidth: widget.titleWidth,
        titleAlignment: Alignment.centerRight,
      ),
    );
  }
}

/// 检索自定义参数页样式
final _titleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);