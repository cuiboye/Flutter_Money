import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/sliver_list_demo_page.dart';

class ShopCartItem extends StatefulWidget {
  @override
  _PageViewItemState createState() => _PageViewItemState();
  final String? info;
  ShopCartItem({this.info});
}

class _PageViewItemState extends State<ShopCartItem> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;//保持页面状态

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "登录",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(context: context,title: "采购车",showLeftArrow: false,),
        // body: VerificationCodeInputDemoPage(),
        body: SliverListDemoPage(),
      ),
    );
  }
}
