import 'package:flutter/material.dart';
import 'package:flutter_money/channel/flutter_to_native_withdata.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:flutter_money/provide/provider_count_example/provider_count_example.dart';
import 'package:provider/provider.dart';

class FlutterToNativeWithDataMain extends StatefulWidget {
  @override
  _ProvideDemoState createState() => _ProvideDemoState();
}

class _ProvideDemoState extends State<FlutterToNativeWithDataMain> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create为监听的模型
      create: (_) => CountNotifier(),
      child: FlutterToNativeWithData()
    );
  }
}
