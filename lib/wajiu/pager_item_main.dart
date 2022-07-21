import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../view/custom_materialapp.dart';

/**
 * 挖酒-主页
 */
class PageItemMain extends StatefulWidget {
  @override
  _PageItemMainState createState() => _PageItemMainState();
  final String? info;

  PageItemMain({this.info});
}

class _PageItemMainState extends State<PageItemMain> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;//保持页面状态

  var imageList = [];
  @override
  void initState() {
    super.initState();
    imageList = _getBannerDatas();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //获取安全区域
    final padding = MediaQuery.of(context).padding;

    return Column(
      children: [
        Container(//这是一个假的状态栏
          decoration: BoxDecoration(color: Colors.red),
          height: padding.top,
        ),
        Expanded(child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  children: [
                    Expanded(child: Container(
                      padding: EdgeInsets.only(top: 5,left: 10,bottom: 5),
                      margin: EdgeInsets.only(left: 30,top: 10,bottom: 10,right: 15),
                      decoration: BoxDecoration(
                          color: ColorUtil.color("#bdffffff"),
                          //设置边框,也可以通过 Border()的构造方法 分别设置上下左右的边框
                          border: new Border.all(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("搜索一下",style: TextStyle(fontSize: 12,color: ColorUtil.color("#a3a2a2"))),
                          )
                        ],
                      ),
                    ),),
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
                    height:MediaQuery.of(context).size.width / 1.6666666666,//根据具体情况来设置比例
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      itemCount: imageList.length,
                      autoplay: true,//是否自动轮播
                      pagination: SwiperPagination(),//指示器
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(imageList[index],
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
                height:200,
                child: PageView(//这里PageView必须设置个高度，否则会报错，暂时没有解决办法
                  scrollDirection: Axis.horizontal,
                  children: [
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, //每行三列
                          childAspectRatio: 1, //显示区域宽高相等
                        ),
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return _getGridViewData();
                        }),
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,//每一行3个
                          childAspectRatio: 1.3//宽高比为1
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
                mainAxisSpacing: 10.0,//item水平之间的距离
                crossAxisSpacing: 10.0,//item垂直方向的距离
                childAspectRatio: 1.3
              ),

              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建子widget
                  return Container(
                    child: Center(
                      child: Image.asset("images/image1.jpeg")
                    )
                  );
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
                  Container(//这里画了一条线
                    decoration: BoxDecoration(color: Colors.grey),
                    height: 1,
                    width: MediaQuery.of(context).size.width,//宽度为屏幕的宽度
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,//水平方向平分权重
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
                padding: EdgeInsets.only(top: 10,bottom: 10),
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
              )
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ))
      ],
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
    return Column(
        children: [
        Icon(Icons.search),
    Text("dsfds")
    ]);
  }
}
