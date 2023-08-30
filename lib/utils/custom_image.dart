import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/ext_string.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

class CustomImage extends StatelessWidget {
  CustomImage({
    Key? key,
    required this.uri,
    this.width,
    this.height,
    this.fit,
    this.cacheWithSizeRatio,
    this.imageInfo,
    this.maxWidth,
    this.maxHeight,
  })  : _isNetwork = uri.isHttpPath,
        _isAsset = uri.startsWith('images'),
        _isFile = !uri.isHttpPath && !uri.startsWith('images'),
        super(key: key);

  final String uri;
  final bool _isNetwork;
  final bool _isAsset;
  final bool _isFile;
  final double? width;
  final double? height;
  final int? maxWidth;
  final int? maxHeight;
  final BoxFit? fit;
  final double? cacheWithSizeRatio;
  final Function(ImageInfo imageInfo)? imageInfo;

  @override
  Widget build(BuildContext context) {
    Image? image;
    if (_isNetwork) {
      image = Image(
          image: CachedNetworkImageProvider(uri,
              maxWidth: maxWidth, maxHeight: maxHeight),
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: width,
              height: height ?? 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.systemColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            return Container(
              color: Colors.red,
              width: width,
              height: height,
            );
          });
    } else if (_isAsset) {
      int? cachedWidth;
      int? cachedHeight;
      double ratio =
          cacheWithSizeRatio ?? View.of(context).devicePixelRatio * 1.5;
      if (width != null && width! > 0) {
        cachedWidth = (width! * ratio).toInt();
      }
      if (cachedWidth == null && height != null && height! > 0) {
        cachedHeight = (height! * ratio).toInt();
      }
      image = Image.asset(uri,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: cachedWidth,
          cacheHeight: cachedHeight);
    } else if (_isFile) {
      image = Image.file(File(uri), fit: fit, width: width, height: height);
    }
    image?.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      imageInfo?.call(image);
    }));
    return image ?? const SizedBox();
  }
}

class CustomImageHero extends StatelessWidget {
  const CustomImageHero({
    Key? key,
    required this.uri,
    required this.width,
    this.imageInfo,
    this.fit,
  }) : super(key: key);

  final String uri;
  final double width;
  final BoxFit? fit;
  final Function(ImageInfo imageInfo)? imageInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: uri,
        child: CustomImage(
          uri: uri,
          width: width,
          fit: fit ?? BoxFit.fitWidth,
          imageInfo: imageInfo,
        ),
      ),
    );
  }
}
