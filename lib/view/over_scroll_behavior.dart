import 'dart:io';

import 'package:flutter/material.dart';

/**
 * 去除ListView的水波纹,3.0不生效了
 */
class OverScrollBehavior extends ScrollBehavior{
  // @override
  // Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
  //   if(Platform.isIOS){
  //     return child;
  //   }else if(Platform.isAndroid || Platform.isFuchsia){
  //     return GlowingOverscrollIndicator(
  //       child: child,
  //       //不显示头部水波纹
  //       showLeading: false,
  //       //不显示尾部水波纹
  //       showTrailing: false,
  //       axisDirection: axisDirection,
  //       color: Theme.of(context).canvasColor,
  //     );
  //   }
  // }
}
