import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/dialog_utils.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/wajiu/service/balance_service.dart';
import 'package:flutter_money/wajiu/view_model/balance_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 我的余额
 */
class MyBalanceView extends StatefulWidget {
  @override
  _MyBalanceState createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalanceView> {
  int pageNum = 0;
  int pageSize = 10;

  late BalanceViewModel balanceViewModel;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    //mvvm+获取数据
    BalanceService.getBalanceData(Provider.of<BalanceViewModel>(context, listen: false),_refreshController,pageNum,pageSize,true);
    super.initState();
  }
  bool hasData = true;//下拉加载，是否还有数据

  void _onRefresh() async {
    pageNum = 0;
    BalanceService.getBalanceData(Provider.of<BalanceViewModel>(context, listen: false),_refreshController,pageNum,pageSize,true);
  }

  void _onLoading() async {
    pageNum ++;
    BalanceService.getBalanceData(Provider.of<BalanceViewModel>(context, listen: false),_refreshController,pageNum,pageSize,false);
  }


  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        title: "我的余额",
        home: Scaffold(
          appBar: CustomAppbar(
            title: '我的余额',
            context: context,
          ),
          body:SmartRefresher(
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
              child: CustomScrollView(
                slivers: [
                  headerWidget(),
                  listContentWidget()
                ],
              )
    )
        ));
  }
  
  Widget listContentWidget(){
    return Consumer<BalanceViewModel> (builder: (_, _balanceViewModel, child) {
      balanceViewModel = _balanceViewModel;
      return SliverList(delegate: SliverChildBuilderDelegate((content, index){
        balanceViewModel.setBalance(balanceViewModel.balanceList![index]);
        //判断是否还有数据
        hasData = balanceViewModel.hasData;
        return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10,left: 13),
                          child: Text(balanceViewModel.balanceList![index].content,style: TextStyle(color: ColorConstant.color_c343434),),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10,left: 13,top: 10),
                          child: Text(balanceViewModel.balanceList![index].time,style: TextStyle(color: ColorConstant.color_888888),),
                        )
                      ],
                    )),
                    Container(
                      margin: EdgeInsets.only(right: 13),
                      child: Text("+${balanceViewModel.balanceList![index].money}",style: TextStyle(fontWeight: FontWeight.bold,color: ColorConstant.systemColor),),
                    )
                  ],
                ),
                Container(
                  height: 0.5,
                  color: ColorConstant.color_888888,
                )
              ],
            )
        );
      },childCount: balanceViewModel.balanceList?.length??0));
    });
  }
  
  Widget headerWidget(){
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 1),
        padding: EdgeInsets.only(top: 18,bottom: 15),
        decoration: BoxDecoration(
            color: ColorConstant.systemColor
        ),
        child: Column(
          children: [
            Text("当前余额度",style: TextStyle(color: ColorConstant.color_ffffff,fontSize: 13),),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("100.00", style: TextStyle(
                          fontSize: 35, color: ColorConstant.color_ffffff)),
                      Image.asset(
                        "images/icon_right_arrow.png", width: 25, height: 25,)
                    ],
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    child: Text("提现",style: TextStyle(color: ColorConstant.color_ffffff),),
                    decoration: BoxDecoration(
                      color: ColorConstant.color_fc9a60,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    padding: EdgeInsets.only(top: 6,bottom: 6,left: 25,right: 25),
                    margin: EdgeInsets.only(right: 15),
                  ),
                  Container(
                    child: Text("充值",style: TextStyle(color: ColorConstant.color_ffffff),),
                    decoration: BoxDecoration(
                        color: ColorConstant.color_fc9a60,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    padding: EdgeInsets.only(top: 6,bottom: 6,left: 25,right: 25),
                    margin: EdgeInsets.only(left: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
