import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

typedef SearchParamsPageCallBack = void Function(BMFPoiIndoorSearchOption);

class ShowPOIIndoorSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowPOIIndoorSearchParamsPage({Key? key, this.callBack}) : super(key: key);

  @override
  _ShowPOIIndoorSearchParamsPageState createState() => _ShowPOIIndoorSearchParamsPageState();
}

class _ShowPOIIndoorSearchParamsPageState extends State<ShowPOIIndoorSearchParamsPage> {

  final TextEditingController _indoorIDController = TextEditingController();
  final TextEditingController _keyworkController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _pageSizeController = TextEditingController();
  final TextEditingController _pageIndexController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(title: "自定义参数",),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: ListView(
          children: [
            BMFSearchParamsInputBox(
              controller: _indoorIDController,
              title: "室内ID（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _keyworkController,
              title: "关键字（必选）：",
            ),
            BMFSearchParamsInputBox(
              controller: _floorController,
              title: "楼层：",
              titleWidth: 120,
            ),
            BMFSearchParamsInputBox(
              controller: _pageSizeController,
              title: "数量：",
              titleWidth: 120,
            ),
            BMFSearchParamsInputBox(
              controller: _pageIndexController,
              title: "分页：",
              titleWidth: 120,
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

    BMFPoiIndoorSearchOption option = BMFPoiIndoorSearchOption(indoorID: _indoorIDController.text, keyword: _keyworkController.text,);
    option.floor = _floorController.text;
    option.pageSize = _pageSizeController.text.isNotEmpty ? int.parse(_pageSizeController.text) : 10;
    option.pageIndex = _pageIndexController.text.isNotEmpty ? int.parse(_pageIndexController.text) : 0;

    if (widget.callBack != null) {
      widget.callBack!(option);
    }

    Navigator.pop(context);
  }
}
