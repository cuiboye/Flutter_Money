import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

typedef SearchParamsPageCallBack = void Function(BMFReverseGeoCodeSearchOption);

class ShowReversegeocodeSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowReversegeocodeSearchParamsPage({Key? key, this.callBack}) : super(key: key);

  @override
  _ShowReversegeocodeSearchParamsPageState createState() => _ShowReversegeocodeSearchParamsPageState();
}

class _ShowReversegeocodeSearchParamsPageState extends State<ShowReversegeocodeSearchParamsPage> {

  bool _isLatestAdmin = false;

  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(title: "自定义参数",),
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
            _cityLimitSwitch(),
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

  /// 是否访问最新版行政区划数据开关
  Widget _cityLimitSwitch() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "是否访问最新版行政区划数据",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isLatestAdmin,
            onChanged: (isOn) {
              setState(() {
                _isLatestAdmin = isOn;
              });
            },
          ),
        ],
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

    BMFReverseGeoCodeSearchOption option = BMFReverseGeoCodeSearchOption(location: location);
    option.isLatestAdmin = _isLatestAdmin;

    if (widget.callBack != null) {
      widget.callBack!(option);
    }

    Navigator.pop(context);
  }
}
