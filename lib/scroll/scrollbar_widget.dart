import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';

import '../view/custom_materialapp.dart';

/**
 * ScrollBar
 */
class ScrollBarWidget extends StatefulWidget {
  @override
  _ScrollBarWidgetState createState() => _ScrollBarWidgetState();
}

class _ScrollBarWidgetState extends State<ScrollBarWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: 'ScrollBar',
          context: context,
        ),
        // body: Scrollbar(//ScrollBar加载第一个可滚动的组件上，可以增加滚动条
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           Text("Hello"*10000)
        //         ],
        //       ),
        //     )
        // )
        body: SingleChildScrollView(//这个效果是没有滚动条的
          child: Column(
            children: [
              Text("Scrollbar是一个Material风格的滚动指示器（滚动条），如果要给可滚动组件添加滚动条，只需将Scrollbar作为可滚动组件的任意一个父级组件即可"*10000)
            ],
          ),
        ),
      ),
    );
  }
}
