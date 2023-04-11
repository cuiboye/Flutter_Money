import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

/**
 * 商品详情页-banner自定义小圆点
 */
class NLIndicator extends StatelessWidget{
  var _currentIndex;
  var _count;
  NLIndicator(this._currentIndex, this._count);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_count, (index){
          return _currentIndex == index ? Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: ColorConstant.systemColor,
                borderRadius: BorderRadius.circular(4)
            ),
          ) : Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: ColorConstant.color_80ffffff,
                borderRadius: BorderRadius.circular(20)
            ),
          );
        }),
      )
    );
  }
}