import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as W;
import 'package:flutter/rendering.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/common_request_model.dart';
import 'package:flutter_money/wajiu/model/joined_product_list_model.dart';
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
  List<ShopcarList?> mShopcarList = [];
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
                return GestureDetector(
                  onTap: ()=>_checkLocation(),
                  child: SizedBox.expand(
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
                                        Row(
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1,color: ColorUtil.color("#cccccc"),),
                            ],
                          )
                      )),
                );
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
                    itemCount: mShopcarList.length,
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
          itemCount: mShopcarList[index]?.productList?.length??0,
          itemBuilder: (BuildContext context, int childIndex) {
            return Container(
                padding: EdgeInsets.only(left: 13,bottom: 5),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(child:  Image.asset(
                            mShopcarList[index]?.productList![childIndex]?.selected==1?"images/ic_radio_check.png":"images/shopping_cart_weixuanzhong.png",
                            width: 20,
                            height: 20,
                          ),height: 88,),
                          onTap: ()=>_changeChildProductRadioStates(index,childIndex),
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
                                      "${mShopcarList[index]?.productList![childIndex]?.productname}",
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
          },
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

  void _changeRadioStates(int index) {
    setState(() {
      selectedList[index] = !selectedList[index];
    });
  }

  void _changeChildProductRadioStates(int fatherIndex,int childIndex) {
    int? select = mShopcarList[fatherIndex]?.productList![childIndex]?.selected;

    _changeProductStatusRequest(fatherIndex,childIndex,mShopcarList[fatherIndex]?.productList![childIndex]?.productid,select);
  }

  //更改采购车商品选中状态
  void _changeProductStatusRequest(int fatherIndex,int childIndex,int? productid,int? select){
    var params = Map<String, dynamic>();
    params["productId"] = productid;
    if(select == 0){
      params["select"] = 1;
    }else if(select == 1){
      params["select"] = 0;
    }
    DioInstance.getInstance().get(ApiService.changeProductSelectStatus, params,
        success: (json) {
          print("getShopCarData：$json");
          CommonRequestModel model = CommonRequestModel.fromJson(json);
          print("JoinedProductListModel：$model");

          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              mShopcarList[fatherIndex]?.productList![childIndex]?.selected = select==0?1:0;
              num size = 0;
              if(mShopcarList[fatherIndex]?.productList == null){
                size= 0;
              }else{
                size = mShopcarList[fatherIndex]?.productList?.length as num;
              }

              //处理仓库按钮的选中状态
              bool  totalSelected = true;
              for(int i=0;i<size;i++){
                if(mShopcarList[fatherIndex]?.productList![i]?.selected == 0){
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
  void setCangKuSelect(int fatherIndex){

  }

  Widget _listviewItem(int index) {
    print("mShopcarList的数量${mShopcarList.length}");
    bool? productItemEmpty = mShopcarList[index]?.productList?.isEmpty;
    if(mShopcarList[index]?.fathername?.isEmpty==true || mShopcarList[index]?.fathername == null){
      print("index: $index,${mShopcarList[index]?.fathername}");
    }else{
      print("index: $index,${mShopcarList[index]?.fathername}");
    }
    return (mShopcarList[index]==null ||mShopcarList[index]?.fathername?.isEmpty==true || mShopcarList[index]?.fathername == null)?
    Offstage(child:Text(""),offstage: true):
    Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10,left: 13,right: 13),
          child: Row(
            children: [
              GestureDetector(
                child:  Image.asset(
                  mShopcarList[index]?.totalSelected==true?"images/ic_radio_check.png":"images/shopping_cart_weixuanzhong.png",
                  width: 20,
                  height: 20,
                ),
                onTap: ()=>_changeRadioStates(index),
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
  void getShopCarData(){
    var params = Map<String, dynamic>();
    DioInstance.getInstance().get(ApiService.getShopCarData, params,
        success: (json) {

          print("getShopCarData：$json");
          JoinedProductListModel model = JoinedProductListModel.fromJson(json);
          print("JoinedProductListModel：$model");

          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              if (null != model.result) {
                if(model.result.shopcarList.isEmpty){
                  mShopcarList = [];
                }else{
                  mShopcarList = model.result.shopcarList;
                }

                //初始化仓库的按钮是否选中
                for(int i=0;i<mShopcarList.length;i++){
                  ShopcarList? shopcarList = mShopcarList[i];
                  if(null!=shopcarList){
                    num productSize = shopcarList?.productList?.length as num;
                    if(null==shopcarList?.productList || productSize <=0){//商品列表为空
                      continue;
                    }
                    bool totalSelect = true;
                    for(int j=0;j<productSize;j++){
                      print("================");
                      if(shopcarList?.productList![j]?.selected == 0){
                        totalSelect = false;
                        break;//终止这一次循环
                      }
                    }
                    mShopcarList[i]?.totalSelected = totalSelect;
                  }
                }
                setState(() {});
              }
            }
          }else{

          }
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
