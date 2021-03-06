
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_android/url_launcher_android.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GestureDetector(
              onTap: ()=>_launchInBrowser(Uri.parse("http://www.baidu.com")),
              child: Text("打开浏览器"),
            )
          ],
        ),
        appBar:CustomAppbar(
          title: '打开浏览器',
          context: context,
        ),
      ),
    );
  }

  /**
   * ios可以打开浏览器，android直接报：Unhandled Exception: MissingPluginException(No implementation found for method launch on channel plugins.flutter.io/url_launcher_android)
   * 这个问题还没有解决
   */
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
