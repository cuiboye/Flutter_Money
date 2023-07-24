import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:get/get.dart';

/**
 * @author[wj]
 * @version[创立日期，2023/7/19 18:20]
 * @function[功用简介 ]
 **/
class CustomTaskController extends GetxController {
  String? get selectedDate => _selectedDate;
  String? _selectedDate;
  //日历选择器
  Future<DateTime> selectDatePicker(BuildContext context) async{
    var date = DateTime.now();
    DateTime?  dateTime = await showDatePicker(
      context: context,
      // locale: const Locale("zh"),//设置语言为中文
      initialDate: date,//initialDate：初始化选中的日期
      firstDate: date,//firstDate: 可选择的最早日期
      lastDate: date.add(//lastDate：可选择的最晚日期
        //未来30天可选
        const Duration(days: 30),
      ),
    );
    _selectedDate = formatDate(dateTime!, [yyyy, '-', mm, '-', dd]);
    print("$_selectedDate");
    //   print("$dateTime");//2023-07-21 00:00:00.000
    //     //格式化时间
    //     print(formatDate(dateTime, [yyyy, '-', mm, '-', dd]));//2023-07-21
    //     print(formatDate(
    //         DateTime(1989, 02, 1, 15, 40, 10), [HH, ':', nn, ':', ss]));//15:40:10
    //   }
    // print(formatDate(dateTime, [yyyy, '-', mm, '-', dd]));//2023-07-21
    return dateTime;
  }
}
