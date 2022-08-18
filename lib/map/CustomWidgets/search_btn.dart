import 'package:flutter/material.dart';

typedef SearchBtnTapCallback = void Function();

class BMFSearchBtn extends StatelessWidget {
  final double? width;
  final double? height;
  final String? title;
  final TextStyle? titleTextStyle;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final SearchBtnTapCallback? onTap;

  const BMFSearchBtn({
    Key? key,
    this.width,
    this.height,
    this.title,
    this.titleTextStyle = _searchTextStyle,
    this.padding,
    this.color = Colors.transparent,
    this.borderRadius = 5.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: Alignment.center,
      child: ButtonTheme(
        minWidth: width ?? 50,
        height: height ?? 30,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.01),
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0.0))),
          ),

          child: Text(
            title ?? "",
            style: titleTextStyle,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

const _searchTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.blue,
);

