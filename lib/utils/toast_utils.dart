import 'package:flutter/material.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{
  static void showToast(String msg){
    if(TextUtils.isEmpty(msg)){
      return;
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}