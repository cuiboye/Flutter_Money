import 'package:flutter/material.dart';

extension ExtString on String {
  /// 是否是Http路径
  bool get isHttpPath => startsWith('http://') || startsWith('https://');

  /// 文本段落的尺寸
  Size computeParagraphSize({
    required TextStyle textStyle,
    TextAlign textAlign = TextAlign.left,
    TextDirection textDirection = TextDirection.ltr,
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    assert(minWidth >= 0.0);
    assert(maxWidth >= minWidth);

    if (isEmpty) {
      return Size.zero;
    }

    final TextPainter painter = TextPainter(
      text: TextSpan(text: this, style: textStyle),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
    );

    painter.layout(minWidth: minWidth, maxWidth: maxWidth);
    return painter.size;
  }

  /// 判断是否为手机号
  bool isChinaPhoneNumber() {
    if (isEmpty) {
      return false;
    }

    //手机正则验证
    String regexPhoneNumber =
        "^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$";
    return RegExp(regexPhoneNumber).hasMatch(this);
  }

  /// 判断是否为中文
  bool isChinese() {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(this) ||
        RegExp(r"[。？！，、；：“”（）《》【】「」]").hasMatch(this);
  }

  /// 是否包含中英文
  bool isContainCnAndEn() {
    return contains(RegExp('^[a-zA-Z]+')) && isChinese();
  }

  /// 返回字符串长度（中文占2）
  int numOfChinese() {
    int count = 0;
    for (int i = 0; i < length; i++) {
      String newValue = this[i];
      if (newValue.isChinese()) {
        count += 2;
      } else {
        count++;
      }
    }
    return count;
  }

  /// 返回含有汉字截取后的字符串（中文占2）
  String subStrWithChinese(int index) {
    int count = 0;
    if (numOfChinese() <= index) {
      return this;
    }
    for (int i = 0; i < length; i++) {
      String newValue = this[i];
      if (newValue.isChinese()) {
        count += 2;
      } else {
        count++;
      }
      if (count > index) {
        return substring(0, i);
      }
    }
    return this;
  }

  /// 生成Text
  Text text({
    TextAlign? textAlign,
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? height,
    String? fontFamily,
    int? maxLines,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      style: textStyle ??
          TextStyle(
            color: color ?? Colors.black,
            fontSize: fontSize,
            fontWeight: fontWeight,
            overflow: overflow,
            height: height,
            fontFamily: fontFamily ?? 'PingFang SC',
          ),
    );
  }
}
