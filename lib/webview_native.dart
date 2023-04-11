import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * WebView的使用和js交互
 * 1)注意，IOS设置运行的话需要在Runner的info.plist中添加如下：
 * <key>io.flutter.embedded_views_preview</key>
 * <string>YES</string>
 * 2)Flutter调用JS，JS调用Flutter参考链接：
 * https://www.jianshu.com/p/d9327b3c2b29
 */
class WebViewNativeDemo extends StatefulWidget {
  @override
  _WebViewNativeDemoState createState() => _WebViewNativeDemoState();
}

class _WebViewNativeDemoState extends State<WebViewNativeDemo> {
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "WebView以及和JS交互",
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _controller
                  ?.evaluateJavascript('callJS("visible")')//这里是Flutter调用JS的方法
                  ?.then((result) {
                // You can handle JS result here.
              });
            },
            child: Text('Flutter调用JS'),
          ),
        appBar: CustomAppbar(context: context,
        title: "WebView以及和JS交互"),
        body:WebView(
          initialUrl: getAssetsPath("assets/files/good_detail.html"),//这个链接中包含了图片和视频
          //   initialUrl: getAssetsPath("assets/files/helloword.html"),//这个链接是测试Fluttter调用JS
          //   initialUrl: getAssetsPath("assets/files/js_flutter.html"),//这个链接是测试JS调用Flutter
            //JS执行模式 是否允许JS执行
            javascriptMode: JavascriptMode.unrestricted,
          onWebResourceError: (WebResourceError error){
              print("${error.description}");
          },
          onPageFinished: (String url){
            print("$url");
          },
          onWebViewCreated: (WebViewController controller){
            print("加载完成");
          },
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
                name: "Hello",
                onMessageReceived: (JavascriptMessage message) {
                  // 这里接收到的就是 js 中发送过来的message。 和js里MessageDeal.postMessage(message) 中的message 对应 。
                  // 可以根据message来做一些相应的处理
                  print("${message.toString()},  ${message.hashCode}, message: ${message.message}") ;
                  // 收到消息后回复一个消息给js那边
                  _controller?.evaluateJavascript("showMessage ('我（Flutter）收到了你的消息[${message.message}].)");
                }),
          ].toSet(),
        )
      ),
    );
  }

  //通过下面的代码可以使Android和IOS加载本地代码，这里只测试了Android的加载功能，IOS网上提示还需要修改
  //Plugin FlutterWebView.m代码，比较麻烦，就不在IOS设备上测试了
  //assets/files/helloword.html
  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }
}
