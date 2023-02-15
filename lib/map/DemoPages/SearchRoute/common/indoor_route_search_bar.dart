import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_textfield.dart';

class IndoorRouteSearchBar extends StatefulWidget {
  final startLatController;
  final startLonController;
  final startFloorController;
  final endLatController;
  final endLonController;
  final endFloorController;
  final VoidCallback? callback;

  const IndoorRouteSearchBar({
    Key? key,
    this.startLatController,
    this.startLonController,
    this.startFloorController,
    this.endLatController,
    this.endLonController,
    this.endFloorController,
    this.callback,
  }) : super(key: key);

  @override
  _IndoorRouteSearchBarState createState() => _IndoorRouteSearchBarState();
}

class _IndoorRouteSearchBarState extends State<IndoorRouteSearchBar> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var w = (screenWidth - 10 - 80) / 2.0;
    return Container(
      height: 120,
      padding: EdgeInsets.all(5),
      color: Color(0xFF22253D),
      child: Column(
        children: [
          Row(
            children: [
              SearchTextField(
                controller: widget.startLatController,
                title: "起点：",
                width: w + 20,
              ),
              SearchTextField(
                controller: widget.startLonController,
                width: w - 20,
              ),
              SearchTextField(
                controller: widget.startFloorController,
                title: "楼层：",
                textAlign: TextAlign.center,
                width: 80,
              ),
            ],
          ),
          Row(
            children: [
              SearchTextField(
                controller: widget.endLatController,
                title: "终点：",
                width: w + 20,
              ),
              SearchTextField(
                controller: widget.endLonController,
                width: w - 20,
              ),
              SearchTextField(
                controller: widget.endFloorController,
                title: "楼层：",
                textAlign: TextAlign.center,
                width: 80,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: BMFSearchBtn(
              width: 200,
              height: 30,
              title: "发起室内路线规划",
              borderRadius: 15,
              color: Color(0xFF4B4F6C),
              titleTextStyle: TextStyle(color: Colors.white),
              onTap: () {
                if (widget.callback != null) {
                  widget.callback!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
