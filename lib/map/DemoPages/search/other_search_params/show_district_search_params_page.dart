import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';

typedef SearchParamsPageCallBack = void Function(BMFDistrictSearchOption);

class ShowDistrictSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowDistrictSearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowDistrictSearchParamsPageState createState() =>
      _ShowDistrictSearchParamsPageState();
}

class _ShowDistrictSearchParamsPageState
    extends State<ShowDistrictSearchParamsPage> {
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();

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
              controller: _cityController,
              title: "城市（必选）：",
            ),
            SizedBox(
              height: 10,
            ),
            BMFSearchParamsInputBox(
              controller: _districtController,
              title: "区县：",
              titleWidth: 105,
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
    BMFDistrictSearchOption option = BMFDistrictSearchOption(
      city: _cityController.text,
      district: _districtController.text,
    );

    if (widget.callBack != null) {
      widget.callBack!(option);
    }

    Navigator.pop(context);
  }
}
