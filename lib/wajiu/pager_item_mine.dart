import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/page/account_topup.dart';
import 'package:flutter_money/wajiu/page/my_balance.dart';
import 'package:flutter_money/wajiu/view/wajiu_my_balance.dart';
import 'package:get/get.dart';
import '../view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/extension/wajiu_mine_order.dart';

import 'order_list_page.dart';

class PageItemMine extends StatefulWidget {
  @override
  _PageItemMineState createState() => _PageItemMineState();
  final String? info;

  PageItemMine({this.info});
}

var functionListStr = ["充值","消费记录","我的海报","我的收藏","我的足迹","我的包销","保证金","我的拼团","我的定制","地址管理","帮我卖酒","我的发票","香港站订单",];
var functionListImage = ["images/mine_chongzhi.png",
  "images/mine_zhangdan.png",
  "images/icon_my_poster.png",
  "images/mine_shoucang.png",
  "images/mine_zuji.png",
  "images/mine_dujia.png",
  "images/ic_cash_deposit.png",
  "images/icon_group.png",
  "images/mien_oem.png",
  "images/mine_dizhi.png",
  "images/mine_help_me_sell.png",
  "images/icon_invoice.png",
  "images/mine_dizhi.png",
  "images/icon_hk_station.png"];


class _PageItemMineState extends State<PageItemMine> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final _screentWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                height: padding.top,
                decoration: BoxDecoration(color: Colors.red),
              ),
              Container(
                  height: 150,
                  width: _screentWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange.shade700])),
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    "images/napolun.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("拿破仑",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          Positioned(
                              right: 20,
                              top: 10,
                              child: Image.asset("images/mine_news.png",
                                  width: 25, height: 25))
                        ],
                      ))),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 18, right: 13, top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:Text(
                          "我的订单",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Image.asset(
                        "images/icon_rihgt_more.png",
                        width: 15,
                        height: 15,
                      )
                    ],
                  ),
                ),
                onTap: ()=>{
                  GetNavigationUtils.navigateRightToLeft(OrderListPage())
                },
              ),
              Container(
                height: 0.1,
                margin: EdgeInsets.only(left: 13,right: 13),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("待付款",style: TextStyle(fontSize: 11)).withMineOrder("images/mine_my_order_daifukuan.png"),
                    Text("已发货",style: TextStyle(fontSize: 11)).withMineOrder("images/mine_my_order_daishouhuo.png"),
                    Text("未完成",style: TextStyle(fontSize: 11)).withMineOrder("images/mine_my_order_weichenggong.png"),
                    Text("未完成",style: TextStyle(fontSize: 11)).withMineOrder("images/mine_my_order_yiwancheng.png"),
                  ],
                ),
              ),
              Container(
                height: 8,
                color: ColorUtil.color("#eeeeee"),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 18, right: 13, top: 10, bottom: 10),
                  child: Text( "我的资金",style: TextStyle(color: Colors.black),)
              ),
              Container(
                height: 0.1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),

              Column(
                children: [
                  Container(
                    //第一行
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: ()=>{
                                GetNavigationUtils.navigateRightToLeft(MyBalance())
                                // GetNavigationUtils.navigateRightToLeft(ProvideDemo6())
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10,right: 13,top: 15,bottom: 15),
                                child: Row(
                                  //第一行的第一个
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("images/ic_balance.png",
                                            width: 20, height: 20),
                                        Text("余额",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ColorUtil.color("#666666"))),
                                      ],
                                    ),
                                    Row(
                                      children: [Text("¥"), Text("93,628,115,05")],
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        Expanded(
                            child:Container(
                              padding: EdgeInsets.only(left: 10,right: 13,top: 15,bottom: 15),
                              child: Row(
                                //第一行的第一个
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("images/ic_balance.png",
                                          width: 20, height: 20),
                                      Text("金币",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorUtil.color(
                                                  "#666666"))),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text("205,272.35"))
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),

                  Container(//第二行
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 13,top: 15,bottom: 15),
                              child: Row(
                                //第一行的第一个
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                  Image.asset("images/ic_balance.png",
                                      width: 20, height: 20),
                                  Text("优惠券",style: TextStyle(fontSize: 12,color: ColorUtil.color("#666666"))),
                                    ],
                                  ),
                                  Text("29张")
                                ],
                              ),
                            )),
                        Expanded(
                            child:Container(
                              padding: EdgeInsets.only(left: 10,right: 13,top: 15,bottom: 15),
                              child: Row(
                                //第一行的第一个
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("images/ic_balance.png",
                                      width: 20, height: 20),
                                  Text("样品券",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorUtil.color("#666666"))),
                                ],
                              ),
                              Text("1000张")
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Expanded(child:  Container(
              //               decoration: BoxDecoration(
              //                 //也可以设置4个边框 Border.all();
              //                   border: Border(
              //                       right: BorderSide(
              //                           width: 0.1,
              //                           color: Colors.grey
              //                       ),
              //                       bottom: BorderSide(
              //                           width: 0.1,
              //                           color: Colors.grey
              //                       )
              //                   )
              //               ),
              //               child: Expanded(child:Row(
              //                 children: [
              //                   Container(
              //                     margin: EdgeInsets.fromLTRB(13, 10, 0, 10),
              //                     child: Row(
              //                       children: [
              //                         Image.asset("images/ic_balance.png",width: 20,height: 20),
              //                         Text("余额",style: TextStyle(fontSize: 12,color: ColorUtil.color("#666666"))),
              //                       ],
              //                     ),
              //                   ),
              //
              //                   Container(
              //                     margin: EdgeInsets.only(left: 30),
              //                     child: Row(
              //                       children: [
              //                         Text("¥"),
              //                         Text("93,628,115,05")
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               )),
              //             ),),
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   //也可以设置4个边框 Border.all();
              //                     border: Border(
              //                         bottom: BorderSide(
              //                             width: 0.1, color: Colors.grey))),
              //                 child: Expanded(
              //                     child: Row(
              //                       children: [
              //                         Container(
              //                           margin: EdgeInsets.fromLTRB(13, 10, 0, 10),
              //                           child: Row(
              //                             children: [
              //                               Image.asset("images/ic_balance.png",
              //                                   width: 20, height: 20),
              //                               Text("金币",style: TextStyle(fontSize: 12,color: ColorUtil.color("#666666"))),
              //                             ],
              //                           ),
              //                         ),
              //                         Container(
              //                             margin: EdgeInsets.only(left: 30),
              //                             child: Text("205,272.35")
              //                         )
              //                       ],
              //                     )),
              //               ),
              //             )
              //           ],
              //         ),
              //
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   //也可以设置4个边框 Border.all();
              //                     border: Border(
              //                         right: BorderSide(
              //                             width: 0.1,color: Colors.grey
              //                         ),
              //                         bottom: BorderSide(
              //                             width: 0.1, color: Colors.grey))),
              //                 child: Expanded(
              //                     child: Row(
              //                       children: [
              //                         Container(
              //                           margin: EdgeInsets.fromLTRB(13, 10, 0, 10),
              //                           child: Row(
              //                             children: [
              //                               Image.asset("images/ic_balance.png",
              //                                   width: 20, height: 20),
              //                               Text("优惠券",style: TextStyle(fontSize: 12,color: ColorUtil.color("#666666"))),
              //                             ],
              //                           ),
              //                         ),
              //                         Container(
              //                             margin: EdgeInsets.only(left: 30),
              //                             child: Text("29张")
              //                         )
              //                       ],
              //                     )),
              //               ),
              //             ),
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   //也可以设置4个边框 Border.all();
              //                     border: Border(
              //                         right: BorderSide(
              //                             width: 0.1,color: Colors.grey
              //                         ),
              //                         bottom: BorderSide(
              //                             width: 0.1, color: Colors.grey))),
              //                 child: Expanded(
              //                     child: Row(
              //                       children: [
              //                         Container(
              //                           margin: EdgeInsets.fromLTRB(13, 10, 0, 10),
              //                           child: Row(
              //                             children: [
              //                               Image.asset("images/ic_balance.png",
              //                                   width: 20, height: 20),
              //                               Text("样品券",style: TextStyle(fontSize: 12,color: ColorUtil.color("#666666"))),
              //                             ],
              //                           ),
              //                         ),
              //                         Container(
              //                             margin: EdgeInsets.only(left: 30),
              //                             child: Text("1000张")
              //                         )
              //                       ],
              //                     )),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Container(
              //           color: Colors.grey,
              //           width: 1,
              //         )
              //       ],
              //     ),
              //
              //   ],
              // ),
              Container(
                height: 8,
                color: ColorUtil.color("#eeeeee"),
              ),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //Grid按4列显示
              // mainAxisSpacing: 10.0,//item水平之间的距离
              // crossAxisSpacing: 10.0,//item垂直方向的距离
              childAspectRatio: 1.3
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建子widget
              return  _getFunctionListWidget(index);
            },
            childCount: functionListStr.length,
          ),
        ),
      ],
    );
  }

  Widget _getFunctionListWidget(int index) {
    return GestureDetector(
      onTap: ()=>{
        if(index == 0){
          GetNavigationUtils.navigateRightToLeft(AccountTopup())
        }
      },
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(functionListImage[index],width: 40,height: 40,),
              Text(functionListStr[index],style: TextStyle(fontSize: 12),),
            ],
          )
      ),
    );
  }
}
