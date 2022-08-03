import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/provide/provider_mvvm_example/service/joke_service.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:flutter_money/wajiu/view_model/orderlist_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/**
 * 订单item
 */
class OrderListItem extends StatefulWidget {
  @override
  _OrderListItemState createState() => _OrderListItemState();
}

List<String> list = ['a', 'b', 'c'];

class _OrderListItemState extends State<OrderListItem> {
  @override
  void initState() {
    JokeService.getOrderList(Provider.of<OrderListViewModel>(context, listen: false));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderListViewModel>(
        builder: (_, _orderListViewModel, child) {
          OrderListViewModel orderListViewModel = _orderListViewModel;
      return ListView.builder(
        //ListView嵌套ListView
          itemCount: orderListViewModel.orderList?.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _viewItem(orderListViewModel.orderList![index].goodsLists,orderListViewModel.orderList![index].totalPrice);
          });
    });
  }

  Widget _viewItem(List<GoodsLists> goodsLists,String totalPrice) {
    print("length==========>${goodsLists.length}");
    return Column(
      children: [
        topView(),
        centerListView(),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(), //设置内部ListView不可滚动
            itemCount: goodsLists.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return innerListViewItem(goodsLists);
            }),
        _totalMoney(totalPrice)
      ],
    );
  }

  //底部总额度
  Widget _totalMoney(String totalPrice){
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(child: Text("订单金额(总运费):¥$totalPrice"),margin: EdgeInsets.only(right: 13),),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: ColorUtil.color("#dfdfdf"),
            height: 8.h,
          )
        ],
      )
    );
  }

  Widget innerListViewItem(List<GoodsLists> goodsList) {
    return Container(
      height: 98.h,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.only(left: 13),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "http://image.59cdn.com/static/upload/image/product/20170711/o_1499751890519.jpg",
            width: 88.w,
            height: 88.h,
          ),
          Expanded(//占满剩余空间
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //Container分分布局
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("国王西拉干红葡萄酒_2015"),
                Container(
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //平分布局，两个View分别靠着左右边缘
                      children: [
                        Row(
                          children: [
                            Text(
                              "¥",
                              style:
                                  TextStyle(fontSize: 12.sp, color: Colors.red),
                            ),
                            Text(
                              "158.00",
                              style:
                                  TextStyle(fontSize: 14.sp, color: Colors.red),
                            ),
                            Text(
                              "/瓶",
                              style:
                                  TextStyle(fontSize: 13.sp, color: Colors.red),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 13),
                          child: Text(
                            "6支装x2箱",
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "折后单价",
                      style: TextStyle(fontSize: 12.sp, color: Colors.red),
                    ),
                    Text(
                      "108.00",
                      style: TextStyle(fontSize: 12.sp, color: Colors.red),
                    ),
                  ],
                ),
                Text(
                  "现货",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget topView() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 13),
            child:
                Text("165469846456455454", style: TextStyle(fontSize: 14.sp)),
          )),
          // border: new Border.all(width: 1, color: Colors.red),
          // borderRadius: BorderRadius.all(Radius.circular(4.0))
          Container(
              padding: EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 3),
              margin: EdgeInsets.only(right: 13),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Text("加入采购车",
                  style: TextStyle(fontSize: 11.sp, color: Colors.red)))
        ],
      ),
    );
  }

  Widget centerListView() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorUtil.color("#F9F9F9"),
              border:
                  Border(bottom: BorderSide(width: 1.h, color: Colors.black))),
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 13),
          width: double.infinity, //double.infinity：充满宽度
          child: Text(
            "已取消",
            style:
                TextStyle(fontSize: 11.sp, color: ColorUtil.color("#999999")),
          ),
        )
      ],
    );
  }
}
