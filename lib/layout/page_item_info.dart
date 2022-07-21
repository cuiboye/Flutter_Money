import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/custom_materialapp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 信息台
 */
class PageInfoItem extends StatefulWidget {
  @override
  _PageInfoItemState createState() => _PageInfoItemState();
  final String? info;
  PageInfoItem({this.info});
}

class _PageInfoItemState extends State<PageInfoItem> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375,812),
        builder: (BuildContext context, Widget? child,){
          return CustomMaterialApp(

          );
        }
    );
  }
}
