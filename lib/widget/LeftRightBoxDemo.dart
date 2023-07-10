import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/view/left_right_box.dart';

class LeftRightBoxDemo extends StatefulWidget {
  const LeftRightBoxDemo({super.key});

  @override
  State<LeftRightBoxDemo> createState() => _LeftRightBoxDemoState();
}

class _LeftRightBoxDemoState extends State<LeftRightBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "支持左右布局的Widget",),
        body: Column(
          children: [
            const Row(
              children: [
                Text("国漫精选"),
                Spacer(),
                Text("更多》")
              ],
            ),
            LeftRightBox(left: Text("国漫精选"),right: Text("更多》"),),
            LeftRightBox(
              left: Text("国漫精选" * 10, maxLines: 1),
              right: Text("更多》"),
            ),
            LeftRightBox(//左右内容太多的话，左右各占一半
              left: Text("国漫精选" * 10, maxLines: 1),
              right: Text('xxxxxx' * 8),
              verticalAlign: VerticalAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
