import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

/**
 * 极光推送
 */
class JiguangPushMain extends StatefulWidget {
  @override
  _JiguangPushMainState createState() => _JiguangPushMainState();
}

class _JiguangPushMainState extends State<JiguangPushMain> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context, title: "极光推送",),
        body: ElevatedButton(
          onPressed: ()=>startJiguangPush(),
          child: Text("开启极光推送"),
        )),
    );
  }

  void startJiguangPush(){
    JPush jpushTag =  JPush();
    jpushTag.setup(
        appKey: '03fe40aece7ccb8a95b48478',
        channel: 'developer-default',
        production: true,
        debug: true);
    /// 监听jpush
    jpushTag.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
        print('jpushTag接收到的数据为： + $message');
        // if (message.length > 0) G.hideMessage = true;
      },
      onOpenNotification: (Map<String, dynamic> message) async {
        /// 点击通知栏消息，跳转至消息列表页面
        // G.hideMessage = true;
        // G.pushNamed('/echo', callback: (val) => false);
      },
    );
  }
}
