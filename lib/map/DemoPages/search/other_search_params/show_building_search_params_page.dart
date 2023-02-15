import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';

typedef SearchParamsPageCallBack = void Function(BMFBuildingSearchOption);

class ShowBuildingSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowBuildingSearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowBuildingSearchParamsPageState createState() =>
      _ShowBuildingSearchParamsPageState();
}

class _ShowBuildingSearchParamsPageState
    extends State<ShowBuildingSearchParamsPage> {
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "自定义参数",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: ListView(
          children: [
            BMFSearchParamsInputBox(
              controller: _latController,
              title: "纬度（必选）：",
            ),
            SizedBox(
              height: 10,
            ),
            BMFSearchParamsInputBox(
              controller: _lonController,
              title: "经度（必选）：",
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: BMFSearchBtn(
                height: 34,
                width: 200,
                title: "检索数据",
                titleTextStyle: searchParamPageBtnTitleTextStyle,
                color: Colors.blue,
                borderRadius: 17,
                onTap: _onTapConfirm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 检索数据
  void _onTapConfirm() {
    BMFCoordinate? location;
    if (_latController.text.isNotEmpty && _lonController.text.isNotEmpty) {
      double lat = double.parse(_latController.text);
      double lon = double.parse(_latController.text);
      location = BMFCoordinate(lat, lon);
    }

    BMFBuildingSearchOption option = BMFBuildingSearchOption(
        location: location);

    if (widget.callBack == null) {
      widget.callBack!(option);
    }
    Navigator.pop(context);
  }
}
