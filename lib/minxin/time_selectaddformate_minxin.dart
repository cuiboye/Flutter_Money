import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

/// 混入 时间选择器和时间格式转换相关
mixin TimeSelectAddFormateMinxin {
  //日历选择器
  Future<DateTime> selectDatePicker(BuildContext context) async {
    var date = DateTime.now();
    DateTime? dateTime = await showDatePicker(
      context: context,
      // locale: const Locale("zh"),//设置语言为中文
      initialDate: date, //initialDate：初始化选中的日期
      firstDate: date, //firstDate: 可选择的最早日期
      lastDate: date.add(
        const Duration(days: 30),
      ),
    );
    //将日历上选择的时间进行格式化，下面的格式是 年-月-日
    String formateTime = formatDate(dateTime!, [yyyy, '-', mm, '-', dd]);
    debugPrint(formateTime);
    return dateTime;
  }

  ///将时间戳转为时分
  ///1690012326838===》9:00
  String hm(int? millis) {
    if (millis == null) return '';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    int hour = date.hour;
    int minute = date.minute;
    return '${hour > 9 ? hour : '0$hour'}:${minute > 9 ? minute : '0$minute'}';
  }

  ///将时间戳转为年月日时分秒
  ///1690012326838===》2023年07月20日15:59:46
  String yMDHMS(int? millis) {
    if (millis == null) return '';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    int hour = date.hour;
    int minute = date.minute;
    int year = date.year;
    int day = date.day;
    int month = date.month;
    int second = date.second;
    return '$year-${month > 9 ? month : '0$month'}-'
        '${day > 9 ? day : '0$day'} '
        '${hour > 9 ? hour : '0$hour'}:${minute > 9 ? minute : '0$minute'}:${second > 9 ? second : '0$second'}';
  }

  //如果没有特殊要求的话，可以使用下面的操作，比较死板不灵活
  String timeFormate(int? millis){
    // String  time = "${millis}000";//后台如果传的是13位，不需要此操作；
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(int.parse(millis.toString()));
    //该操作转为字符串型，并截取我们日常显示的形式； 2020-03-09 12:55:50
    return dateTime.toLocal().toString().substring(0, 10);//10表示前10位
  }
}
