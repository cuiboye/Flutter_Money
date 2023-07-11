import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:get/get.dart';
import 'package:mxxd/network/wj_network.dart';
import 'package:mxxd/pages/protocol/protocol_model.dart';
import 'package:mxxd/res/res.dart';
import 'package:mxxd/widget/wj_page_status.dart';
import 'package:webview_flutter/webview_flutter.dart';

///WebView控制器
class MyWebViewController extends GetxController{
  String? title;
  String? content;
  WebViewController controller = WebViewController();

  @override
  void onInit() {
    super.onInit();
    _initWebController();
  }
  // initialUrl: "http://h5test.wajiu.com/",//这个链接中包含了图片和视频
  // initialUrl: "https://blog.csdn.net/MoonAndroid/article/details/121414901",//这个链接中包含了图片和视频
  // initialUrl: getAssetsPath("assets/files/good_detail.html"),//这个链接中包含了图片和视频
  //   initialUrl: getAssetsPath("assets/files/helloword.html"),//这个链接是测试Fluttter调用JS
  // initialUrl: getAssetsPath("assets/files/js_flutter.html"),
  //这个链接是测试JS调用Flutter，加载本地html在Android手机没有问题，IOS手机显示空白。如果遇到这种需求可以使用Html插件来尝试
  void _initWebController() {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(ColorConstant.color_ffffff);
    controller.addJavaScriptChannel("000", onMessageReceived: (JavaScriptMessage message){
      //JS调用Flutter代码的时候执行
      // 这里接收到的就是 js 中发送过来的message。 和js里MessageDeal.postMessage(message) 中的message 对应 。
      // 可以根据message来做一些相应的处理
      print(
          "${message.toString()},  ${message.hashCode}, message: ${message.message}");
      // 收到消息后回复一个消息给js那边，Flutter调用JS的方法
      controller.runJavaScript("showMessage ('我（Flutter）收到了你的消息[${message.message}].)");
    });
    controller.setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (WebResourceError error) {
          print("${error.description}");
        },
        onPageFinished: (String url) {
          print("加载完成 $url");
        },
        onPageStarted: (String url) {
          print("开始加载 $url");
        },
        onProgress: (int progress) {
          print("加载进度：$progress");
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }


  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }

  //页面是否可以回退
  Future<bool> _goBack(BuildContext context) async {
    if (controller != null && await controller!.canGoBack()) {
      controller?.goBack();
      return false;
    }
    return true;
  }

  Future<bool> _exitApp(BuildContext context) async {
    print("666");
    if(null == _controller){
      print("_controller为空");
    }
    if (await _controller!.canGoBack()) {
      // 查看  history 有没有可以返回的  如果有  则返回 history
      print("onwill goback");
      print("进来里唯一返回的");
      controller!.goBack(); // history 返回
      return Future.value(false);
    } else {
      print("这里history没有返回的");
      debugPrint("_exit will not go back");
      return Future.value(true);
    }
  }

  // 获取页面的title
  Future<void> _loadTitle() async {
    final String? temp = await controller?.getTitle();
    print('title: $temp');
  }
}
