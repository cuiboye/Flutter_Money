import 'package:flutter/material.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/model/mingzhuangxianhuo_product_list_model.dart';
import 'package:flutter_money/wajiu/service/mingzhuangxianhuo_list_service.dart';
import 'package:flutter_money/wajiu/view/mingzhuangxianhuo_list_model.dart';
import 'package:flutter_money/wajiu/widget/wajiu_detail_banner_indicator.dart';
import 'package:flutter_money/widget/net_image_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
            List<Noticelist?> noticelist = _mingzhuangxianhuoViewModel.noticeList??[];
            List<Productlist?> productList = _mingzhuangxianhuoViewModel.productList??[];
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: listViewHeader(noticelist),
                ),
                SliverPrototypeExtentList(
                  prototypeItem: Text(
                    '老孟',
                    style: TextStyle(fontSize: 28),
                  ),
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

  Widget listViewItem(List<Productlist?> productList,int index){
    if(WajiuUtils.collectionIsSafe(productList,index) == false){
      return Text("");
    }
    return Column(
      children: [
        Text("${productList[index]?.picture??""}"),
      ],
    );
  }

  Widget listViewHeader(List<Noticelist?> noticelist) {
    return Container(
        //根据具体情况来设置比例
        height: MediaQuery.of(context).size.width / 1.963,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Swiper(
            onTap: (index) {},
            itemCount: noticelist.length,
            autoplay: false,
            //是否自动轮播
            pagination: SwiperPagination(
                //指示器
                margin: EdgeInsets.only(bottom: 5),
                //在这里控制指示器距离底部的距离，默认距离是10
                // alignment: Alignment.bottomCenter,//指示器的位置不在这里控制了，在NLIndicator中控制
                builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return NLIndicator(config.activeIndex, noticelist.length);
                })),
            itemBuilder: (BuildContext context, int index) {
              return NetImageView(
                url:noticelist[index]?.picture??"",
                boxFit: BoxFit.fill,
              );
            },
          ),
        ));
  }
}
