import 'package:flutter/material.dart';

class NetImageView extends StatelessWidget {
  final String url;
  final double radius;
  final BoxFit? boxFit;
  final double width;
  final double height;

  const NetImageView({required this.url, this.radius = 0,this.height = 0,this.width = 0,this.boxFit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    print("NetImageView-build");
    if(url.isEmpty){
      return Image.asset("images/wajiu_default_image_bg.9.png");
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        placeholder: "images/wajiu_default_image_bg.9.png",
        width: width,
        image: url,
        fit: boxFit,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset("images/wajiu_default_image_bg.9.png");
        },
      ),
    );
  }
}
