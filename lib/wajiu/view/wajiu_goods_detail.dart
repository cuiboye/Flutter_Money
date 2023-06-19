import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/view/wajiu_detail_appbar.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/wajiu/widget/wajiu_detail_banner_indicator.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WajiuGoodsDetail extends StatefulWidget {
  @override
  _WajiuGoodsDetailState createState() => _WajiuGoodsDetailState();
}

///对 PageView 里的 ListView 做 KeepAlive 记住位置
class KeepAliveListView extends StatefulWidget {
  final ScrollController? listScrollController;
  final int itemCount;

  ///头部区域高度
  double headerHeight = 264;

  ///头部区域偏离图片高度
  double headerRectMargin = 40;

  ///记录滚动距离
  double scrollPix = 0;

  KeepAliveListView(
      {required this.listScrollController,
      required this.itemCount,
      required this.scrollPix});

  @override
  KeepAliveListViewState createState() => KeepAliveListViewState();
}

class KeepAliveListViewState extends State<KeepAliveListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      controller: widget.listScrollController,

      ///屏蔽默认的滑动响应
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildHeader();
        } else if (index == 1) {
          return Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 13, right: 13),
                color: ColorConstant.systemColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/word_grab_new.png",
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            "images/limit_time.png",
                            height: 15,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "剩余抢购时间:",
                          style: TextStyle(
                              color: ColorConstant.color_ffffff, fontSize: 10),
                        ),
                        Text(
                          "12天",
                          style: TextStyle(
                              color: ColorConstant.color_ffffff, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13, right: 13),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(right: 15),
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1,
                                color: ColorConstant.color_eeeeee)), //边框
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "侯赛城堡干红",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.color_3a3a3a),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "CH PINET LA HOUSSAIE",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorConstant.color_3a3a3a),
                            ),
                          )
                        ],
                      ),
                    )),
                    Column(
                      children: [
                        Image.asset(
                          "images/wajiu_detail_collect.png",
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          "收藏",
                          style: TextStyle(
                              fontSize: 14, color: ColorConstant.color_888888),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (index == 2) {
          return Column(
            children: [
              Container(
                color: ColorConstant.color_eeeeee,
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 13),
                color: ColorConstant.color_ffffff,
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //每一行3个
                      childAspectRatio: 3.5 //宽高比为3.5
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.color_ffffff,
                          border: Border.all(
                              width: 1, color: ColorConstant.color_eeeeee),
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.0)) //边框圆角
                      ),
                      margin: EdgeInsets.only(right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("样品",style: TextStyle(fontSize: 14),), Container(margin:EdgeInsets.only(left: 13),child: Text("¥ 48.00/瓶",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),)],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4,right: 13),
                      decoration: BoxDecoration(
                          color: ColorConstant.color_ffffff,
                          border: Border.all(
                              width: 1, color: ColorConstant.color_eeeeee),
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.0)) //边框圆角
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("样品",style: TextStyle(fontSize: 14),), Container(margin:EdgeInsets.only(left: 13),child: Text("¥ 48.00/瓶",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),)],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: ColorConstant.color_eeeeee,
                height: 8,
              ),
              Container(
                height: 44,
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text("提示",style: TextStyle(color: ColorConstant.color_bababa,fontSize: 13),),
                        ),
                        Text("立即发货",style: TextStyle(color: ColorConstant.color_c343434,fontSize: 13),)
                      ],
                    ),
                  ],
                ),
              ),
              LineView(),
              Container(
                height: 44,
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text("库存",style: TextStyle(color: ColorConstant.color_bababa,fontSize: 13),),
                        ),
                        Text("充足",style: TextStyle(color: ColorConstant.color_c343434,fontSize: 13),)
                      ],
                    ),
                  ],
                ),
              ),
              LineView(),
              Container(
                height: 44,
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text("送至",style: TextStyle(color: ColorConstant.color_bababa,fontSize: 13),),
                        ),
                        Expanded(child: Text("北京 市辖区 东城区",style: TextStyle(color: ColorConstant.color_c343434,fontSize: 13),)),
                        Container(
                          height: 44,
                          padding: EdgeInsets.only(right: 13,left: 13),
                          child: Image.asset(
                            "images/wajiu_detail_white_more.png",
                            width: 20,
                            height: 20,
                            color: ColorConstant.color_7a7a7a,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              LineView(),
              Container(
                height: 44,
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text("仓库",style: TextStyle(color: ColorConstant.color_bababa,fontSize: 13),),
                        ),
                        Expanded(child: Text("上海仓发货",style: TextStyle(color: ColorConstant.color_c343434,fontSize: 13),)),
                        Container(
                          height: 44,
                          padding: EdgeInsets.only(right: 13,left: 13),
                          child: Image.asset(
                            "images/wajiu_detail_white_more.png",
                            width: 20,
                            height: 20,
                            color: ColorConstant.color_7a7a7a,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              LineView(color: ColorConstant.color_eeeeee,line_height: 8,),
              Container(
                margin: EdgeInsets.only(left: 13),
                alignment: Alignment.centerLeft,
                height: 44,
                child: Text("基本信息",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: ColorConstant.color_c343434),),
              ),
              _baseInfoItem("容量","750ML"),
              _baseInfoItem("采摘年份","2019"),
              _baseInfoItem("葡萄","酒精"),
              _baseInfoItem("酒精","13.5%"),
              _baseInfoItem("类型","干红"),
            ],
          );
        }
        return Container(
          padding: EdgeInsets.only(top: 18, bottom: 16),
          color: ColorConstant.color_ebebeb,
          child: Column(
            children: [
              Image.asset("images/detail_shanghua.png", width: 15, height: 15),
              Text(
                "继续上滑查看图文详情",
                style:
                    TextStyle(color: ColorConstant.color_7a7a7a, fontSize: 12),
              )
            ],
          ),
        );
      },
      itemCount: 4,
    );
  }

  Widget _baseInfoItem(String leftText, String rightText) {
    return Column(
      children: [
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      "$leftText",
                      style: TextStyle(
                          color: ColorConstant.color_bababa, fontSize: 13),
                    ),
                  ),
                  Text(
                    "$rightText",
                    style: TextStyle(
                        color: ColorConstant.color_c343434, fontSize: 13),
                  )
                ],
              ),
            ],
          ),
        ),
        LineView(),
      ],
    );
  }

  ///头部区域
  _buildHeader() {
    ///状态栏高度
    double statusBarHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

    ///头部区域去除marin、appbar、状态栏之后的高度
    double dynamicValue = widget.headerHeight -
        widget.headerRectMargin -
        kToolbarHeight -
        statusBarHeight;

    ///计算 margin 的撑开动画效果，用于视觉偏差
    ///计算停靠 item 的显示标志 showStickItem
    double marginEdge = 0;
    if (widget.scrollPix >= dynamicValue) {
      marginEdge = 10 - (widget.scrollPix - dynamicValue);
      marginEdge = math.max(0, marginEdge);
      // if (marginEdge == 0) {
      //   showStickItem = true;
      // } else {
      //   showStickItem = false;
      // }
    } else {
      marginEdge = 10;
      // showStickItem = false;
    }

    return Container(
      color: ColorConstant.color_ffffff,
      height: widget.headerHeight,
      width: double.infinity,
      // child: Swiper(
      //   itemCount: 5,
      //   autoplay: true, //是否自动轮播
      //   pagination: SwiperPagination(
      //       alignment: Alignment.bottomCenter,
      //       builder: SwiperCustomPagination(
      //           builder: (BuildContext context, SwiperPluginConfig config) {
      //         return NLIndicator(config.activeIndex, 5);
      //       })), //指示器
      //   itemBuilder: (BuildContext context, int index) {
      //     return Image.asset(
      //       "images/wajiu_detail_test_pic.jpeg",
      //       fit: BoxFit.fitHeight,
      //     );
      //   },
      // ),
      child: Text("轮播图"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _WajiuGoodsDetailState extends State<WajiuGoodsDetail> {
  PageController? _pageController;
  ScrollController? _listScrollController;
  ScrollController? _activeScrollController;
  Drag? _drag;

  ///AppBar 的背景色透明度
  int appBarColorAlpha = 0;

  ///记录滚动距离
  double scrollPix = 0;

  ///是否需要显示停靠
  bool showStickItem = false;

  ///头部区域高度
  double headerHeight = 264;

  ///头部区域偏离图片高度
  double headerRectMargin = 40;

  ///头部信息框高度
  double headerRectHeight = 60;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _listScrollController?.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    print("_handleDragStart");
    ///先判断 Listview 是否可见或者可以调用
    ///一般不可见时 hasClients false ，因为 PageView 也没有 keepAlive
    if (_listScrollController?.hasClients == true &&
        _listScrollController?.position.context.storageContext != null) {
      ///获取 ListView 的  renderBox
      final RenderBox? renderBox = _listScrollController?.position.context.storageContext.findRenderObject() as RenderBox;

      ///判断触摸的位置是否在 ListView 内
      ///不在范围内一般是因为 ListView 已经滑动上去了，坐标位置和触摸位置不一致
      if (renderBox?.paintBounds
              .shift(renderBox.localToGlobal(Offset.zero))
              .contains(details.globalPosition) ==
          true) {
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController?.position.drag(details, _disposeDrag);
        return;
      }
    }

    ///这时候就可以认为是 PageView 需要滑动
    _activeScrollController = _pageController;
    print("position的值为：${ _pageController?.position}");

    _drag = _pageController?.position.drag(details, _disposeDrag);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    print("_handleDragUpdate");

    if (_activeScrollController == _listScrollController &&

        ///手指向上移动，也就是快要显示出底部 PageView
        details.primaryDelta! < 0 &&

        ///到了底部，切换到 PageView
        _activeScrollController?.position.pixels ==
            _activeScrollController?.position.maxScrollExtent) {
      print("_handleDragUpdate1");

      ///切换相应的控制器
      _activeScrollController = _pageController;
      _drag?.cancel();

      ///参考  Scrollable 里的，
      ///因为是切换控制器，也就是要更新 Drag
      ///拖拽流程要切换到 PageView 里，所以需要  DragStartDetails
      ///所以需要把 DragUpdateDetails 变成 DragStartDetails
      ///提取出 PageView 里的 Drag 相应 details
      _drag = _pageController?.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    print("_handleDragUpdate2");

    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    print("_handleDragEnd");

    _drag?.end(details);
  }

  void _handleDragCancel() {
    print("_handleDragCancel");

    _drag?.cancel();
  }

  ///拖拽结束了，释放  _drag
  void _disposeDrag() {
    _drag = null;
  }

  ///处理滑动监听
  _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    scrollPix = notification.metrics.pixels;
    var curAlpha = 0;
    if (notification.metrics.pixels <= 0) {
      curAlpha = 0;
    } else {
      curAlpha = ((notification.metrics.pixels / 180) * 255).toInt();
      if (curAlpha > 255) {
        curAlpha = 255;
      }
    }
    setState(() {
      print("$curAlpha");
      appBarColorAlpha = curAlpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          body: RawGestureDetector(
            gestures: <Type, GestureRecognizerFactory>{
              VerticalDragGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                          VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                      (VerticalDragGestureRecognizer instance) {
                instance
                  ..onStart = _handleDragStart
                  ..onUpdate = _handleDragUpdate
                  ..onEnd = _handleDragEnd
                  ..onCancel = _handleDragCancel;
              })
            },
            behavior: HitTestBehavior.opaque,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,

              ///去掉 Android 上默认的边缘拖拽效果
              scrollBehavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),

              ///屏蔽默认的滑动响应
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ScrollConfiguration(
                  ///去掉 Android 上默认的边缘拖拽效果
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(overscroll: false),

                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      //notification.depth表示监听的是ListView这一层，因为ListView嵌套PageView，所以PageView属于notification.depth == 1
                      if (notification is ScrollUpdateNotification &&
                          notification.depth == 0) {
                        _handleScrollUpdateNotification(notification);
                      }
                      return false;
                    },
                    //KeepAliveListView：保持ListView状态
                    child: KeepAliveListView(
                      listScrollController: _listScrollController,
                      itemCount: 30,
                      scrollPix: scrollPix,
                    ),
                  ),
                ),
                //这里还有问题，因为是自定义的手势，这个WebView滑动有问题

                WebView(
                  initialUrl: getAssetsPath("assets/files/good_detail.html"),
                  //JS执行模式 是否允许JS执行
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebResourceError: (WebResourceError error){
                    print("${error.description}");
                  },
                  onPageFinished: (String url){
                    print("$url");
                  },
                  onWebViewCreated: (WebViewController controller){
                    print("加载完成");
                  },
                )
              ],
            ),
          ),
          appBar: WajiuDetailAppBar(
              context: context, title: "dsfdsfds", alphaBg: appBarColorAlpha)),
    );
  }
  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }
}
