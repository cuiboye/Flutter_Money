import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/search_btn.dart';
import 'package:flutter_money/map/CustomWidgets/search_params_input_box.dart';
import 'package:flutter_money/map/constants.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

typedef SearchParamsPageCallBack = void Function(BMFPoiDetailSearchOption);

class ShowPOIDetailSearchParamsPage extends StatefulWidget {
  final SearchParamsPageCallBack? callBack;

  const ShowPOIDetailSearchParamsPage({Key? key, this.callBack})
      : super(key: key);

  @override
  _ShowPOIDetailSearchParamsPageState createState() =>
      _ShowPOIDetailSearchParamsPageState();
}

class _ShowPOIDetailSearchParamsPageState
    extends State<ShowPOIDetailSearchParamsPage> {
  int _segmentSelectedIdx = 0;

  final _uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: "自定义参数",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
        child: ListView(
          children: [
            BMFSearchParamsInputBox(
              controller: _uidController,
              title: "POI的UID：",
            ),
            Text(
              "（必选，多个用英文逗号隔开）",
              style: searchParamPageInputBoxTitleTextStyle,
            ),
            // TextField(),
            CupertinoSegmentedControl(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              groupValue: _segmentSelectedIdx,
              children: {
                0: Text("检索基本信息"),
                1: Text("检索详细信息"),
              },
              selectedColor: Colors.blue,
              onValueChanged: (idx) {
                setState(() {
                  _segmentSelectedIdx = idx as int;
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
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
    List<String>? uids;
    if (_uidController.text.isNotEmpty) {
      uids = _uidController.text.split(",");
    }
    BMFPoiDetailSearchOption option = BMFPoiDetailSearchOption(poiUIDs: uids);

    option.scope = BMFPoiSearchScopeType.values[_segmentSelectedIdx];

    if (widget.callBack != null) {
      widget.callBack!(option);
    }

    Navigator.pop(context);
  }
}
