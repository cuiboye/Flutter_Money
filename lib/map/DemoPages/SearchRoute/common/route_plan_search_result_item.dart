import 'package:flutter/material.dart';

class RoutePlanSearchResultItem extends StatefulWidget {
  final String? distance;
  final String? duration;
  final List<String>? vehicleInfoTitles;
  final String? passStationNum;
  final String? stationName;
  final GestureTapCallback? onTap;

  const RoutePlanSearchResultItem({
    Key? key,
    this.distance,
    this.duration,
    this.vehicleInfoTitles,
    this.passStationNum,
    this.stationName,
    this.onTap,
  }) : super(key: key);

  @override
  _RoutePlanSearchResultItemState createState() =>
      _RoutePlanSearchResultItemState();
}

class _RoutePlanSearchResultItemState extends State<RoutePlanSearchResultItem> {
  final List<Widget> _vehicleInfoTitleWidgets = [];

  @override
  void initState() {
    super.initState();

    int i = 0;
    widget.vehicleInfoTitles?.forEach((element) {
      Widget titleWidget = _getVehicleInfoTitleWidget(element);
      _vehicleInfoTitleWidgets.add(titleWidget);

      if (i != widget.vehicleInfoTitles!.length - 1) {
        _vehicleInfoTitleWidgets.add(Image.asset(
          "resoures/next.png",
          width: 5,
          height: 9,
        ));
      }

      i++;
    });
  }

  @override
  Widget build(BuildContext context) {

    String detailStr = "${widget.passStationNum}";

    if (widget.stationName != null) {
      detailStr +=  " · " + "${widget.stationName}";
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${widget.duration}"),
                      SizedBox(height: 5.0),
                      Text("${widget.distance}"),
                    ],
                  ),
                ),
                Container(
                  width: 0.5,
                  color: Colors.grey.withAlpha(130),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 5 - 80 - 0.5 - 15 - 10 - 5),
                        child: Wrap(
                          spacing: 3.0,
                          runSpacing: 3.0,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: _vehicleInfoTitleWidgets,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(detailStr),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
    );
  }

  Widget _getVehicleInfoTitleWidget(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: Colors.blue, width: 0.5),
      ),
      child: Text(
        "$title",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
