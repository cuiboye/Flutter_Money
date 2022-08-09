
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:get/get.dart';

///自定义标题栏
class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  Color? navigationBarBackgroundColor; //设置导航栏背景的颜色
  bool? leadingWidget;
  String? trailingWidget;
  String? title;
  bool showLeftArrow; //是否展示返回键
  String? leftText; //左侧文字
  String? rightImage; //左侧图标
  BuildContext context;
  final callback;//左侧文字和图标点击回调事件

  CustomAppbar({
    this.leadingWidget,
    this.title,
    this.contentHeight = 44,
    this.showLeftArrow = true,
    this.leftText,
    this.rightImage,
    this.callback,
    required this.context,
    this.navigationBarBackgroundColor,
    this.trailingWidget,
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

/// 这里没有直接用SafeArea，而是用Container包装了一层
/// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
/// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtil.color("#f56e1d"),
      //afeArea通过MediaQuery来检测屏幕尺寸，使应用程序的大小能与屏幕适配。
      //然后返回了一个Padding Widget 来包裹住我们编写的页面。这样我们的页面就不会被异形屏幕给遮挡住了。
      child: SafeArea(//安全区域
        top: true,
        child: Container(
            decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: Color(0x00000000)),
            ),
            height: widget.contentHeight,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            // Navigator.pop(widget.context);
                          },
                          child: widget.showLeftArrow == true
                              ? Image.asset("images/back_icon_white.png",width: 20,height: 20,)
                              : Text(''),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: widget.leftText == null
                              ? Text('')
                              : Text(
                                  widget.leftText??"",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: widget.title == null
                      ? Text('')
                      : Text(widget.title??"",
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              widget.callback();
                            },
                            child: Text(
                              widget.trailingWidget ?? "",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                widget.callback();
                              },
                              child: widget.rightImage == null
                                  ? Text('')
                                  : Image(
                                      height: 20,
                                      width: 20,
                                      image: AssetImage(widget.rightImage??""),
                                    )),
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
