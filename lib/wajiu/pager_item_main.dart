import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/honor_demo_page.dart';
import 'package:flutter_money/layout/container_widget.dart';
import 'package:flutter_money/utils/dialog_utils.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/log_utils.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/app_strings.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/main_page_tabbarview.dart';
import 'package:flutter_money/wajiu/main_tabview.dart';
import 'package:flutter_money/wajiu/model/common_request_model.dart';
import 'package:flutter_money/wajiu/model/home_main_model.dart';
import 'package:flutter_money/wajiu/model/home_productlist_model.dart';
import 'package:flutter_money/wajiu/model/product_list_model.dart';
import 'package:flutter_money/wajiu/order_list_item_main.dart';
import 'package:flutter_money/wajiu/order_list_page.dart';
import 'package:flutter_money/wajiu/page_mingzhuangxianhuo.dart';
import 'package:flutter_money/wajiu/view/mingzhuangxianhuo_list_page.dart';
import 'package:flutter_money/wajiu/view/vp_list_demo_page.dart';
import 'package:flutter_money/wajiu/view/wajiu_goods_detail.dart';
import 'package:flutter_money/wajiu/widget/marquee_widget.dart';
import 'package:flutter_money/wajiu/widget/wajiu_detail_banner_indicator.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/net_image_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 挖酒-主页
 */
class PageItemMain extends StatefulWidget {
  @override
  _PageItemMainState createState() => _PageItemMainState();
  final String? info;

  PageItemMain({this.info});
}

