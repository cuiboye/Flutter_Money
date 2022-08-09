
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/channel/flutter_open_native_page.dart';
import 'package:flutter_money/channel/flutter_to_native_withdata_main.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * Flutter和Native通信
 */
class ChannerMain extends StatefulWidget {
  @override
  _ChannerMainState createState() => _ChannerMainState();
}

class _ChannerMainState extends State<ChannerMain> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "Flutter和Native通信",
      home: Scaffold(
        appBar: CustomAppbar(context: context,
        title: "Flutter和Native通信"),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: ()=>GetNavigationUtils.navigateRightToLeft(FlutterToNativeWithDataMain()),
                child: Text("Flutter将数据传递给Native")
            ),
            ElevatedButton(
                onPressed: ()=>GetNavigationUtils.navigateRightToLeft(FlutterOpenNativePage()),
                child: Text("Flutter打开原生页面")
            )
          ],
        ),
      ),
    );
  }
}
