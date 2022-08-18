import 'package:flutter/material.dart';

class Constants {
  static const String actionBarColor = '0xFF1F2131';
  static const String controlBarColor = '0xD91F2131';
  static const String btnColor = '0xD9292B3C';
}

/// 检索自定义参数页样式
final searchParamPageInputBoxTitleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

final searchParamPageBtnTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 15,
);

final defaultBtnBgColor = MaterialStateProperty.all(Color(int.parse(Constants.btnColor)));