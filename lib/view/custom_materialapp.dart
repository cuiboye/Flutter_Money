import 'package:flutter/material.dart';

/**
 * 自定义MaterialApp
 */
class CustomMaterialApp extends StatefulWidget {
  String? title;
  ThemeData? theme;
  Widget? home;
  Map<String, WidgetBuilder>? routes;

  CustomMaterialApp({this.title, this.theme, this.home, this.routes});

  @override
  _CustomMaterialAppState createState() => _CustomMaterialAppState();
}

class _CustomMaterialAppState extends State<CustomMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //去除右上角的"DEBUG"标签
      title: widget.title ?? "",
      theme: widget.theme ??
          ThemeData(
            primarySwatch: Colors.red,
          ),
      home: widget.home,
      routes: widget.routes ?? <String, WidgetBuilder>{},
    );
  }
}
