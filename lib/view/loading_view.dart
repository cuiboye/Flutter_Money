import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/animation/custom_animation.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:get/get.dart';

/**
 * Loading加载圈
 */
class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    //Loading监听回调
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
    });
    super.initState();
  }

  @override
  void dispose() {
    //移除Loading监听回调
    EasyLoading.removeAllCallbacks();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "Loading",
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  EasyLoading.show(status: 'loading...');
                },
                child: Text("loading")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.showProgress(0.3, status: 'downloading...');
                },
                child: Text("showProgress")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.showSuccess('Great Success!');
                },
                child: Text("showSuccess")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.showError('Failed with Error');
                },
                child: Text("showError")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.showInfo('Useful Information.');
                },
                child: Text("showInfo")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.showToast('Toast');
                },
                child: Text("showToast")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.dismiss();
                },
                child: Text("dismiss")),
            Container(
              height: Get.height * 0.7,
            )
          ],
        ),
      ),
    );
  }
}
