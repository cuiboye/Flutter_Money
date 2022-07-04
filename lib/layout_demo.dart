import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

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
 * 记录：
 * 1）ClipRRect 跟PhysicalModel的区别在于不能设置z轴和阴影，其他效果跟PhysicalModel 基本一致
 *
 */
class LayoutDemoWidget extends StatefulWidget {
  @override
  _LayoutDemoWidgetState createState() => _LayoutDemoWidgetState();
}

class _LayoutDemoWidgetState extends State<LayoutDemoWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "布局的使用",
      home: Scaffold(
        appBar:CustomAppbar(
          title: '布局的使用',
          context: context,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey),
          child: Column(
            //Golumn为垂直布局
            children: [
              Row(
                //Row为水平方向的布局
                children: [
                  ClipOval(
                    //ClipOval可以将组件裁剪为圆形
                    //SizedBox可以约束组件大小，这个组件可有可无,因为很多组件都有自己的大小，比如
                    //下面的Image就剋设置自己的大小，或者在Image外面包裹一层Container
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child:
                          Image.network("http://www.devio.org/img/avatar.png"),
                      // child: Image.network("http://www.devio.org/img/avatar.png",width: 100,height: 100,),
                    ),
                  ),
                  Padding(
                    //Padding可以设置组件的外边距距离上下左右的距离
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      //ClipRRect可以把组件裁剪为矩形，并可以设置四个角的角度
                      borderRadius: BorderRadius.all(//borderRadius可以设置圆角
                          Radius.circular(10)), //
                      child: Opacity(
                        //Opacity可以设置透明度
                        opacity: 0.6,
                        child: Image.network(
                          "http://www.devio.org/img/avatar.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 200,
                  padding: EdgeInsets.all(20.0),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    shadowColor: Colors.red,
                    //阴影颜色
                    clipBehavior: Clip.antiAlias,
                    //clipBehavior裁剪模式，这里设置为抗锯齿
                    elevation: 10,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    //裁剪角度
                    child: PageView(
                      //PageView左右滑动
                      children: [
                        _pageviewItem("Page1", Colors.black),
                        _pageviewItem("Page2", Colors.red),
                        _pageviewItem("Page3", Colors.orange),
                      ],
                    ),
                  )),
              Wrap(
                //Wrap可以实现换行的功能，而Row不能实现自动换行
                spacing: 5.0,
                runSpacing: 5.0,
                children: [
                  _chip("孙悟空"),
                  _chip("猪八戒"),
                  _chip("沙和尚"),
                  _chip("唐僧"),
                  _chip("白骨精"),
                ],
              ),
              Stack(
                //Stack相当于android的RelativeLayout,经常和Positioned搭配使用
                children: [
                  Image.network(
                    "http://www.devio.org/img/avatar.png",
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                      bottom: 0,
                      //表示距离底部距离为0
                      right: 0,
                      width: 50,
                      height: 50,
                      child:
                          Image.network("http://www.devio.org/img/avatar.png"))
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("没有使用FractionallySizedBox这个控件的View"),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 13, top: 10, right: 13, bottom: 0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Text(
                          "使用了FractionallySizedBox组件，这个组件可以设置宽和高的权重，相当于安卓的weight"),
                    )),
              ),
              Expanded(//Expanded可以将剩余高度填满，相当于安卓高度的weight权重
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text("文字2"),
                )
              ),
              Text("文字2"),
            ],
          ),
        ),
      ),
    );
  }

  _pageviewItem(String title, Color color) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
      decoration: BoxDecoration(color: color),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
