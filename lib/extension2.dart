//扩展方法
import 'dart:ui';

//这个文件用于测试扩展方法同名的情况
extension StringExtension2 on String {
  //字符转换成Color对象
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}