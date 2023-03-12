import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:get/get.dart';

/**
 * 自定义挖酒详情页appbar,根据滚动来改变标题栏的效果
 */
class WajiuDetailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  Color? navigationBarBackgroundColor; //设置导航栏背景的颜色
  bool? leadingWidget;
  String? rightText;
  String? title;
  bool showLeftArrow; //是否展示返回键
  String? leftText; //左侧文字
  String? rightImage; //左侧图标
  BuildContext context;
  int alphaBg; //alpha值
  final callback; //左侧文字和图标点击回调事件

  WajiuDetailAppBar({
    this.leadingWidget,
    this.alphaBg = 0, //这里不给个默认值会报错
    this.title,
    this.contentHeight = 44,
    this.showLeftArrow = true,
    this.leftText,
    this.rightImage,
    this.callback,
    required this.context,
    this.navigationBarBackgroundColor,
    this.rightText,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //全局设置透明
        statusBarIconBrightness: Brightness.light
        //light:黑色图标 dark：白色图标
        //在此处设置statusBarIconBrightness为全局设置
        );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return _CustomAppbarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}

class _CustomAppbarState extends State<WajiuDetailAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int alphtValue = widget.alphaBg;
    var color = Theme.of(context).primaryColor.withAlpha(alphtValue);

    return Container(
      color: color,
      child: SafeArea(
        //安全区域
        top: true,
        child: Container(
            decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: Color(0x00000000)),
            ),
            height: widget.contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 16),
                    child: alphtValue == 0
                        ? Image.asset(
                            "images/wajiu_detail_gray_back.png",
                            width: 30,
                            height: 30,
                          )
                        : Image.asset(
                            "images/back_icon_white.png",
                            width: 20,
                            height: 20,
                          )),
                Row(
                  children: [
                    alphtValue == 0
                        ? Image.asset(
                            "images/wajiu_detail_pic_gray.png",
                            width: 30,
                            height: 30,
                          )
                        : Image.asset(
                            "images/wajiu_detail_pic_white.png",
                            color: ColorConstant.color_ffffff,
                            width: 20,
                            height: 20,
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 13, right: 15),
                      child: alphtValue == 0
                          ? Image.asset(
                              "images/wajiu_detail_gray_more.png",
                              width: 30,
                              height: 30,
                            )
                          : Image.asset(
                              "images/wajiu_detail_white_more.png",
                              width: 20,
                              height: 20,
                              color: ColorConstant.color_ffffff,
                            ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
