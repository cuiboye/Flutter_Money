import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/wajiu/model/wajiu_product_list_model.dart';

class OrderListItemPage extends StatefulWidget {
  String listItemTitleName;
  OrderListItemPage(this.listItemTitleName) ;
  @override
  _OrderListItemPageState createState() => _OrderListItemPageState();
}

class _OrderListItemPageState extends State<OrderListItemPage> {
  @override
  void initState() {
    super.initState();
    getListData(){}
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 13,right: 13),
                child: Row(
                  children: [
                    Expanded(child: Text("JL23042113281990261")),
                    Text("加入购物车")
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text("dsfs");
                },
                itemCount: 5,
              )
            ],
          );
        },
        itemCount: 5,
      )
    );
  }
  //
  // List<Widget> secondListViewItem(){
  //
  // }
}

