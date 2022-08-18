import 'package:flutter/material.dart';

class BMFInputBox extends StatefulWidget {
  final String? title;
  final TextStyle? titleStyle;
  final double? titleWidth;
  final AlignmentGeometry? titleAlignment;
  final String? placeholder;
  final double? width;
  final double? height;

  final double? textFieldWidth;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;

  const BMFInputBox({
    Key? key,
    this.controller,
    this.title = "",
    this.titleStyle = _titleTextStyle,
    this.titleWidth,
    this.titleAlignment,
    this.placeholder = "",
    this.width,
    this.height = 30.0,
    this.textFieldWidth,
    this.margin = const EdgeInsets.only(top: 5),
  }) : super(key: key);

  @override
  _BMFInputBoxState createState() => _BMFInputBoxState();
}

class _BMFInputBoxState extends State<BMFInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.titleWidth,
            alignment: widget.titleAlignment,
            child: Text(
              widget.title??"",
              style: widget.titleStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              height: widget.height,
              width: widget.textFieldWidth,
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54, width: 0.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: TextField(
                controller: widget.controller,
                style: TextStyle(fontSize: 15),
                decoration:
                    InputDecoration.collapsed(hintText: widget.placeholder),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _titleTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.blue,
);
