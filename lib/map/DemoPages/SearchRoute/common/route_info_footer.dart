import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';

class RouteInfoFooter extends StatefulWidget {
  final String? duration;
  final String? distance;
  final GestureTapCallback? onTapDetailBtn;

  const RouteInfoFooter(
      {Key? key, this.duration, this.distance, this.onTapDetailBtn})
      : super(key: key);

  @override
  _RouteInfoFooterState createState() => _RouteInfoFooterState();
}

class _RouteInfoFooterState extends State<RouteInfoFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "${widget.duration}" + "  ${widget.distance}",
              style: _titleTextStyle,
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey.withAlpha(130),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: BMFSearchBtn(
              width: 150,
              height: 30,
              title: "详情",
              color: Colors.blue,
              borderRadius: 15,
              titleTextStyle: _detailBtnTextStyle,
              onTap: () {
                if (widget.onTapDetailBtn != null) {
                  widget.onTapDetailBtn!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

final _titleTextStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 19,
  fontWeight: FontWeight.bold,
);

final _detailBtnTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
