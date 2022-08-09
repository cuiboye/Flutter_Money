import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/channel/flutter_to_native_withdata.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:flutter_money/provide/provider_count_example/provider_count_example.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:provider/provider.dart';

/**
 * Flutter打开Native页面，Native将数据传递给Flutter
 */
class FlutterOpenNativePage extends StatefulWidget {
  @override
  FlutterOpenNativePageState createState() => FlutterOpenNativePageState();
}

class FlutterOpenNativePageState extends State<FlutterOpenNativePage> {
  String? _message;

  //打开Native页面
  static const MethodChannel _methodChannel =
      MethodChannel("flutter_open_native.android");

  BasicMessageChannel _basicMessageChannel =
      BasicMessageChannel('102', StandardMessageCodec());

  Future<void> setMessageHandler(var message) async {
    _basicMessageChannel.setMessageHandler((message) => Future<String?>(() {
          setState(() {
            _message = message;
          });
          return "收到Native的消息：" + message;
        }));
  }

  @override
  void initState() {
    super.initState();
    _basicMessageChannel
        .setMessageHandler((message) => setMessageHandler(message));
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "Flutter打开Native页面",
      home: Scaffold(
          appBar: CustomAppbar(
            context: context,
            title: "Flutter打开Native页面",
          ),
          body: Column(
            children: [
              ElevatedButton(
                child: Text("打开Native页面"),
                onPressed: () => openNativePage(),
              ),
              Text("$_message")
            ],
          )),
    );
  }

  //打开Native页面
  void openNativePage() {
    final result = _methodChannel.invokeMethod("openAndroidpage");
    print("$result");
  }
}
