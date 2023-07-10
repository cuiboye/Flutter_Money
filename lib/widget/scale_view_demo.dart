import 'package:flutter/material.dart';
import 'package:flutter_money/view/scale_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

/**
 * 图片缩放
 */
class ScaleViewDemo extends StatelessWidget {
  const ScaleViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleView(
      minScale: .5,
      maxScale: 5,
      child:Image.network("https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg"),
    );
  }
}
