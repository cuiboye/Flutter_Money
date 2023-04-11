import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 挖酒-闪屏页
 */
class WajiuSplashPage extends StatefulWidget {
  @override
  _WajiuSplashPageState createState() => _WajiuSplashPageState();
}

class _WajiuSplashPageState extends State<WajiuSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "./images/launchimage.jpg",
      fit: BoxFit.fill,
    );
  }
}
