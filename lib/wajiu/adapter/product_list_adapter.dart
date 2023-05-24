import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/wajiu/model/wajiu_product_list_model.dart';

class ProductListAdapter extends StatefulWidget {
  ProductList productListItem;
  ProductListAdapter(this.productListItem) ;
  @override
  _ProductListAdapterState createState() => _ProductListAdapterState();
}

class _ProductListAdapterState extends State<ProductListAdapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: listViewItemWidget(widget.productListItem),
    );
  }

  Widget listViewItemWidget(ProductList productListItem) {
    Widget widget = Stack(
      children: [
        Container(

          decoration: BoxDecoration(
              color: ColorConstant.color_ffffff,
              border: Border.all(width: 1,color: ColorConstant.color_ffffff),//边框
              borderRadius: BorderRadius.all(Radius.circular(3.0))//边框圆角
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                child: CacheImageViewWithHeight(url: "${productListItem?.picture}?imageView2/2/w/740/h/314/q/100"??"",
                  height:160,),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8,left: 13,right: 13),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productListItem?.cname??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: ColorConstant.color_343434),),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(productListItem?.ename??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: ColorConstant.color_343434)),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8,left: 13,right: 13),
                child: Row(
                  children: [
                    Expanded(child: Text(productListItem?.countryName??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: ColorConstant.color_a4a5a7))),
                    Expanded(child:Text(productListItem?.grade??"",textAlign: TextAlign.right,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: ColorConstant.color_a4a5a7)),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13,top: 8,bottom: 13),
                child: Row(
                  children: [
                    Text(productListItem?.priceDesc??"",style: TextStyle(fontSize: 14,color: ColorConstant.systemColor),),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 8),
          child: ListView.builder(
              itemCount: productListItem.productMarksImg.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.topLeft,
                  child: CacheImageViewWithHeight(url: productListItem?.productMarksImg[index]??"",height: 15,),
                );
              }),
        )
      ],
    );
    return widget;
  }

}

