import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final double? width;
  final String? title;
  final String? hintText;
  final TextAlign textAlign;
  final TextEditingController? controller;

  const SearchTextField({
    Key? key,
    required this.width,
    this.title,
    this.hintText,
    this.controller,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        children: [
          Visibility(
            visible: widget.title != null,
            child: Text(
              widget.title ?? "",
              style: _titleTextStyle,
            ),
          ),
          Expanded(
            child: Container(
              height: 35,
              // color: Colors.indigo,
              padding: EdgeInsets.only(top: 5, bottom: 7, right: 5),
              child: Stack(
                children: [
                  TextField(
                    textAlign: widget.textAlign,
                    controller: widget.controller,
                    style: _textFieldTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                      hintStyle: _textFieldTextStyle,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(height: 1.0, color: Colors.white,),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _titleTextStyle = TextStyle(color: Colors.white, fontSize: 14);
final _textFieldTextStyle = TextStyle(color: Colors.white, fontSize: 16);
