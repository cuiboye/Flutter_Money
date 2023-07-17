import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
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
  WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWebController();
  }
  void _initWebController() {
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setBackgroundColor(ColorConstant.color_ffffff);
    _controller.addJavaScriptChannel("000", onMessageReceived: (JavaScriptMessage message){
      //JS调用Flutter代码的时候执行
      // 这里接收到的就是 js 中发送过来的message。 和js里MessageDeal.postMessage(message) 中的message 对应 。
      // 可以根据message来做一些相应的处理
      print(
          "${message.toString()},  ${message.hashCode}, message: ${message.message}");
      // 收到消息后回复一个消息给js那边，Flutter调用JS的方法
      _controller.runJavaScript("showMessage ('我（Flutter）收到了你的消息[${message.message}].)");
    });
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (WebResourceError error) {
          print("${error.description}");
        },
        onPageFinished: (String url) {
          print("加载完成 $url");
          _loadTitle();//获取页面的标题
        },
        onPageStarted: (String url) {
          print("开始加载 $url");
        },
        onProgress: (int progress) {
          print("加载进度：$progress");
        },
        onNavigationRequest: (NavigationRequest request) {
          // 可以通过判断来实现是否阻止导航到下一个页面
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   return NavigationDecision.prevent;//阻止导航
          // }
          return NavigationDecision.navigate;//允许进行导航
        },
      ),
    );

    // _controller.loadRequest(Uri.parse('http://h5test.wajiu.com/'));
    _controller.loadFile(getAssetsPath("assets/files/good_detail.html"));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: CustomMaterialApp(
      title: "WebView以及和JS交互",
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _controller
                  .runJavaScript('callJS("visible")') //这里是Flutter调用JS的方法
                  ?.then((result) {
                // You can handle JS result here.
              });
            },
            child: const Text('Flutter调用JS'),
          ),
          appBar: CustomAppbar(context: context, title: "WebView以及和JS交互"),
          body: WebViewWidget(controller: _controller)),
    ), onWillPop: ()=>_exitApp(context),);
  }

  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }

  //页面是否可以回退
  Future<bool> _exitApp(BuildContext context) async {
    print("666");
    if(null == _controller){
      print("_controller为空");
    }
    if (await _controller!.canGoBack()) {
      // 查看  history 有没有可以返回的  如果有  则返回 history
      print("onwill goback");
      print("进来里唯一返回的");
      _controller!.goBack(); // history 返回
      return Future.value(false);
    } else {
      print("这里history没有返回的");
      debugPrint("_exit will not go back");
      return Future.value(true);
    }
  }

  // 获取页面的title
  Future<void> _loadTitle() async {
    final String? temp = await _controller?.getTitle();
    print('title: $temp');
    setState(() {
    });
  }
}
