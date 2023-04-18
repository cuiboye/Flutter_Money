import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/layout/linearlayout.dart';
import 'package:flutter_money/view/over_scroll_behavior.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PageViewItem extends StatefulWidget {
  @override
  _PageViewItemState createState() => _PageViewItemState();
  final String? info;

  PageViewItem({this.info});
}

class _PageViewItemState extends State<PageViewItem> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;//保持页面状态

  List<String> leftTypeList = [
    "特色",
    "品牌推荐",
    "干红",
    "干白",
    "桃红",
    "甜型",
    "起泡酒",
    "半干",
    "半甜",
    "无醇",
    "配制酒",
    "啤酒",
    "烈酒",
    "酒周边"
  ];

  List<String> rightItem1 = [
    "0-20元",
    "21-30元",
    "31-50元",
    "51-100元",
    "101-150元",
    "151以上"
  ];
  List<String> rightItem2 = [
    "法国",
    "意大利",
    "西班牙",
    "德国",
    "南非",
    "阿根廷",
    "葡萄牙",
    "澳大利亚",
    "匈牙利",
    "斯洛文尼亚"
  ];
  List<String> rightItem3 = [
    "坦普尼罗/丹魄",
    "雷司令",
    "长相思",
    "赛美容",
    "琼瑶浆",
    "玫瑰香",
    "慕思卡黛",
    "白诗南",
    "宝石解百纳",
    "特雷比奥罗",
    "阿依仑",
    "西万尼",
    "莫斯卡托",
    "玛尔维萨",
    "布拉凯多",
    "罗丽红",
    "巴罗卡红",
    "费尔诺皮埃斯",
    "莎斯拉",
    "肯纳",
    "福明特"
  ];
  List<String> rightItem4 = [
    "11.0%以下",
    "6.0%~6.5%",
    "11.1%~11.9%",
    "12.0%~12.9%",
    "13.0%~13.9%",
    "14.0%~14.9%",
    "15.0%~15.9%",
    "16.0%~16.9%",
    "17.0%以上"
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //获取安全区域
    final padding = MediaQuery.of(context).padding;
    return Column(
      children: [
        Container(
          //这是一个假的状态栏
          decoration: BoxDecoration(color: Colors.red),
          height: padding.top,
        ),
        Container(
          color: ColorConstant.color_ef7134,
          child: Container(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
            margin: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            decoration: BoxDecoration(
                color: ColorUtil.color("#bdffffff"),
                //设置边框,也可以通过 Border()的构造方法 分别设置上下左右的边框
                border: Border.all(width: 1, color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Row(
              children: [
                Image.asset(
                  "images/app_home_tabbar_seach.png",
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("搜索一下",
                      style: TextStyle(
                          fontSize: 12, color: ColorUtil.color("#a3a2a2"))),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                      padding: EdgeInsets.only(top: 0),
                      child: ScrollConfiguration(
                        behavior: OverScrollBehavior(), //去除水波纹
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) =>
                              leftItemWidget(index),
                          itemCount: leftTypeList.length,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return LineView(
                                color: ColorConstant.color_d8d8d8,
                                line_height: 0.5);
                          },
                        ),
                      )
                  )
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ScrollConfiguration(
                        behavior: OverScrollBehavior(),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              rightItemWidget(index),
                          // itemCount: leftTypeList.length,
                          itemCount: 5,
                          shrinkWrap: true,
                        ),
                      )),
                ))
          ],
        ))
      ],
    );
  }

  Widget rightItemWidget(int index) {
    String fatherName = "";
    String assetName = "";
    List<String> rightListItem = [];
    if (index == 1) {
      fatherName = "价格";
      assetName = "images/tv_bg_category_title1.png";
      rightListItem = rightItem1;
    } else if (index == 2) {
      fatherName = "产地";
      assetName = "images/tv_bg_category_title2.png";
      rightListItem = rightItem2;
    } else if (index == 3) {
      fatherName = "葡萄";
      assetName = "images/tv_bg_category_title3.png";
      rightListItem = rightItem3;
    } else if (index == 4) {
      fatherName = "酒精度区间";
      assetName = "images/tv_bg_category_title4.png";
      rightListItem = rightItem4;
    }
    if (index == 0) {
      return Container(
        padding: EdgeInsets.only(left: 13, right: 13, top: 13),
        child: Image.asset("images/categrory_wine_semi_sweet.jpeg"),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 25,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(assetName), fit: BoxFit.fill)),
              margin: EdgeInsets.only(left: 13, right: 13, top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(fatherName,
                      style: TextStyle(color: ColorConstant.color_606366,fontSize: 13),),
                    // color: ColorConstant.systemColor,
                    margin: EdgeInsets.only(left: 13),
                  )
                ],
              )),
          Container(
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: rightTextItem(rightListItem),
            ),
            margin: EdgeInsets.only(left: 13, right: 13, top: 10),
          )
        ],
      );
    }
  }

  List<Widget> rightTextItem(List<String> list) {
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      Widget widget = Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 3, bottom: 3),
        decoration: BoxDecoration(
            color: ColorConstant.color_eeeeee,
            border: Border.all(width: 1, color: ColorConstant.color_eeeeee),
            //边框
            borderRadius: BorderRadius.all(Radius.circular(2.0)) //边框圆角
            ),
        child: Center(
          child: Text(
            list[i],
            style: TextStyle(fontSize: 12,color: ColorConstant.color_606366),
          ),
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  Widget leftItemWidget(int index) {
    bool selected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        print("selectedIndex的下标为：$selectedIndex,index的下标为$index");
        selectedIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(top: 13, bottom: 13, right: 10),
        color:
            selected ? ColorConstant.color_ffffff : ColorConstant.color_eeeeee,
        child: Text(
          leftTypeList[index],
          textAlign: TextAlign.right,
          style: TextStyle(
              color: selected
                  ? ColorConstant.systemColor
                  : ColorConstant.color_333333,
              fontSize: 14),
        ),
      ),
    );
  }
}
