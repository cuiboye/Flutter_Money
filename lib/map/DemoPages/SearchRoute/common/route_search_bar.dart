import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_textfield.dart';

class RouteSearchBar extends StatefulWidget {
  final TextEditingController? startCityController;
  final TextEditingController? endCityController;
  final TextEditingController? startController;
  final TextEditingController? endController;
  final VoidCallback? callback;

  const RouteSearchBar({
    Key? key,
    this.startCityController,
    this.endCityController,
    this.startController,
    this.endController,
    this.callback,
  }) : super(key: key);

  @override
  _RouteSearchBarState createState() => _RouteSearchBarState();
}

class _RouteSearchBarState extends State<RouteSearchBar> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFF22253D),
      height: 80,
      padding: EdgeInsets.all(5),
      child: Container(
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        SearchTextField(
                          controller: widget.startCityController,
                          title: "城市：",
                          width: 90,
                        ),
                        SearchTextField(
                          controller: widget.startController,
                          title: "起点：",
                          width: (screenSize.width - 90 - 60 - 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SearchTextField(
                          controller: widget.endCityController,
                          title: "城市：",
                          width: 90,
                        ),
                        SearchTextField(
                          controller: widget.endController,
                          title: "终点：",
                          width: (screenSize.width - 90 - 60 - 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 2),
              child: BMFSearchBtn(
                title: "搜索",
                borderRadius: 15,
                color: Color(0xFF4B4F6C),
                titleTextStyle: TextStyle(color: Colors.white),
                onTap: () {
                  if (widget.callback != null) {
                    widget.callback!();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
