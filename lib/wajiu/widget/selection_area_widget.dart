
import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/custom_materialapp.dart';

/**
 * 这个组件在Flutter3.3后才可以使用
 */
class SelectionAreawidgetPage extends StatefulWidget {
  const SelectionAreawidgetPage({super.key});

  @override
  State<SelectionAreawidgetPage> createState() => _SelectionAreawidgetPageState();
}

class _SelectionAreawidgetPageState extends State<SelectionAreawidgetPage> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "SelectionAreaWidget组件",),
        body:  Padding(padding: EdgeInsets.all(30.w),
        child:const SelectionArea(child: Text("hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello")),
        ),
      ),
    );
  }
}
