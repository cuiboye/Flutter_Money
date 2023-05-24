import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

typedef SearchParamsPageCallBack = void Function(BMFSuggestionSearchOption);

class ShowSuggestionSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowSuggestionSearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowSuggestionSearchParamsPageState createState() =>
      _ShowSuggestionSearchParamsPageState();
}

class _ShowSuggestionSearchParamsPageState
    extends State<ShowSuggestionSearchParamsPage> {
  TextEditingController _keywordController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  bool _isCityLimitSwitchOn = false;

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
              controller: _keywordController,
              title: "关键字（必选）：",
            ),
            SizedBox(
              height: 10,
            ),
            BMFSearchParamsInputBox(
              controller: _cityController,
              title: "城市：",
              titleWidth: 120,
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

  /// 区域限制开关
  Widget _cityLimitSwitch() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "区域数据返回是否限制",
            style: searchParamPageInputBoxTitleTextStyle,
          ),
          CupertinoSwitch(
            value: _isCityLimitSwitchOn,
            onChanged: (isOn) {
              setState(() {
                _isCityLimitSwitchOn = isOn;
              });
            },
          ),
        ],
      ),
    );
  }

//=========================渲染相关======================

  /// 检索数据
  void _onTapConfirm() {
    BMFSuggestionSearchOption suggestionSearchOption =
        BMFSuggestionSearchOption();
    suggestionSearchOption.keyword = _keywordController.text;
    suggestionSearchOption.cityname = _cityController.text;
    suggestionSearchOption.cityLimit = _isCityLimitSwitchOn;

    if (widget.callBack != null) {
      widget.callBack!(suggestionSearchOption);
    }

    Navigator.pop(context);
  }
}
