import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/dialog_utils.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/model/common_request_model.dart';
import 'package:flutter_money/wajiu/model/product_list_model.dart';
import 'package:flutter_money/wajiu/view/vp_list_demo_page.dart';
import 'package:flutter_money/wajiu/view/wajiu_goods_detail.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 挖酒-主页
 */
class PageItemMain extends StatefulWidget {
  @override
  _PageItemMainState createState() => _PageItemMainState();
  final String? info;

  PageItemMain({this.info});
}

class _PageItemMainState extends State<PageItemMain>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //保持页面状态
  List<ProductList> listData = []; //商品列表数据
  var imageList = [];
  int mCurrentPageNum = 0;
  bool hasData = true;//下拉加载，是否还有数据

  @override
  void initState(){
    super.initState();
    imageList = _getBannerDatas();

    _getProductListData(true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    _getProductListData(true);
    // if failed,use refreshFailed()
    if (mounted) setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
     _getProductListData(false);
     if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //获取安全区域
    final padding = MediaQuery.of(context).padding;

    return Container(
      color: ColorConstant.color_eeeeee,
      child: Column(
        children: [
          Container(
            //这是一个假的状态栏
            decoration: BoxDecoration(color: Colors.red),
            height: padding.top,
          ),
          Expanded(
             child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context,LoadStatus? mode){
                    Widget body;
                    if(hasData){
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
                    }else{
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
                child: _contentWidget()),
          )
        ],
      ),
    );
  }

  Widget _contentWidget(){
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
                    margin: EdgeInsets.only(
                        left: 30, top: 10, bottom: 10, right: 15),
                    decoration: BoxDecoration(
                        color: ColorUtil.color("#bdffffff"),
                        //设置边框,也可以通过 Border()的构造方法 分别设置上下左右的边框
                        border:
                        new Border.all(width: 1, color: Colors.red),
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.0))),
                    child: Row(
                      children: [
                        Icon(Icons.search),
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
            color: Colors.red,
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            //返回组件集合
            List.generate(1, (int index) {
              //返回 组件
              return Container(
                decoration: BoxDecoration(color: Colors.red),
                height: MediaQuery.of(context).size.width /
                    1.6666666666, //根据具体情况来设置比例
                width: MediaQuery.of(context).size.width,
                child: Swiper(
                  itemCount: imageList.length,
                  autoplay: true, //是否自动轮播
                  pagination: SwiperPagination(), //指示器
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      imageList[index],
                      fit: BoxFit.fitHeight,
                    );
                  },
                ),
              );
            }),
          ),
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
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, //每行三列
                      childAspectRatio: 1, //显示区域宽高相等
                    ),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return _getGridViewData();
                    }),
                GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, //每一行3个
                      childAspectRatio: 1.3 //宽高比为1
                  ),
                  children: [
                    Text("111112"),
                    Text("111112"),
                    Text("111112"),
                    Text("111112"),
                  ],
                )
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //Grid按4列显示
              mainAxisSpacing: 10.0, //item水平之间的距离
              crossAxisSpacing: 10.0, //item垂直方向的距离
              childAspectRatio: 1.3),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建子widget
              return Container(
                  child:
                  Center(child: Image.asset("images/image1.jpeg")));
            },
            childCount: 8,
          ),
        ),
        //在实际布局中，我们通常需要往 CustomScrollView 中添加一些自定义的组件，而这些组件并非都
        //有 Sliver 版本，为此 Flutter 提供了一个 SliverToBoxAdapter 组件，它是一个适配器：可
        //以将 RenderBox 适配为 Sliver。
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                //这里画了一条线
                decoration: BoxDecoration(color: Colors.grey),
                height: 1,
                width: MediaQuery.of(context).size.width, //宽度为屏幕的宽度
                margin: EdgeInsets.only(top: 10),
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      height: 30,
                      width: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //水平方向平分权重
                    children: [
                      Text("提现"),
                      Text("提现"),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
        SliverPadding(
          padding: EdgeInsets.only(left: 13, right: 13),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按4列显示
                mainAxisSpacing: 10.0, //item水平之间的距离
                crossAxisSpacing: 10.0, //item垂直方向的距离
                childAspectRatio: 0.8 //宽高比
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                //创建子widget
                return Container(child: _hotListItem(index));
              },
              childCount: listData.length,//GridView的数量
            ),
          ),
        ),
      ],
    );
  }

  Widget _hotListItem(int index) {
    return GestureDetector(
      onTap: () => {
        // DialogUtils.showAlertDialog(context,"确定要将该商品加入购物车吗?",(result){
        //   _addGoodToShopCar(index);
        // })
        GetNavigationUtils.navigateRightToLeft(WajiuGoodsDetail())
      },
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstant.color_ffffff,
            border: Border.all(width: 1, color: ColorConstant.color_ffffff),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Column(
          children: [
            Image(
              height: 140,
              image: NetworkImage(
                  "http://image.59cdn.com/static/upload/image/product/20220111/o_1641897087670.png"),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    '${listData[index].productName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  width: double.infinity,
                  child: Text("法国",
                      style: TextStyle(
                          color: ColorConstant.color_a4a5a7, fontSize: 11)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Text(
                        "¥",
                        style: TextStyle(
                            fontSize: 11, color: ColorConstant.systemColor),
                      ),
                      Text(
                        "36.0",
                        style: TextStyle(
                            fontSize: 16, color: ColorConstant.systemColor),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  List<String> _getBannerDatas() {
    var imageList = [
      './images/main_page_banner1.jpeg',
      './images/main_page_banner2.jpeg',
      './images/main_page_banner3.jpeg',
      './images/main_page_banner4.jpeg',
      './images/main_page_banner5.jpeg',
      './images/main_page_banner6.jpeg'
    ];
    return imageList;
  }

  Widget _getGridViewData() {
    return Column(children: [Icon(Icons.search), Text("dsfds")]);
  }

  //从接口获取数据
  void _getProductListData(bool isOnRefresh)  {
    var params = Map<String, dynamic>();
    if(isOnRefresh){
      listData.clear();
      mCurrentPageNum = 0;
      params["pageNum"]= mCurrentPageNum;
    }else{
      mCurrentPageNum++;
      params["pageNum"]= mCurrentPageNum;
    }
    params["pageSize"]= 10;
    DioInstance.getInstance().get(ApiService.findAllProduct, params,
        success: (json) {
      //注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      print("获取到的数据：$json");
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("获取到的数据_toLogin：$json");
      ProductListModel model = ProductListModel.fromJson(json);
      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          if (null != model.result) {
            setState(() {
              // listData = model.result.productList;
              hasData = model.result.productList.length<10?false:true;
              listData.addAll(model.result.productList);
              print("数组的长度为：${listData.length}");

            });
            //通知下，刷新成功
            if(isOnRefresh){
              _refreshController.refreshCompleted();
            }else{
              _refreshController.loadComplete();
            }
          }
        }
      }else{
        //通知下，刷新失败
        if(isOnRefresh){
          _refreshController.refreshFailed();
        }else{
          _refreshController.loadFailed();
        }
      }
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
      if(isOnRefresh){
        _refreshController.refreshFailed();
      }else{
        _refreshController.loadFailed();
      }
    });
  }

  //加入采购车
  void _addGoodToShopCar(int index) {
    var params = Map<String, dynamic>();
    params["productID"] = listData[index].productid;
    params["cangkuId"] = listData[index].cangkuId;
    params["productName"] = listData[index].productName;
    params["joinToShopCar"] = 1;
    DioInstance.getInstance().get(ApiService.addGoodToShopCar, params,
        success: (json) {
      //注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      print("获取到的数据：$json");
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("获取到的数据_toLogin：$json");
      CommonRequestModel model = CommonRequestModel.fromJson(json);
      if (null != model) {
        int status = model.states;
        String msg = model.msg;
        if (status == 200) {
          ToastUtils.showToast(msg);
        }
      }
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });
  }
}
