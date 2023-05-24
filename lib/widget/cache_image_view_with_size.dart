import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/**
 * 图片缓存,可以设置大小，只需要设置宽度就可以，设置了宽度高度也可以自适应
 */
class CacheImageViewWithWidth extends StatelessWidget {
  final String url;
  final double radius;
  final double width;
  final BoxFit? boxFit;

  const CacheImageViewWithWidth(
      {required this.url,
      this.radius = 0,
      this.width = 0,
      this.boxFit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset("images/wajiu_default_image_bg.9.png");
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: url,
          width: width,
          // 占位
          placeholder: (
            BuildContext context,
            String url,
          ) => Image.asset("images/wajiu_default_image_bg.9.png"),
          // 加载出错
          errorWidget: (
            BuildContext context,
            String url,
            dynamic error,
          ) => Image.asset("images/wajiu_default_image_bg.9.png"),
        ));
  }
}

class CacheImageViewWithHeight extends StatelessWidget {
  final String url;
  final double radius;
  final double height;
  final BoxFit? boxFit;

  const CacheImageViewWithHeight(
      {required this.url,
        this.radius = 0,
        this.height = 0,
        this.boxFit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset("images/wajiu_default_image_bg.9.png");
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: url,
          height: height,
          // 占位
          placeholder: (
              BuildContext context,
              String url,
              ) => Image.asset("images/wajiu_default_image_bg.9.png"),
          // 加载出错
          errorWidget: (
              BuildContext context,
              String url,
              dynamic error,
              ) => Image.asset("images/wajiu_default_image_bg.9.png"),
        ));
  }
}