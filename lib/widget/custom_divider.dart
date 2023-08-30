import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 分隔线
class DividerHorizontal extends StatelessWidget {
  const DividerHorizontal(
      {Key? key,
      this.padding,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom,
      this.height,
      this.color})
      : super(key: key);

  final EdgeInsetsGeometry? padding;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
              left: paddingLeft ?? 0,
              top: paddingTop ?? 0,
              right: paddingRight ?? 0,
              bottom: paddingBottom ?? 0),
      child: SizedBox(
        height: height ?? 0.5.w,
        width: double.infinity,
        child: ColoredBox(
          color: color ?? ColorConstant.gray300,
        ),
      ),
    );
  }
}

/// 垂直分隔线
class DividerVertical extends StatelessWidget {
  const DividerVertical(
      {Key? key,
      this.padding,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom,
      required this.height,
      this.color,
      this.width})
      : super(key: key);

  final EdgeInsetsGeometry? padding;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;
  final double height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
              left: paddingLeft ?? 0,
              top: paddingTop ?? 0,
              right: paddingRight ?? 0,
              bottom: paddingBottom ?? 0),
      child: SizedBox(
        height: height,
        width: width ?? 0.5.w,
        child: ColoredBox(
            // static const Color gray300 = Color(0xFFE0E0E0);
        color: color ?? ColorConstant.gray300,
        ),
      ),
    );
  }
}
