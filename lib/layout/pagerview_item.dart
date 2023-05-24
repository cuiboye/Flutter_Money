import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/layout/product_list_page.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/view/over_scroll_behavior.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/category_second_type_list_model.dart';
import 'package:flutter_money/wajiu/model/category_type_list_model.dart';
import 'package:flutter_money/wajiu/widget/line_view.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PageViewItem extends StatefulWidget {
  @override
  _PageViewItemState createState() => _PageViewItemState();
  final String? info;

  PageViewItem({this.info});
}

class _PageViewItemState extends State<PageViewItem>{
  List<TypeList?> typeList = [];
  List<ParameterList?> parameterList = [];
  List<BannerList?> bannerList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getCategoryTypeListData();
  }

  @override
  Widget build(BuildContext context) {
    //获取安全区域
    final padding = MediaQuery.of(context).padding;
    return Column(
      children: [
        Container(
          //这是一个假的状态栏
          decoration: BoxDecoration(color: Colors.red),
          height: padding.top,
        ),
        Container(
          color: ColorConstant.color_ef7134,
          child: Container(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
            margin: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            decoration: BoxDecoration(
                color: ColorUtil.color("#bdffffff"),
                //设置边框,也可以通过 Border()的构造方法 分别设置上下左右的边框
                border: Border.all(width: 1, color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
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
                          fontSize: 12, color: ColorUtil.color("#a3a2a2"))),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                      padding: EdgeInsets.only(top: 0),
                      child: ScrollConfiguration(
                        behavior: OverScrollBehavior(), //去除水波纹
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) =>
                              leftItemWidget(index),
                          itemCount: typeList.length,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return LineView(
                                color: ColorConstant.color_d8d8d8,
                                line_height: 0.5);
                          },
                        ),
                      )
                  )
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ScrollConfiguration(
                        behavior: OverScrollBehavior(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              swipeWidget(),

                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) =>
                                    rightItemWidget(index),
                                // itemCount: leftTypeList.length,
                                itemCount: parameterList.length,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        )
                      )),
                ))
          ],
        ))
      ],
    );
  }

  Widget swipeWidget(){
    if(WajiuUtils.collectionIsEmpty(bannerList) == true){
      return Text("");
    }
    return Container(
        padding: EdgeInsets.only(left: 13, right: 13),
        height: MediaQuery.of(context).size.width / 2.285,
        //根据具体情况来设置比例
        width: double.infinity,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Swiper(
              onTap: (index) {
              },
              itemCount:  bannerList.length,
              autoplay: false,
              itemBuilder: (BuildContext context, int index) {
                return CacheImageView(url:bannerList[index]?.name ?? "", boxFit: BoxFit.fill,);
              },
            )
        ));
  }

  Widget rightItemWidget(int index) {
    String fatherName = parameterList[index]?.title??"";
    if(TextUtils.isEmpty(fatherName) || WajiuUtils.collectionIsEmpty(parameterList[index]?.list) == true){
      return Text("");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 25,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(index%2==0?"images/tv_bg_category_title1.png":"images/tv_bg_category_title2.png"), fit: BoxFit.fill)),
            margin: EdgeInsets.only(left: 13, right: 13, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 13),
                  child: Text(fatherName,
                    style: TextStyle(color: ColorConstant.color_606366,fontSize: 13),),
                )
              ],
            )),
        getTextAddImageList(parameterList[index],index)
        // getRightItemWithImageWidget(index)
      ],
    );
  }

  Widget getTextAddImageList(ParameterList? parameterListItem,int index){
    print("getTextAddImageList");
    return Container(
      margin: EdgeInsets.only(left: 13, right: 13, top: 10),
      child: StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: rightTextAddImageItem(parameterListItem?.type??0,parameterListItem?.list??[]),
      ),
    );
  }

  List<Widget> rightTextAddImageItem(int type,List<ListBean?> list) {
    print("rightTextAddImageItem $type");
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      if(WajiuUtils.collectionIsSafe(list, i)){
        if(type == 1){
          Widget widget = GestureDetector(
            onTap: (){
              GetNavigationUtils.navigateRightToLeft(ProductListPage());
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 3, bottom: 3),
              decoration: BoxDecoration(
                  color: ColorConstant.color_eeeeee,
                  border: Border.all(width: 1, color: ColorConstant.color_eeeeee),
                  //边框
                  borderRadius: BorderRadius.all(Radius.circular(2.0)) //边框圆角
              ),
              child: Center(
                child: Text(
                  list[i]?.name??"",maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12,color: ColorConstant.color_606366),
                ),
              ),
            ),
          );
          widgetList.add(widget);
        }else{
          Widget widget = CacheImageView(url: list[i]?.name??"");
          widgetList.add(widget);
          // Text("sdfdsf");
        }
      }
    }
    return widgetList;
  }

  Widget leftItemWidget(int index) {
    bool selected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        selectedIndex = index;
        getSecondCategoryTypeListData(typeList[index]?.value??"");
        // setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(top: 13, bottom: 13, right: 10),
        color:
            selected ? ColorConstant.color_ffffff : ColorConstant.color_eeeeee,
        child: Text(
          typeList[index]?.name??"",
          textAlign: TextAlign.right,
          style: TextStyle(
              color: selected
                  ? ColorConstant.systemColor
                  : ColorConstant.color_333333,
              fontSize: 14),
        ),
      ),
    );
  }

  void getCategoryTypeListData(){
    DioInstance.getInstance().get(ApiService.categoryTypeList, <String, dynamic>{},
        success: (resultData) {
          CategoryTypeListModel model = CategoryTypeListModel.fromJson(resultData);
          print("getCategoryTypeListData2");

          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              typeList = model.result?.typeList??[];
              getSecondCategoryTypeListData(typeList[0]?.value??"");
            }
          } else {

          }
        }, fail: (reason, code) {

        });
  }

  void getSecondCategoryTypeListData(String reqId){
    print("getSecondCategoryTypeListData");
    var params = Map<String, dynamic>();
    params["reqId"] = reqId;
    DioInstance.getInstance().get(ApiService.secondCategoryTypeList, params,
        success: (resultData) {
          CategorySecondTypeListModel model = CategorySecondTypeListModel.fromJson(resultData);
          if (null != model) {
            int status = model.states;
            String msg = model.msg;
            if (status == 200) {
              parameterList = model.result?.parameterList??[];
              bannerList = model.result?.bannerList??[];
              setState(() {
              });
              print("接口请求结束了！");
            }
          } else {

          }
        }, fail: (reason, code) {

        });
  }
}