class _PageItemMainState extends State<
        PageItemMain> // with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {
  //
  @override
  bool get wantKeepAlive => true; //保持页面状态
  List<AppNewIndexCategories?> appNewIndexCategories = []; //轮播图数据
  List<AppNewIndexCategories?> checkerboardAppNewIndexCategories = []; //棋盘格数据
  List<AppNewIndexCategories?> announcementAppNewIndexCategories = []; //快报
  String rankPictureUrl = "";
  String newpinShoufaPictureUrl = "";
  String mingzhuangxianhuoPictureUrl = "";
  String hotSellingRecommendationPictureUrl = "";
  var checkerboardImageList = []; //棋盘格图片数据
  var checkerboardImageList2 = []; //棋盘格图片数据
  List<BannerInternational?> countryList = []; //国家馆数据
  List<BrandHall?> brandHallList = []; //国家馆数据
  List<NewProductPriorities?> newProductPriorities = []; //新品优先抢
  List<WorldHotProducts?> worldHotProductsList = []; //全球热卖
  List<KindSetList?> kindSetList = []; //tab标签数据
  String wsetIconUrl = "";
  int mCurrentPageNum = 0;
  bool showScrollToTop = false; //请求数据结束后，再设置轮播图自动滚动
  int _select = 0; //选中tab小标
  //快报
  List<String> loopList = [
    "小挖新闻社-2023年3月葡萄酒行业新资讯",
    "新·奇·特“猎奇之旅”葡萄酒大师班重磅来袭！",
    "春糖囤货季，8千万优惠！快来薅!"
  ];
  bool hasData = true; //下拉加载，是否还有数据
  late ScrollController scrollController;
  bool requestDataSuccess = false;
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("=======>>>didChangeDependencies");

}
  // late TabController _tabController;
  @override
  void initState() {
    super.initState();
    print("=======>>>initState");
    //initialScrollOffset：滚动初始位置
    scrollController = ScrollController(initialScrollOffset: 0);
    scrollController.addListener(() {
      double offset = scrollController.offset;
      if (offset > 400) {
        showScrollToTop = true;
      } else {
        showScrollToTop = false;
      }
      //不在这里处理显示和隐藏"回到顶部"的处理，这样处理只要页面一滑动，就会触发setState
      // setState(() {
      //   //更新回到顶部的图标的状态
      // });
    });
    // imageList = _getBannerDatas();
    checkerboardImageList = getCheckerboardImageList();
    checkerboardImageList2 = getCheckerboardImageList2();
    // countryList = getCountryList();

    requestData(true);
  }

  void requestData(bool refresh) {
    getLoginToken().then((token) {
      _getProductListData(refresh, token ?? "");
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    requestData(true);
    print("_onRefresh");
    // if failed,use refreshFailed()
    if (mounted) setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    loadMoreData();
    print("_onLoading");
    if (mounted) setState(() {});
  }

  void loadMoreData() {
    getLoginToken().then((token) {
      _getIndexApp(token ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //获取安全区域
    final padding = MediaQuery.of(context).padding;
    print("=======>>>build");
    return Stack(
      children: [
        Container(
          color: ColorConstant.color_eeeeee,
          child: Column(
            children: [
              Container(
                //这是一个假的状态栏
                decoration: BoxDecoration(color: Colors.red),
                height: padding.top,
              ),
              Container(
                color: ColorConstant.color_ef7134,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
                        margin: EdgeInsets.only(
                            left: 15, top: 10, bottom: 10, right: 15),
                        decoration: BoxDecoration(
                            color: ColorUtil.color("#bdffffff"),
                            //设置边框,也可以通过 Border()的构造方法 分别设置上下左右的边框
                            border: Border.all(width: 1, color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
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
                                      fontSize: 12,
                                      color: ColorUtil.color("#a3a2a2"))),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image.asset(
                          "images/home_customer_service.png",
                          width: 25,
                          height: 25,
                        )),
                    Padding(
                        padding: EdgeInsets.only(right: 13),
                        child: Image.asset(
                          "images/mine_news.png",
                          width: 25,
                          height: 25,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (hasData) {
                          if (mode == LoadStatus.idle) {
                            body = Text("上拉加载");
                            print("上拉加载");
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                            print("加载中");
                          } else if (mode == LoadStatus.failed) {
                            body = Text("加载失败！点击重试！");
                            print("加载失败！点击重试！");
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text("松手,加载更多!");
                            print("松手,加载更多!");
                          } else {
                            body = Text("没有更多数据了!");
                            print("没有更多数据了!");
                          }
                        } else {
                          body = Text("没有更多数据了!");
                          print("没有更多数据了!");
                        }

                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: _contentWidget()
                    // child: MainTabViewPage()),

                    ),
              )
            ],
          ),
        ),
        Positioned(
          child: Visibility(
              visible: showScrollToTop,
              child: GestureDetector(
                onTap: () {
                  // scrollController.animateTo(0, duration: Duration(milliseconds: 600), curve: Curves.linear);
                  scrollController.jumpTo(0);
                },
                child: Image.asset(
                  "images/scroll_to_top.png",
                  height: 45,
                ),
              )),
          bottom: 30,
          right: 30,
        )
      ],
    );
  }

  Widget _contentWidget() {
    // return CustomScrollView(
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
              padding: EdgeInsets.only(left: 13, right: 13),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorConstant.color_ef7134,
                        ColorConstant.color_f4f4f4
                      ])),
              height: MediaQuery.of(context).size.width / 2.5413,
              //根据具体情况来设置比例
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Swiper(
                  onTap: (index) {
                    ToastUtils.showToast("点击了第 ${index + 1}个");
                  },
                  itemCount:  appNewIndexCategories?.length??0,
                  autoplay: requestDataSuccess?true:false,
                  //是否自动轮播
                  pagination: SwiperPagination(
                    //指示器
                      margin: EdgeInsets.only(bottom: 5),
                      //在这里控制指示器距离底部的距离，默认距离是10
                      // alignment: Alignment.bottomCenter,//指示器的位置不在这里控制了，在NLIndicator中控制
                      builder: SwiperCustomPagination(builder:
                          (BuildContext context, SwiperPluginConfig config) {
                        return NLIndicator(
                            config.activeIndex, appNewIndexCategories?.length??0);
                      })),
                  itemBuilder: (BuildContext context, int index) {
                    // print("加载图片 ${appNewIndexCategories[index]?.picture ?? ""}");
                    return NetImageView(url:appNewIndexCategories[index]?.picture ?? "", boxFit: BoxFit.fill,);
                  },
                ),
              )),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: PageView(
              //这里PageView必须设置个高度，否则会报错，暂时没有解决办法
              scrollDirection: Axis.horizontal,
              children: [
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, //每行三列
                      childAspectRatio: 1, //显示区域宽高相等
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return _getGridViewData(index);
                    }),
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, //每行三列
                      childAspectRatio: 1, //显示区域宽高相等
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _getGridViewDataTwo(index);
                    }),
              ],
            ),
          ),
        ),

        //在实际布局中，我们通常需要往 CustomScrollView 中添加一些自定义的组件，而这些组件并非都
        //有 Sliver 版本，为此 Flutter 提供了一个 SliverToBoxAdapter 组件，它是一个适配器：可
        //以将 RenderBox 适配为 Sliver。
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 13, right: 13, top: 20),
                decoration: BoxDecoration(
                    color: ColorConstant.color_ffffff,
                    border: Border.all(
                        width: 1, color: ColorConstant.color_ffffff), //边框
                    borderRadius: BorderRadius.all(Radius.circular(8.0)) //边框圆角
                    ),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1,
                                color: ColorConstant.color_eeeeee)), //边框
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/app_home_dingdan_blue.png",
                            width: 18,
                            height: 18,
                          ),
                          Text("订单查询")
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 13, bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/app_index_chongzhi_new.png",
                            width: 18,
                            height: 18,
                          ),
                          Text("充值")
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          height: 40,
          margin: EdgeInsets.only(left: 13, right: 13, top: 8),
          decoration: BoxDecoration(
              color: ColorConstant.color_ffffff,
              border:
                  Border.all(width: 1, color: ColorConstant.color_ffffff), //边框
              borderRadius: BorderRadius.all(Radius.circular(8.0)) //边框圆角
              ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Image.asset(
                  "images/app_home_xiaowakuaibao.png",
                  height: 20,
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 20,
                child: MarqueeWidget(
                  //子Item构建器
                  itemBuilder: (BuildContext context, int index) {
                    if (!WajiuUtils.collectionIsSafe(
                        announcementAppNewIndexCategories, index)) {
                      return Text("");
                    }
                    String itemStr =
                        announcementAppNewIndexCategories[index]?.indexName ??
                            "";
                    //通常可以是一个 Text文本
                    return GestureDetector(
                      onTap: () {
                        ToastUtils.showToast("$itemStr");
                      },
                      child: Text(itemStr,
                          style: TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                  //循环的提示消息数量
                  count: announcementAppNewIndexCategories.length,
                  loopSeconds: 4, //每隔4秒轮播一次
                ),
              ))
            ],
          ),
        )),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 13, right: 13, top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("images/baokuanzhijiang.jpeg"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, right: 13, top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 4),
                      child: CacheImageView(
                        url: rankPictureUrl ?? "",
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: CacheImageView(
                            url: newpinShoufaPictureUrl ?? "",
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: CacheImageView(
                            url: hotSellingRecommendationPictureUrl ?? "",
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorConstant.color_ffe4d2,
                              ColorConstant.color_ffffff
                            ]),
                        color: ColorConstant.color_ffffff,
                        border: Border.all(
                            //边框
                            width: 1,
                            color: ColorConstant.color_ffffff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                        )),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 40, right: 40, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'images/app_home_guojiaguan_title_background.png'),
                            fit: BoxFit.fill, // 完全填充
                          ),
                        ),
                        child: Text(
                          "- 国家馆 -",
                          style: TextStyle(
                              color: ColorConstant.color_ffffff, fontSize: 14),
                        ),
                      ),
                    ])),
                Container(
                  margin: const EdgeInsets.only(left: 13, right: 13),
                  padding: const EdgeInsets.only(left: 10, top: 25, bottom: 25),
                  decoration: const BoxDecoration(
                      color: ColorConstant.color_ffffff,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      )),
                  child: SizedBox(
                      height: 60,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return countryItem(index);
                          },
                          itemCount: countryList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal)),
                )
              ],
            )
          ],
        )),

        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "新品优先抢",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ColorConstant.systemColor,
                          fontStyle: FontStyle.italic),
                    )),
                    GestureDetector(
                      onTap: () {
                        ToastUtils.showToast("更多");
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15, right: 13, left: 13, bottom: 13),
                        child: Row(
                          children: [
                            Text("更多",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.color_7b7b7b)),
                            Image.asset(
                              "images/right_arrow.png",
                              width: 15,
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstant.color_ffe4d2,
                          ColorConstant.color_ffffff
                        ])),
              ),
              Container(
                child: Container(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: newGoodItem(),
                  ),
                  margin: EdgeInsets.only(left: 13, right: 13),
                ),
                margin: EdgeInsets.only(left: 13, right: 13),
                decoration: BoxDecoration(
                  color: ColorConstant.color_ffffff,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorConstant.color_ffe4d2,
                            ColorConstant.color_ffffff
                          ]),
                      color: ColorConstant.color_ffffff,
                      border: Border.all(
                          //边框
                          width: 1,
                          color: ColorConstant.color_ffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                      )),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 40, right: 40, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'images/app_home_guojiaguan_title_background.png'),
                          fit: BoxFit.fill, // 完全填充
                        ),
                      ),
                      child: Text(
                        "- 品牌馆 -",
                        style: TextStyle(
                            color: ColorConstant.color_ffffff, fontSize: 14),
                      ),
                    ),
                  ])),
              Container(
                margin: const EdgeInsets.only(left: 13, right: 13),
                padding: const EdgeInsets.only(left: 10, top: 25, bottom: 25),
                decoration: const BoxDecoration(
                    color: ColorConstant.color_ffffff,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    )),
                child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return brandHallItem(index);
                        },
                        itemCount: brandHallList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal)),
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
            child: GestureDetector(
          onTap: () {
            GetNavigationUtils.navigateRightToLeft(MingzhuangxianhuoPage());
          },
          child: Container(
            padding: EdgeInsets.only(left: 13, right: 13, top: 8),
            child:
                CacheImageView(url: mingzhuangxianhuoPictureUrl, radius: 8.0),
          ),
        )),
        SliverToBoxAdapter(
          child: _getTarBarView(),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0.1,
                  )),
              Text("全球热卖"),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0.1,
                  )),
            ],
          ),
        )),
        SliverToBoxAdapter(
            child: Container(
          margin: EdgeInsets.only(left: 13, right: 13),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            // children: _hotListItem(),
            children: _hotListItem(),
          ),
        )),
      ],
    );
  }

  Widget _getTarBarView() {
    if (WajiuUtils.collectionIsEmpty(kindSetList) == true) {
      return Text("");
    }
    return MainPageTabbarview(kindSetList);
  }

  List<Widget> newGoodItem() {
    List<Widget> list = [];

    if (WajiuUtils.collectionIsEmpty(newProductPriorities) == true) {
      return list;
    }
    for (int index = 0; index < newProductPriorities.length; index++) {
      Widget widget = GestureDetector(
        onTap: () {
          ToastUtils.showToast("$index");
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.color_ffffff,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.color_ffffff,
                                  border: Border.all(
                                      width: 1, color: ColorConstant.color_eeeeee),
                                  //边框
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)) //边框圆角
                              ),
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 40),
                              margin: EdgeInsets.only(bottom: 8),
                              height: 200,
                              child: CacheImageView(
                                  url:
                                  "${newProductPriorities[index]?.productPic}?imageView2/2/w/740/h/314/q/100"),
                            )
                          ],
                        ),
                        Positioned(
                            bottom: 8,
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("images/time_icon.png",
                                      height: 16),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      newProductPriorities[index]
                                              ?.maturityDate ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.color_fb8a47),
                                    ),
                                  )
                                ],
                              ),
                              color: ColorConstant.color_fef1e8,
                              height: 20,
                            ))
                      ],
                    ),
                    Text(newProductPriorities[index]?.productName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, color: ColorConstant.color_343434)),
                    Container(
                        margin: EdgeInsets.only(top: 8, bottom: 10),
                        child: getNewProductPrioritiesPrice(index))
                  ],
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                height: 13,
                child: Image.asset("images/country_top_right.jpeg"),
              )
            ],
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  Widget getNewProductPrioritiesPrice(int index) {
    getLoginToken().then((value) {
      if (TextUtils.isEmpty(value)) {
        return Text(
          "登录查看价格",
          style: TextStyle(fontSize: 14, color: ColorConstant.systemColor),
        );
      } else {
        return Row(
          children: [
            Text(
              "¥",
              style: TextStyle(fontSize: 12, color: ColorConstant.systemColor),
            ),
            Text("${newProductPriorities[index]?.startPrice}",
                style:
                    TextStyle(fontSize: 14, color: ColorConstant.systemColor)),
            Text("~"),
            Text(
              "¥",
              style: TextStyle(fontSize: 12, color: ColorConstant.systemColor),
            ),
            Text("${newProductPriorities[index]?.endPrice}",
                style:
                    TextStyle(fontSize: 14, color: ColorConstant.systemColor))
          ],
        );
      }
    });
    return Text(
      "登录查看价格",
      style: TextStyle(fontSize: 14, color: ColorConstant.systemColor),
    );
  }

  Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loginToken = prefs.getString(Constant.LOGIN_TOKEN);
    return loginToken;
  }

  Widget countryItem(int index) {
    Widget child = CacheImageView(
      url: "${countryList[index]?.picture}?imageView2/2/w/740/h/314/q/100",
    );
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: child,
      ),
      onTap: () {
        GetNavigationUtils.navigateRightToLeft(WajiuGoodsDetail());
        // ToastUtils.showToast("${countryList[index]?.indexName}");
      },
    );
  }

  Widget brandHallItem(int index) {
    Widget child = CacheImageView(
      url:
          "${brandHallList[index]?.appPictrueAddress}?imageView2/2/w/740/h/314/q/100",
    );
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: child,
      ),
      onTap: () {
        ToastUtils.showToast("${brandHallList[index]?.appPictrueAddress}");
      },
    );
  }

  List<Widget> _hotListItem() {
    List<Widget> widgetList = [];
    if (WajiuUtils.collectionIsEmpty(worldHotProductsList) == true) {
      return widgetList;
    }
    for (int index = 0; index < worldHotProductsList.length; index++) {
      if (index == 1) {
        Widget widget = CacheImageView(
            url:
                "${worldHotProductsList[index]?.picture}?imageView2/2/w/740/h/314/q/100");
        widgetList.add(widget);
      } else {
        Widget widget = GestureDetector(
          onTap: () =>
              {GetNavigationUtils.navigateRightToLeft(WajiuGoodsDetail())},
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.color_ffffff,
                border: Border.all(width: 1, color: ColorConstant.color_ffffff),
                borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            child: Column(
              children: [
                CacheImageView(
                  url: worldHotProductsList[index]?.picture ?? "",
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '${worldHotProductsList[index]?.cname ?? ""}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: double.infinity,
                      child: Text(
                          worldHotProductsList[index]?.countryName ?? "",
                          style: TextStyle(
                              color: ColorConstant.color_a4a5a7, fontSize: 11)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "¥",
                            style: TextStyle(
                                fontSize: 11, color: ColorConstant.systemColor),
                          ),
                          Text(
                            "${worldHotProductsList[index]?.jnPrice ?? 0.0}",
                            style: TextStyle(
                                fontSize: 16, color: ColorConstant.systemColor),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
        widgetList.add(widget);
      }
    }
    print("${widgetList.length}===========>");

    return widgetList;
  }

  List<String> getCheckerboardImageList() {
    var imageList = [
      './images/checkerboard_image1.png',
      './images/checkerboard_image2.png',
      './images/checkerboard_image3.png',
      './images/checkerboard_image4.png',
      './images/checkerboard_image5.png',
      './images/checkerboard_image6.png',
      './images/checkerboard_image7.png',
      './images/checkerboard_image8.png',
    ];
    return imageList;
  }

  List<String> getCheckerboardImageList2() {
    var imageList = [
      './images/checkerboard_image9.png',
      './images/checkerboard_image10.png',
      './images/checkerboard_image11.png',
      './images/checkerboard_image12.png',
      './images/checkerboard_image13.png',
      './images/checkerboard_image14.png',
    ];
    return imageList;
  }

  List<String> getCountryList() {
    var imageList = [
      './images/country_item1.png',
      './images/country_item2.png',
      './images/country_item3.png',
      './images/country_item4.png',
      './images/country_item5.png',
      './images/country_item6.png',
      './images/country_item7.png',
    ];
    return imageList;
  }

  @override
  void didUpdateWidget(covariant PageItemMain oldWidget) {
    print("============>>didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("============>>deactivate");
    super.deactivate();
  }

  Widget _getGridViewDataTwo(int index) {
    return GestureDetector(
      onTap: () {
        ToastUtils.showToast(
            "${checkerboardAppNewIndexCategories[index + 8]?.indexName}");
      },
      child: Column(children: [
        Container(
          child: NetImageView(url:
            "${checkerboardAppNewIndexCategories[index + 8]?.picture}?imageView2/2/w/740/h/314/q/100",
            width: 55,
          ),
        ),
        Text("${checkerboardAppNewIndexCategories[index + 8]?.indexName ?? ""}")
      ]),
    );
  }

  Widget _getGridViewData(int index) {
    if (WajiuUtils.collectionIsEmpty(checkerboardAppNewIndexCategories) ==
        true) {
      return Text("");
    }
    return GestureDetector(
      onTap: () {
        ToastUtils.showToast(
            "${checkerboardAppNewIndexCategories[index]?.indexName}");
      },
      child: Column(children: [
        Container(
          child: NetImageView(url:
            "${checkerboardAppNewIndexCategories[index]?.picture}?imageView2/2/w/740/h/314/q/100",
            width: 55,
          ),
        ),
        Text("${checkerboardAppNewIndexCategories[index]?.indexName ?? ""}")
      ]),
    );
  }

  //从接口获取数据
  void _getProductListData(bool isOnRefresh, String token) {
    print("请求接口了");
    var params = Map<String, dynamic>();
    if (isOnRefresh) {
      worldHotProductsList.clear();
      mCurrentPageNum = 0;
    } else {
      mCurrentPageNum++;
    }

    if (!TextUtils.isEmpty(token)) {
      params["req_token"] = Uri.encodeComponent(token);
      print("首页数据的token:=====》》》${Uri.encodeComponent(token)}");
    }
    DioInstance.getInstance().get(ApiService.indexApp, params,
        success: (resultData) {
      //注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //通知下，刷新成功
      if (isOnRefresh) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
      HomeMainModel model = HomeMainModel.fromJson(resultData);
      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          //初始化轮播图数据
          appNewIndexCategories =
              model.result?.indexList?.focusPicture?.appNewIndexCategories ??
                  [];
          //初始化棋盘格数据
          checkerboardAppNewIndexCategories =
              model.result?.indexList?.homeButton?.appNewIndexCategories ?? [];
          //快报
          announcementAppNewIndexCategories =
              model.result?.indexList?.announcement.appNewIndexCategories ?? [];
          //排行榜，新品首发，新品推荐
          rankPictureUrl =
              "${model.result?.advertising?.ranking?.picture}?imageView2/2/w/740/h/314/q/100";
          newpinShoufaPictureUrl =
              "${model.result?.advertising?.advertising_0?.picture}?imageView2/2/w/740/h/314/q/100";
          hotSellingRecommendationPictureUrl =
              "${model.result?.advertising?.hotSellingRecommendation}?imageView2/2/w/740/h/314/q/100";
          //名庄现货
          mingzhuangxianhuoPictureUrl =
              "${model.result?.advertising?.advertising_1?.picture ?? ""}?imageView2/2/w/740/h/314/q/100";
          //国家馆
          countryList = model.result?.banner_international ?? [];
          //品牌馆
          brandHallList = model.result?.brandHall ?? [];
          //新品优先抢
          newProductPriorities = model.result?.newProduct_priorities ?? [];
          //全球热卖
          worldHotProductsList = model.result?.worldHotProducts ?? [];
          LogUtil.v('worldHotProductsList数据为：:${worldHotProductsList.length}');

          wsetIconUrl = "${model.result?.wsetIcon ?? ""}";
          if (!TextUtils.isEmpty(wsetIconUrl)) {
            Map<String, dynamic> srcJson = {
              "picture": "$wsetIconUrl",
              "jnPrice": 0.0
            };
            worldHotProductsList.insert(1, WorldHotProducts.fromJson(srcJson));
          }

          String jsonStr = jsonEncode(worldHotProductsList);
          LogUtil.init(title: "来自LogUtil", isDebug: true, limitLength: 100);
          LogUtil.v('worldHotProductsList数据为：:$jsonStr');

          //tab数据
          kindSetList = model.result?.kindSet ?? [];

          // _tabController = TabController(vsync: this, length: kindSetList.length);
          // _tabController.addListener(() {
          //   setState(() {
          //     _select = _tabController.index;
          //   });
          // });
          setState(() {
            requestDataSuccess = true;
            print("===============>请求数据结束！");
          });
        }
      } else {
        //通知下，刷新失败
        if (isOnRefresh) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      }
    }, fail: (reason, code) {
      if (isOnRefresh) {
        _refreshController.refreshFailed();
      } else {
        _refreshController.loadFailed();
      }
    });
  }

  //全球热卖 加载更多
  void _getIndexApp(String token) {
    print("请求接口了");
    var params = Map<String, dynamic>();
    mCurrentPageNum++;

    if (!TextUtils.isEmpty(token)) {
      params["req_token"] = Uri.encodeComponent(token);
    }
    params["pageId"] = mCurrentPageNum;
    DioInstance.getInstance().get(ApiService.indexAppProduct, params,
        success: (resultData) {
      HomeProductListModel model = HomeProductListModel.fromJson(resultData);
      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          print("status == 200");
          if (null != model.result) {
            setState(() {
              hasData =
                  (model.result?.productList?.length ?? 0) < 10 ? false : true;
              List<HotWorldProductList?>? productList =
                  model?.result?.productList ?? [];
              if (WajiuUtils.collectionIsEmpty(productList) == false) {
                for (int i = 0; i < productList.length; i++) {
                  if (!WajiuUtils.collectionIsSafe(productList, i)) {
                    continue;
                  }
                  HotWorldProductList? hotWorldProductListBean = productList[i];

                  Map<String, dynamic> worldHostProductBeanJson = {};
                  worldHostProductBeanJson['jnPrice'] =
                      hotWorldProductListBean?.jnPrice ?? 0.0;
                  //?imageView2/2/w/740/h/314/q/100   这个是取压缩后的七牛云图片
                  worldHostProductBeanJson['picture'] =
                      "${hotWorldProductListBean?.picture}?imageView2/2/w/740/h/314/q/100";
                  worldHostProductBeanJson['cname'] =
                      hotWorldProductListBean?.cname;
                  worldHostProductBeanJson['countryName'] =
                      hotWorldProductListBean?.countryName;

                  WorldHotProducts? worldHostProductBean =
                      WorldHotProducts.fromJson(worldHostProductBeanJson);
                  worldHotProductsList.add(worldHostProductBean);
                  print(
                      "worldHotProductsList的数据为${jsonEncode(worldHotProductsList)}");
                }
              }
              _refreshController.loadComplete();
              setState(() {});
              print("数组的长度为：${worldHotProductsList.length}");
            });
          }
        }
      } else {
        //通知下，刷新失败
        _refreshController.loadFailed();
      }
    }, fail: (reason, code) {
      _refreshController.loadFailed();
    });
  }

  //加入采购车
  void _addGoodToShopCar(int index) {
    // var params = Map<String, dynamic>();
    // params["productID"] = worldHotProductsList[index].productid;
    // params["cangkuId"] = listData[index].cangkuId;
    // params["productName"] = listData[index].productName;
    // params["joinToShopCar"] = 1;
    // DioInstance.getInstance().get(ApiService.addGoodToShopCar, params,
    //     success: (json) {
    //   //注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
    //   print("获取到的数据：$json");
    //   // var result = json.decode(utf8decoder.convert(response.bodyBytes));
    //   print("获取到的数据_toLogin：$json");
    //   CommonRequestModel model = CommonRequestModel.fromJson(json);
    //   if (null != model) {
    //     int status = model.states;
    //     String msg = model.msg;
    //     if (status == 200) {
    //       ToastUtils.showToast(msg);
    //     }
    //   }
    //   print("获取到的数据：$model");
    // }, fail: (reason, code) {
    //   print("获取到的数据：$reason");
    // });
  }
}

class _SliverTabBarViewDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarViewDelegate({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: child,
      elevation: 200,
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
