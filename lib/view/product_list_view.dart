import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/drop_select_menu/drop_select_header.dart';
import 'package:flutter_money/drop_select_menu/drop_select_menu.dart';
import 'package:flutter_money/drop_select_menu/drop_select_widget.dart';
import 'package:flutter_money/scroll/scroll_widget.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/adapter/product_list_adapter.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/wajiu_product_list_model.dart';
import 'package:flutter_money/wajiu/service/wajiu_product_list_servoce.dart';
import 'package:flutter_money/wajiu/viewmodel/wajiu_product_list_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:frame_animate_widget/frame_animate_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 商品列表+下拉筛选列表
 */
class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> with SingleTickerProviderStateMixin{
  int pageNum = 1;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  bool loadData = false;
  bool mInit = false;

  //素材列表
  List<String> images=[
    "images/ic_progressbar_0.png",
    "images/ic_progressbar_1.png",
    "images/ic_progressbar_2.png",
    "images/ic_progressbar_3.png",
    "images/ic_progressbar_4.png",
    "images/ic_progressbar_5.png",
    "images/ic_progressbar_6.png",
    "images/ic_progressbar_7.png",
    "images/ic_progressbar_8.png"
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WajiuProductListService.getProductList(
        Provider.of<ProductListViewModel>(context, listen: false), pageNum,_refreshController,true);
    super.initState();
  }

  void _onRefresh() async {
    pageNum = 1;

    print("_onRefresh 当前页数为 $pageNum");
    print("_onRefresh 当前页数为 $pageNum");
    WajiuProductListService.getProductList(
        Provider.of<ProductListViewModel>(context, listen: false), pageNum,_refreshController,true);
  }

  void _onLoading() async {
    pageNum++;
    WajiuProductListService.getProductList(
        Provider.of<ProductListViewModel>(context, listen: false), pageNum,_refreshController,false);
  }

  @override
  Widget build(BuildContext context) {
    print("ProductListView-build");
    return CustomMaterialApp(
      home: Scaffold(
        body: Container(
          color: ColorConstant.color_ebebeb,
          child: Stack(
            children: <Widget>[
              DropSelectMenuContainer(
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          color: ColorConstant.color_ffffff,
                          child: renderDropSelectHeader(),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Consumer<ProductListViewModel>(
                                  builder: (_, model, child) {
                                    print("Consumer");
                                    mInit= false;
                                    print("_model.hasData ${model.hasData}");
                                    final ProductListViewModel _model = model;
                                    if (_model.loading && _model.refreing) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return SmartRefresher(
                                      enablePullDown: true,
                                      enablePullUp: true,
                                      // header: const WaterDropHeader(),//系统的刷新header
                                      header: CustomHeader(builder: (context, mode) {
                                        print("mode:$mode");
                                        if(mode == RefreshStatus.refreshing){
                                          // controller.forward();//开始执行刷新控件header动画
                                          loadData = true;
                                          print("开始！");
                                        }else if(mode == RefreshStatus.completed){
                                          // controller.stop();//停止刷新控件header动画
                                          loadData = false;
                                          print("结束！");
                                        }
                                        // else {
                                        //   controller.reset();
                                        //   controller.stop();
                                        //   loadData = false;
                                        //   print("结束！");
                                        // }
                                        return Center(
                                          //可以根据状态来执行不同的展示
                                          // child: Text(mode == RefreshStatus.idle
                                          //     ? "下拉刷新"
                                          //     : mode == RefreshStatus.refreshing
                                          //     ? "刷新中..."
                                          //     : mode == RefreshStatus.canRefresh
                                          //     ? "可以松手了!"
                                          //     : mode == RefreshStatus.completed
                                          //     ? "刷新成功!"
                                          //     : "刷新失败")
                                          //这个动画是需要做开始，停止操作的，这里没有处理，默认一直执行
                                          child: Text("帧动画"),
                                          // child: FrameAnimationImage(_keyGlobal,images, width: 50, height: 50, interval: 300,start: true,),
                                          //帧动画可以考虑使用gif图，上面的 animation.value.toInt() 有一些问题
                                          // child: Image.asset("images/zoulu.gif",width: 50,height: 50,),
                                        );
                                      }, onOffsetChange: (offset) {
                                        //do some ani
                                      }),
                                      footer: CustomFooter(
                                        builder: (BuildContext context,
                                            LoadStatus? mode) {
                                          Widget body;
                                          if (_model.hasData) {
                                            if (mode == LoadStatus.idle) {
                                              body = const Text("上拉加载");
                                            } else if (mode == LoadStatus.loading) {
                                              body = CupertinoActivityIndicator();
                                            } else if (mode == LoadStatus.failed) {
                                              body = const Text("加载失败！点击重试！");
                                            } else if (mode ==
                                                LoadStatus.canLoading) {
                                              body = const Text("松手,加载更多!");
                                            } else {
                                              body = const Text("没有更多数据了!");
                                            }
                                          } else {
                                            body = const Text("没有更多数据了!");
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
                                      child: StaggeredGrid.count(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        children: listViewItemWidget(
                                            _model.productList ?? []),
                                      ),
                                      // child: Text("dfd"),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(child: renderDropSelectMenu()),
                      ],
                    )
                  ],
                )
              ),


            ],
          ),
        ),
        // body: SingleChildScrollView(
        //   child:Column(),
        // ),
        appBar: CustomAppbar(
          title: "商品列表",
          context: context,
        ),
      ),
    );
  }

  DropSelectMenu renderDropSelectMenu() {
    return DropSelectMenu(
        maxMenuHeight: MediaQuery.of(context).size.height,
        menus: [
          DropSelectMenuBuilder(
              builder: (BuildContext context) {
                return Expanded(child: Text("sdfdsfg"));
              },
              height: MediaQuery.of(context).size.height),
          DropSelectMenuBuilder(
              builder: (BuildContext context) {
                return Text("sdfdsfg2");
              },
              height: MediaQuery.of(context).size.height),
          DropSelectMenuBuilder(
              builder: (BuildContext context) {
                return Text("sdfdsfg3");
              },
              height: 400),
          DropSelectMenuBuilder(
            builder: (BuildContext context) {
              return selectPage();
            },
          ),
        ]);
  }

  DropSelectHeader renderDropSelectHeader() {
    return DropSelectHeader(
      titles: ["综合", "最新", "价格", "筛选"],
      showTitle: (_, index) {
        switch (index) {
          case 0:
            return "综合";
          case 1:
            return "最新";
          case 2:
            return "价格";
          case 3:
            return "筛选";
        }
        return "综合";
      },
    );
  }

  Widget selectPage() {
    return Container(
      width: double.infinity,
      color: ColorConstant.color_ffffff,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Text("sdfdsf"),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: const [
                Expanded(child: Text("ss")),
                Expanded(child: Text("ss")),
                Expanded(child: Text("ss")),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listViewItemWidget(List<ProductList> productList) {
    List<Widget> widgetList = [];
    for (var productItem in productList) {
      Widget widget = ProductListAdapter(productItem);
      widgetList.add(widget);
    }
    return widgetList;
  }
}
