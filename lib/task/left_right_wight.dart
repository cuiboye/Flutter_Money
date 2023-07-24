import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnTap = void Function();

class LeftRightWiget extends StatefulWidget {
   String? leftText;
   String? rightText;
   OnTap? onTap;
   LeftRightWiget({this.leftText,this.rightText,this.onTap,Key? key}) : super(key: key);

  @override
  _LeftRightWigetState createState() => _LeftRightWigetState();
}
class _LeftRightWigetState extends State<LeftRightWiget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(
                width: 1.w,color: ColorConstant.color_323232
            ))
        ),
        padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 13.w),
        child: Row(
          children: [
            Text(widget.leftText ?? ""),
            Expanded(child:  Container(
              margin: EdgeInsets.only(left: 13.w),
              child: Text(widget.rightText ?? ""),
            ),),Text("sdfd")
          ],
        ),
      ),
    );
  }
}
