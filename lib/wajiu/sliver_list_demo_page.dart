import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as W;
import 'package:flutter/rendering.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/view/over_scroll_behavior.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/common_request_model.dart';
import 'package:flutter_money/wajiu/model/joined_product_list_model.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/net_image_utils.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/**
 * 这个是不隐藏标题，只是停靠的demo
 */
class SliverListDemoPage extends StatefulWidget {
  @override
  _SliverListDemoPageState createState() => _SliverListDemoPageState();
}

class _SliverListDemoPageState extends State<SliverListDemoPage>
    with SingleTickerProviderStateMixin {
  int listCount = 30;
  String currentAddress = "";
  bool selected = false;
  List<ShopcarList?> mShopcarList = [];

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      ///头部信息,这个组件可以自由伸缩，可以放开这个运行看看
      // SliverPersistentHeader(
      //   delegate: GSYSliverHeaderDelegate(
      //       maxHeight: 150,
      //       minHeight: 50,
      //       vSync: this,
      //       snapConfig: FloatingHeaderSnapConfiguration(
      //         curve: Curves.bounceInOut,
      //         duration: const Duration(milliseconds: 10),
      //       ),
      //       // child: Container(
      //       //     child: Image.asset(
      //       //   "images/main_page_banner1.jpeg",
      //       //   fit: BoxFit.fill,
      //       // )),
      //       child: Column(
      //         children: [
      //           Expanded(
      //               child: ScrollConfiguration(
      //             behavior: OverScrollBehavior(), //去除水波纹
      //             child: ListView.separated(
      //               itemBuilder: (BuildContext context, int index) =>
      //                   activityItemWidget(index),
      //               itemCount: 5,
      //               shrinkWrap: true,
      //               separatorBuilder: (BuildContext context, int index) {
      //                 return LineView(
      //                     color: ColorConstant.color_d8d8d8, line_height: 0.5);
      //               },
      //             ),
      //           )),
      //           LineView(
      //             line_height: 3,
      //             color: ColorConstant.color_eeeeee,
      //           )
      //         ],
      //       )),
      // ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            Container(

              padding: EdgeInsets.only(top: 8, bottom: 10),
              child: StaggeredGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  activityItemWidget(0),
                  activityItemWidget(1),
                  activityItemWidget(2),
                  activityItemWidget(3),
                  activityItemWidget(4),
                ],
              ),
              color: ColorConstant.color_ffffff,
            ),
            Container(
              child: LineView(
                line_height: 3,
                color: ColorConstant.color_eeeeee,
              ),
            )
          ],
        ),
      ),
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverPersistentHeader(
          pinned: true,

          /// SliverPersistentHeaderDelegate 的实现
          delegate: GSYSliverHeaderDelegate(
              maxHeight: 90,
              minHeight: 90,
              changeSize: true,
              vSync: this,
              snapConfig: FloatingHeaderSnapConfiguration(
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 10),
              ),
              builder: (BuildContext context, double shrinkOffset,
                  bool overlapsContent) {
                ///根据数值计算偏差
                var lr = 10 - shrinkOffset / 61 * 10;
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () => _checkLocation(),
                        child: Container(
                          height: 44,
                          padding: EdgeInsets.only(left: 13, right: 13),
                          color: ColorConstant.color_ffffff,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //icon_address.png
                              Row(
                                children: [
                                  Image.asset(
                                    "images/icon_address.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                          TextUtils.isEmpty(currentAddress)
                                              ? "北京 市辖区 东城区"
                                              : currentAddress))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "更换",
                                    style: TextStyle(
                                        color: ColorUtil.color("#f56e1d"),
                                        fontSize: 13),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Image.asset(
                                      "images/icon_change_open.png",
                                      width: 15,
                                      height: 15,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    LineView(),
                    Container(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      color: ColorConstant.color_ffffff,
                      height: 44,
                      child: Row(
                        children: [
                          Image.asset(
                            "images/icon_attention_gray.png",
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "预计运费:10.00元,返金币:0.00枚",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: ColorConstant.color_343434,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    LineView(),
                  ],
                );
              }),
        ),
      ),
    ];
  }

  String initProvince = '四川省', initCity = '成都市', initTown = '双流区';

  Widget activityItemWidget(int index) {
    return Container(
      margin: EdgeInsets.only(left: 13, right: 13),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: ColorConstant.systemColor),
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
                child: Text(
                  "爆款直降",
                  style:
                      TextStyle(color: ColorConstant.systemColor, fontSize: 10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  "爆款直降活动",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          )),
          Container(
            child: Row(
              children: [
                Text("再逛逛",
                    style: TextStyle(
                        color: ColorConstant.systemColor, fontSize: 13)),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Image.asset(
                    "images/right_orange.png",
                    height: 10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _checkLocation() {
    Pickers.showAddressPicker(
      context,
      initProvince: initProvince,
      initCity: initCity,
      initTown: initTown,
      onConfirm: (p, c, t) {
        setState(() {
          currentAddress = "$p $c $t";
          initProvince = p;
          initCity = c;
          initTown = t!;
        });
      },
    );
  }

  List<String> fatherNameList = [
    "上海仓境内物流发货",
    "北京仓境内物流发货",
    "广州仓境内物流发货",
  ];
  List<bool> selectedList = [false, false, false];
  List<bool> childSelectedList = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.color_eeeeee,
        child: Column(
      children: [
        Expanded(
          child: NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            headerSliverBuilder: _sliverBuilder,
            body: CustomScrollView(
              slivers: [
                W.Builder(
                  builder: (context) {
                    return SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context));
                  },
                ),
                SliverToBoxAdapter(
                    //购物车列表
                    child: Container(
                      color: ColorConstant.color_ffffff,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mShopcarList.length,
                        itemBuilder: _itemBuilder,
                      ),
                    )),
                    //猜你喜欢列表
                    SliverToBoxAdapter(
                      child: Container(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: GuessLikeWidget(),
                        ),
                        margin: EdgeInsets.only(bottom: 30),
                      )
                    )


                //这个例子不适合PageView/TabbarView+TabBar的情况，只适合单个的ListView的情况
                // SliverFillRemaining(
                //   hasScrollBody: true,//hasScrollBody：包含可滚动组件
                //   child:  Container(
                //     child: PageView(
                //       children: [
                //         _pageView(),
                //         _pageView(),
                //       ],
                //     ),),
                // )

                  ],
                ),
              ),
        ),
        Column(
          children: [
            Divider(
              height: 1,
              color: ColorUtil.color("#cccccc"),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.only(left: 13),
              color: ColorUtil.color("#ffffff"),
              child: Row(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/shopping_cart_weixuanzhong.png",
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                      // Spacer(),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("全选", style: TextStyle(fontSize: 12))),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          //Column中的子View默认是居中的，左对齐需要设置crossAxisAlignment为start
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "合计:",
                                  style: TextStyle(
                                      color: ColorConstant.systemColor,
                                      fontSize: 12),
                                ),
                                Text(
                                  "¥:8348348.23",
                                  style: TextStyle(
                                      color: ColorConstant.systemColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text("优惠:0.00", style: TextStyle(fontSize: 12)),
                            Text("53箱", style: TextStyle(fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: ColorUtil.color("#f56e1d"),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "立即结算",
                                style:
                                    TextStyle(color: ColorUtil.color("ffffff")),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
  _pageView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text('List Item $index'),
          ),
        );
      },
    );
  }
  List<Widget> GuessLikeWidget(){
    List<Widget> widgetList = [];
    for(int i=0;i<30;i++){
      Widget widget = Container(
        decoration: BoxDecoration(
            color: ColorConstant.color_ffffff
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: CacheImageView(url: i==0?"error_image":"http://image.59cdn.com/static/upload/image/product/20170819/o_1503125726461.jpg",),
            ),
            Container(
              margin: EdgeInsets.only(left: 13,right: 13),
              child: Text("银狮干红",style: TextStyle(fontSize: 15,color: ColorConstant.color_343434),),
            ),
            Container(
              margin: EdgeInsets.only(left: 13,right: 13,top: 6),
              child: Text("Le Poi des Ailes",style: TextStyle(fontSize: 10,color: ColorConstant.color_343434),),
            ),
            Container(
              margin: EdgeInsets.only(left: 13,right: 13,top: 6),
              child: Row(
                children: [
                  Text("法国",style: TextStyle(fontSize: 12,color: ColorConstant.color_a4a5a7)),
                  Spacer(),
                  Text("欧盟餐酒VCE",style: TextStyle(fontSize: 12,color: ColorConstant.color_a4a5a7)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13,right: 13,top: 6,bottom: 10),
              child: Text("¥ 14.80",style: TextStyle(fontSize: 14,color: ColorConstant.systemColor),),
            ),
          ],
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        _listviewItem(index), //ListView的一级布局
        ListView.builder(
          //ListView的二级布局
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mShopcarList[index]?.productList?.length ?? 0,
          itemBuilder: (BuildContext context, int childIndex) {
            return Container(
                padding: EdgeInsets.only(left: 13, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            child: Image.asset(
                              mShopcarList[index]
                                          ?.productList![childIndex]
                                          ?.selected ==
                                      1
                                  ? "images/ic_radio_check.png"
                                  : "images/shopping_cart_weixuanzhong.png",
                              width: 20,
                              height: 20,
                            ),
                            height: 88,
                          ),
                          onTap: () =>
                              _changeChildProductRadioStates(index, childIndex),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 88,
                          width: 88,
                          child: Stack(
                            children: [
                              Image.network(
                                "http://image.59cdn.com/static/upload/image/product/20170819/o_1503125726461.jpg",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    color: ColorConstant.color_c7f565656,
                                    child: Center(
                                      child: Text(
                                        "预计3月中旬发货",
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: ColorConstant.color_ffffff),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                height: 88,
                                margin: EdgeInsets.only(left: 5, right: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${mShopcarList[index]?.productList![childIndex]?.productname}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "¥49.00/包",
                                          style: TextStyle(
                                              color: ColorConstant.systemColor),
                                        ),
                                        Spacer(),
                                        Text(
                                          "6提装",
                                          style: TextStyle(
                                              color: ColorConstant.color_a4a5a7,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "现货",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  ColorConstant.color_a4a5a7),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "images/shopping_cart_reduce2.png",
                                                height: 25,
                                              ),
                                              Container(
                                                  height: 25,
                                                  width: 40,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/shopping_cart_nummber_middle.png'),
                                                      fit: BoxFit.fill, // 完全填充
                                                    ),
                                                  ),
                                                  child: Text("1")),
                                              Image.asset(
                                                "images/shopping_cart_add2.png",
                                                height: 25,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ))),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration:
                          BoxDecoration(color: ColorConstant.color_eeeeee),
                    )
                  ],
                ));
          },
        ),
        Container(
          height: 4,
          decoration: BoxDecoration(color: ColorConstant.color_eeeeee),
        ),
      ],
    );
  }

  void _changeRadioStates(int index) {
    setState(() {
      selectedList[index] = !selectedList[index];
    });
  }

  void _changeChildProductRadioStates(int fatherIndex, int childIndex) {
    int? select = mShopcarList[fatherIndex]?.productList![childIndex]?.selected;

    _changeProductStatusRequest(fatherIndex, childIndex,
        mShopcarList[fatherIndex]?.productList![childIndex]?.productid, select);
  }

  //更改采购车商品选中状态
  void _changeProductStatusRequest(
      int fatherIndex, int childIndex, int? productid, int? select) {
    var params = Map<String, dynamic>();
    params["productId"] = productid;
    if (select == 0) {
      params["select"] = 1;
    } else if (select == 1) {
      params["select"] = 0;
    }
    DioInstance.getInstance().get(ApiService.changeProductSelectStatus, params,
        success: (resultData) {
      print("getShopCarData：$resultData");
      CommonRequestModel model = CommonRequestModel.fromJson(resultData);
      print("JoinedProductListModel：$model");

      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          mShopcarList[fatherIndex]?.productList![childIndex]?.selected =
              select == 0 ? 1 : 0;
          num size = 0;
          if (mShopcarList[fatherIndex]?.productList == null) {
            size = 0;
          } else {
            size = mShopcarList[fatherIndex]?.productList?.length as num;
          }

          //处理仓库按钮的选中状态
          bool totalSelected = true;
          for (int i = 0; i < size; i++) {
            if (mShopcarList[fatherIndex]?.productList![i]?.selected == 0) {
              //如果有1个没有被选中，那么就不是全选
              totalSelected = false;
              break;
            }
          }
          //设置父节点是否选中
          mShopcarList[fatherIndex]?.totalSelected = totalSelected;
          setState(() {});
        }
      }
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });
  }

  //设置仓库的按钮是否选中
  void setCangKuSelect(int fatherIndex) {}

  Widget _listviewItem(int index) {
    print("mShopcarList的数量${mShopcarList.length}");
    bool? productItemEmpty = mShopcarList[index]?.productList?.isEmpty;
    if (mShopcarList[index]?.fathername?.isEmpty == true ||
        mShopcarList[index]?.fathername == null) {
      print("index: $index,${mShopcarList[index]?.fathername}");
    } else {
      print("index: $index,${mShopcarList[index]?.fathername}");
    }
    return (mShopcarList[index] == null ||
            mShopcarList[index]?.fathername?.isEmpty == true ||
            mShopcarList[index]?.fathername == null)
        ? Offstage(child: Text(""), offstage: true)
        : Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        mShopcarList[index]?.totalSelected == true
                            ? "images/ic_radio_check.png"
                            : "images/shopping_cart_weixuanzhong.png",
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => _changeRadioStates(index),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("${mShopcarList[index]?.fathername}",
                            // child: Text("sdfdsf",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ))),
                  ],
                ),
              ),
            ],
          );
  }

  @override
  void initState() {
    super.initState();
    getShopCarData();
  }

  //获取购物车数据
  void getShopCarData() {
    var params = Map<String, dynamic>();
    DioInstance.getInstance().get(ApiService.getShopCarData, params,
        success: (resultData) {
      print("getShopCarData：$resultData");
      JoinedProductListModel model = JoinedProductListModel.fromJson(resultData);
      print("JoinedProductListModel：$model");

      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          if (null != model.result) {
            if (model.result.shopcarList.isEmpty) {
              mShopcarList = [];
            } else {
              mShopcarList = model.result.shopcarList;
            }

            //初始化仓库的按钮是否选中
            for (int i = 0; i < mShopcarList.length; i++) {
              ShopcarList? shopcarList = mShopcarList[i];
              if (null != shopcarList) {
                num productSize = shopcarList?.productList?.length as num;
                if (null == shopcarList?.productList || productSize <= 0) {
                  //商品列表为空
                  continue;
                }
                bool totalSelect = true;
                for (int j = 0; j < productSize; j++) {
                  print("================");
                  if (shopcarList?.productList![j]?.selected == 0) {
                    totalSelect = false;
                    break; //终止这一次循环
                  }
                }
                mShopcarList[i]?.totalSelected = totalSelect;
              }
            }
            setState(() {});
          }
        }
      } else {}
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });
  }
}

///动态头部处理
class GSYSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  GSYSliverHeaderDelegate(
      {required this.minHeight,
      required this.maxHeight,
      required this.snapConfig,
      required this.vSync,
      this.child,
      this.builder,
      this.changeSize = false});

  final double minHeight;
  final double maxHeight;
  final Widget? child;
  final Builder? builder;
  final bool changeSize;
  final TickerProvider vSync;
  final FloatingHeaderSnapConfiguration snapConfig;
  AnimationController? animationController;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  TickerProvider get vsync => vSync;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder!(context, shrinkOffset, overlapsContent);
    }
    return child!;
  }

  @override
  bool shouldRebuild(GSYSliverHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snapConfig;
}

typedef Widget Builder(
    BuildContext context, double shrinkOffset, bool overlapsContent);
