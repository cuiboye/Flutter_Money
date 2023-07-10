import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/accurate_sized_box.dart';

class AccurateSizedBoxDemo extends StatefulWidget {
  const AccurateSizedBoxDemo({super.key});

  @override
  State<AccurateSizedBoxDemo> createState() => _AccurateSizedBoxDemoState();
}

class _AccurateSizedBoxDemoState extends State<AccurateSizedBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(100, 100)),
            // The child size will be 50×50.
            child: AccurateSizedBox(//如果这里变为SizeBox，那么下面的Container的大小将会为宽100高100
              width: 50,
              height: 50,
              child: Container(
                width: 200,
                height: 200,
                color: ColorConstant.color_f62d2d,
              ),
            ),
          ),
        ),
        appBar: CustomAppbar(context: context,title: "精确的SizeBox",),
      ),
    );
  }
}
