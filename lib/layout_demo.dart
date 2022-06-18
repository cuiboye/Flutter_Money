import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 布局相关组件：
 * 1）Container
 * 2)RenderObjectWidget
 *    ---SingleChildRenderObjectWidget  单节点布局组件
 *        ---Opacity
 *        ---ClipOval
 *        ---PhysicalModel
 *        ---Align Center
 *        ---Padding
 *        ---SizedBox
 *        ---FractionallySizedBox
 *    ---MultiChildRenderObjectWidget   都节点布局组件
 *        ---Stack
 *        ---Flex
 *            ---Column
 *            ---Row
 *        ---Wrap
 *        ---Flow
 * 3)ParentDataWidget
 *    ---Positioned
 *    ---Flexble Expanded
 *
 */
class LayoutDemoWidget extends StatefulWidget {
  @override
  _LayoutDemoWidgetState createState() => _LayoutDemoWidgetState();
}

class _LayoutDemoWidgetState extends State<LayoutDemoWidget> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "布局的使用",
      home: Container(
        decoration: BoxDecoration(color: Colors.grey),
      ),
    );
  }
}
