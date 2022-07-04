import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/custom_materialapp.dart';

class PageViewItem extends StatefulWidget {
  @override
  _PageViewItemState createState() => _PageViewItemState();
  final String? info;
  PageViewItem({this.info});
}

class _PageViewItemState extends State<PageViewItem> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home:Scaffold(
          body: Text(widget.info??""),
        )
    );
  }
}
