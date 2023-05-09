import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/wajiu_utils.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/home_main_model.dart';

class MainPageTabbarview extends StatefulWidget {
  List<KindSetList?> kindSetList = []; //tab标签数据
  MainPageTabbarview(this.kindSetList, {Key? key}) : super(key: key);

  @override
  _MainPageTabbarviewState createState() => _MainPageTabbarviewState();
}

class _MainPageTabbarviewState extends State<MainPageTabbarview>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;//保持页面状态

  late TabController _tabController;
  int _select = 0; //选中tab小标
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.kindSetList.length);
    _tabController.addListener(() {
      setState(() {
        _select = _tabController.index;
        print("$_select");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorConstant.color_ffe4d2,
                      ColorConstant.color_ffffff
                    ]),
                color: ColorConstant.color_ffffff,
                border: Border.all(
                  //边框
                    width: 0.1,
                    color: ColorConstant.color_ffffff),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                )),
            margin: EdgeInsets.only(left: 13,right: 13,top: 8),
            height: 40,
            child: tabBarWidget()
        ),
        tabBarView()
      ],
    );
  }

  Widget tabBarView(){
      if(WajiuUtils.collectionIsEmpty(widget.kindSetList) ==false){
        return Container(
          color: ColorConstant.color_ffffff,
          margin: const EdgeInsets.only(left: 13,right: 13),
          child: SizedBox(
            height: 380,
            child: TabBarView(//相当于Android的ViewPager
              controller: _tabController,
              children: _tabBarViewItem(),
            ),
          ),
        );
      }
      return Text("");
    }
  List<Widget> _tabBarViewItem() {
    if(WajiuUtils.collectionIsEmpty(widget.kindSetList) == true){
      return [];
    }
    return widget.kindSetList.map<Widget>((value) {
      List<ProductInfoList?> productList = (value as KindSetList)?.productInfoList ?? [];
      return Container(
        margin: const EdgeInsets.only(left: 13,right: 13),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children:  itemWithTab(productList),
        ),
      );

    }).toList();
  }

  List<Widget> itemWithTab(List<ProductInfoList?> productList){
    if(WajiuUtils.collectionIsEmpty(widget.kindSetList) == true){
      return [];
    }
    return productList.map<Widget>((item) {
      // print("hello${item?.picture?.replaceAll("http", "https")??""}");
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: ColorConstant.color_ffffff,
                border: Border.all(width: 1,color: ColorConstant.color_eeeeee),//边框
              ),
              child: Image.network("${item?.picture}?imageView2/2/w/740/h/314/q/100"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child:  Text(item?.cname??"",maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              child:  Text(item?.jnPrice??"",maxLines: 1,overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConstant.systemColor),),
            ),
          ],
        ),
      );
    }).toList();

  }

  Widget tabBarWidget(){
    if (WajiuUtils.collectionIsEmpty(widget.kindSetList) == true) {
      return Text("");
    }
    return TabBar(
        indicatorColor: Colors.transparent,
        //指示器设置为透明色
        indicatorPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        isScrollable: true,
        //设置可滑动
        controller: _tabController,
        onTap: (value) {
          setState(() {
            _select = value;
          });
        },
        //tabs tab标签
        tabs: tabs()
    );
  }

  List<Widget> tabs() {
    List<Widget> listTab = [];

    if (WajiuUtils.collectionIsEmpty(widget.kindSetList) == true) {
      return listTab;
    }
    for (int i = 0; i < widget.kindSetList.length; i++) {
      listTab.add(
        Tab(
            child: Container(
              height: 44,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.kindSetList[i]?.kindName??""}",
                      style: _select == i ? const TextStyle(color:   ColorConstant.systemColor,fontWeight: FontWeight.bold,
                          fontSize: 16,):const TextStyle(color:ColorConstant.color_333333, fontSize: 14,),
                    ),
                  ),
                ],
              ),
            )),
      );
    }
    return listTab;
  }
}
