import 'package:flutter/material.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/mingzhuangxianhuo_product_list_model.dart';
import 'package:flutter_money/wajiu/service/mingzhuangxianhuo_list_service.dart';
import 'package:flutter_money/wajiu/view/mingzhuangxianhuo_list_model.dart';
import 'package:flutter_money/wajiu/view/wajiu_goods_detail.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/wajiu/widget/wajiu_detail_banner_indicator.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/widget/net_image_utils.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class MingzhuangxianhuoView extends StatefulWidget {
  @override
  _MingzhuangxianhuoViewState createState() => _MingzhuangxianhuoViewState();
}

class _MingzhuangxianhuoViewState extends State<MingzhuangxianhuoView> {
  @override
  void initState() {
    // 获取接口数据
    MingzhuangxianhuoService.requestData(
        Provider.of<MingzhuangxianhuoViewModel>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "名庄现货",
        ),
        body: Consumer<MingzhuangxianhuoViewModel>(
          builder: (_, _mingzhuangxianhuoViewModel, child) {
            List<Noticelist?> noticelist =
                _mingzhuangxianhuoViewModel.noticeList ?? [];
            List<Productlist?> productList =
                _mingzhuangxianhuoViewModel.productList ?? [];
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: listViewHeader(noticelist),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((content, index) {
                    return listViewItem(productList, index);
                  }, childCount: productList.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget listViewItem(List<Productlist?> productList, int index) {
    final bool canSelected = productList[index]?.operate.jnPrice == -1;
    if (WajiuUtils.collectionIsSafe(productList, index) == false) {
      return Text("");
    }
    return Column(
      children: [
        Container(
          height: 117,
          padding: EdgeInsets.only(left: 13, right: 13,top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CacheImageViewWithWidth(
                  url:
                      "${productList[index]?.picture}?imageView2/2/w/740/h/314/q/100",
                  width: 92),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productList[index]?.cname ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14, color: ColorConstant.color_323232),
                    ),
                    Expanded(
                      child: Text(
                        productList[index]?.ename ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, color: ColorConstant.color_757575),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productList[index]?.description1 ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11, color: ColorConstant.color_323232),
                        ),
                        Row(
                          children: [
                            Text(
                              "${canSelected ? "已售完" : productList[index]?.operate.jnPrice}",
                              style: TextStyle(
                                  fontSize: 15, color: ColorConstant.color_f62d2d),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(left: 6,right: 6,top: 3,bottom: 3),
                              decoration: BoxDecoration(
                                color: canSelected?ColorConstant.systemColor:ColorConstant.color_c0c0c0,
                                  borderRadius: BorderRadius.all(Radius.circular(3.0))//边框圆角
                              ),
                              margin: EdgeInsets.only(top: 10,bottom: 4),
                              child: Text("立即抢购",
                                style: TextStyle(
                                    fontSize: 14, color:ColorConstant.color_ffffff),),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
        LineView(
          line_height: 8,
          color: ColorConstant.color_eeeeee,
        )
      ],
    );
  }

  Widget listViewHeader(List<Noticelist?> noticelist) {
    // return Container(
    //     //根据具体情况来设置比例
    //     height: MediaQuery.of(context).size.width / 1.963,
    //     width: MediaQuery.of(context).size.width,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(0.0),
    //       child: Swiper(
    //         onTap: (index) {},
    //         itemCount: noticelist.length,
    //         autoplay: false,
    //         //是否自动轮播
    //         pagination: SwiperPagination(
    //             //指示器
    //             margin: EdgeInsets.only(bottom: 5),
    //             //在这里控制指示器距离底部的距离，默认距离是10
    //             // alignment: Alignment.bottomCenter,//指示器的位置不在这里控制了，在NLIndicator中控制
    //             builder: SwiperCustomPagination(
    //                 builder: (BuildContext context, SwiperPluginConfig config) {
    //               return NLIndicator(config.activeIndex, noticelist.length);
    //             })),
    //         itemBuilder: (BuildContext context, int index) {
    //           return CacheImageView(
    //             url:
    //                 "${noticelist[index]?.picture}?imageView2/2/w/740/h/314/q/100",
    //             boxFit: BoxFit.fill,
    //           );
    //         },
    //       ),
    //     ));
    return Text("轮播图");
  }
}
