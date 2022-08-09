import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:provider/provider.dart';


/**
 * Flutter将数据传递给Native
 */
class FlutterToNativeWithData extends StatelessWidget {
  BasicMessageChannel _basicMessageChannel = BasicMessageChannel('101', StandardMessageCodec());

  Future<void> messageHandler() async{
    print("Android你好，收到你的消息了");
  }

  var counter;
  @override
  Widget build(BuildContext context) {
    _basicMessageChannel.setMessageHandler((message) => messageHandler());

    counter = Provider.of<CountNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderCount，Flutter调用原生"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          counter.increment();
          sendMessage();
          },
        child: Icon(Icons.add),
      ),
      body: Center(
        //这里是子节点，当点击按钮后这里会进行刷新
        child: Text(counter.count.toString(),
          style: TextStyle(
              color: Colors.red,
              fontSize: 50
          ),
        ),
      ),
    );
  }

  //将消息发送到Native
  Future<void> sendMessage()async{
    var result = await _basicMessageChannel.send(counter.count.toString());
    print("收到Android的回执消息为：$result");
  }
}
