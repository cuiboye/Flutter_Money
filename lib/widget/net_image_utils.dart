import 'package:flutter/material.dart';

class NetImageView extends StatelessWidget {
  final String url;
  final double radius;

  const NetImageView({required this.url, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        placeholder: "images/wajiu_default_image_bg.9.png",
        image: url,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset("images/wajiu_default_image_bg.9.png");
        },
      ),
    );
  }
}
