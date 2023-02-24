import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as W;
import 'package:flutter/rendering.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/ExpansionTileSample.dart';
import 'package:flutter_money/layout/container_widget.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_pickers/pickers.dart';

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

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      ///头部信息
      SliverPersistentHeader(
        delegate: GSYSliverHeaderDelegate(
          maxHeight: 180,
          minHeight: 180,
          vSync: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: Container(
              child: Image.asset(
            "images/main_page_banner1.jpeg",
            fit: BoxFit.fill,
          )),
        ),
      ),
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverPersistentHeader(
          pinned: true,

          /// SliverPersistentHeaderDelegate 的实现
          delegate: GSYSliverHeaderDelegate(
              maxHeight: 60,
              minHeight: 60,
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
                return SizedBox.expand(
                    child: Container(
                      padding: EdgeInsets.only(left: 13,right: 13),
                  color: ColorUtil.color("#ffffff"),
                  child: Column(
                    children: [
                      Expanded(//这里让主内容撑满，是为了显示底部的线
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
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
                                        child: Text(TextUtils.isEmpty(currentAddress)?"北京 市辖区 东城区":currentAddress))
                                  ],
                                ),
                                GestureDetector(
                                  onTap: ()=>_checkLocation(),
                                  child: Row(
                                    children: [
                                      Text("更换",style: TextStyle(color: ColorUtil.color("#f56e1d"),fontSize: 13),),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Image.asset(
                                          "images/icon_change_open.png",
                                          width: 15,
                                          height: 15,
                                        ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,color: ColorUtil.color("#cccccc"),),
                    ],
                  )
                ));
              }),
        ),
      ),
    ];
  }
  String initProvince = '四川省', initCity = '成都市', initTown = '双流区';

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
  List<String> fatherNameList = ["上海仓境内物流发货","北京仓境内物流发货","广州仓境内物流发货",];
  List<bool> selectedList = [false,false,false];
  List<bool> childSelectedList = [false,false,false];
  @override
  Widget build(BuildContext context) {
    return Container(
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
                SliverToBoxAdapter(//购物车列表
                  child:ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fatherNameList.length,
                    itemBuilder: _itemBuilder,
                  )
                ),
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
                          child: Text("全选", style: TextStyle(fontSize: 12)))
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: ColorUtil.color("#ff0000"),
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

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [

        _listviewItem(index),//ListView的一级布局

        ListView.builder(//ListView的二级布局
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: _listviewItemContent,
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
              color: ColorConstant.color_eeeeee
          ),
        ),
      ],
    );
  }

  Widget _listviewItemContent(BuildContext context, int index) {
    return Container(
        padding: EdgeInsets.only(left: 13,bottom: 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child:  Image.asset(
                  "images/shopping_cart_weixuanzhong.png",
                  width: 20,
                  height: 20,
                ),height: 88,),
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
                              child: Text("预计3月中旬发货",style:TextStyle(fontSize: 8, color: ColorConstant.color_ffffff),
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
                              "莫汉父子圣乔治之夜一级园托勒园干红_2016",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  "¥49.00/包",
                                  style: TextStyle(color: ColorConstant.systemColor),
                                ),
                                Spacer(),
                                Text(
                                  "6提装",
                                  style: TextStyle(
                                      color: ColorConstant.color_a4a5a7, fontSize: 13),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text("现货",style: TextStyle(fontSize: 13,color: ColorConstant.color_a4a5a7),),
                                Spacer(),
                                Container(
                                  height: 25,                          // constraints: ,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/shopping_cart_reduce2.png",
                                        width: 25,height: 25,
                                      ),
                                      Container(
                                        width: 40,height: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(0),
                                            border: Border.all(
                                                width: 1
                                            )
                                        ),
                                        child:TextField(
                                          textAlign: TextAlign.center,
                                          onChanged: (value){
                                            print("$value");
                                          },
                                          style: TextStyle(fontSize: 11,color: ColorConstant.color_c343434),

                                        ),
                                      ),
                                      Image.asset(
                                        "images/shopping_cart_add2.png",
                                        width: 25,height: 25,
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
              margin: EdgeInsets.only(top: 10,bottom: 10),
              decoration: BoxDecoration(
                  color: ColorConstant.color_eeeeee
              ),
            )
          ],
        )
    );
  }

  void _changeRadioStates(int index) {
    setState(() {
      selectedList[index] = !selectedList[index];
    });
  }

  Widget _listviewItem(int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10,left: 13,right: 13),
          child: Row(
            children: [
              GestureDetector(
                child:  Image.asset(
                  selectedList[index]?"images/ic_radio_check.png":"images/shopping_cart_weixuanzhong.png",
                  width: 20,
                  height: 20,
                ),
                onTap: ()=>_changeRadioStates(index),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(fatherNameList[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
              // SizedBox(
              //   height: 90,
              //   child: ListView.builder(
              //     itemBuilder: (BuildContext context, int index) => Text("dsfdsf"),
              //     itemCount: 3,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
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
