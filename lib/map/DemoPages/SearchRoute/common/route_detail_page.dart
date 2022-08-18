import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/SearchRoute/model/route_step_model.dart';

class RouteDetailPage extends StatefulWidget {
  final routeModel;

  const RouteDetailPage({Key? key, this.routeModel}) : super(key: key);

  @override
  _RouteDetailPageState createState() => _RouteDetailPageState();
}

class _RouteDetailPageState extends State<RouteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "路线详情",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Color(0xFFF7F7F7),
        child: ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: widget.routeModel.steps.length + 1,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == 0) {
      return _headerItem();
    } else {
      return _routeInfoItem(index);
    }
  }

  Widget _headerItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        "${widget.routeModel.duration}" +
            "  （${"${widget.routeModel.distance}"}）",
        style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _routeInfoItem(int idx) {
    RouteStepModel step = widget.routeModel.steps[idx - 1];

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(
                  step.image ?? "",
                  width: 25,
                  height: 25,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text("${step.instruction}"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey.withAlpha(130),
            margin: EdgeInsets.only(left: 45, right: 10),
          ),
        ],
      ),
    );
  }
}
