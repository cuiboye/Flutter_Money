import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';

import '../view/custom_materialapp.dart';

/**
 * ScroSingleChildScrollView
 * 1)SingleChildScrollView类似于Android中的ScrollView，它只能接收一个子组件
 * 2)通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，这是因为SingleChildScrollView不支持基
 * 于 Sliver 的延迟加载模型，所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用SingleChildScrollView将会非常
 * 昂贵（性能差），此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView。
 */
class SinglechildScrollViewWidget extends StatefulWidget {
  @override
  _SinglechildScrollViewWidgetState createState() => _SinglechildScrollViewWidgetState();
}

class _SinglechildScrollViewWidgetState extends State<SinglechildScrollViewWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: 'SingleChildScrollView',
          context: context,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("SingleChildScrollView类似于Android中的ScrollView，它只能接收一个子组件,通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，这是因为SingleChildScrollView不支持基于 Sliver 的延迟加载模型，所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用SingleChildScrollView将会非常昂贵（性能差），此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView。"*200)
            ],
          ),
        ),
      ),
    );
  }
}
