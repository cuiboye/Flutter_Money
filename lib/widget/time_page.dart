import 'package:flutter/material.dart';
import 'package:flutter_money/minxin/time_selectaddformate_minxin.dart';

/// 时间选择和格式转换相关
class TimePage extends StatefulWidget {
  const TimePage({Key? key}) : super(key: key);

  @override
  _TimePage createState() => _TimePage();
}

class _TimePage extends State<TimePage> with TimeSelectAddFormateMinxin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("时间选择和格式转换相关"),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed:()=>selectDatePicker(context), child: const Text("日历时间选择器弹框")),
            Text("将时间戳转为时分 ${hm(1690012326838)}"),
            Text("将时间戳转为年月日时分秒 ${yMDHMS(1690012326838)}"),
            Text("将时间戳转为年月日时分秒，这种方式比较死板 ${timeFormate(1690012326838)}")
          ],
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
