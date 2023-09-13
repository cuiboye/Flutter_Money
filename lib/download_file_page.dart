import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

///文件下载
class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  String savedDir = '';
  // var url = "http://app01.78x56.com/Xii_2021-03-13%2010%EF%BC%9A41.ipa";
  var url =
      "https://image.59cdn.com/wajiucrmtestapk/wajiu_crm_test_update_481.apk";

  @override
  void initState() {
    super.initState();
    initDownloadManager();
  }

  void initDownloadManager() async {
    await getApplicationSupportDirectory()
        .then((value) => savedDir = value.path);
    // downloadInstance.rebuildInit(savedDir,url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        context: context,
        title: '文件下载',
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
          }, child: const Text('文件下载')),
          ElevatedButton(onPressed: () {
          }, child: const Text('暂停下载')),
          ElevatedButton(onPressed: () {
          }, child: const Text('继续下载'))
        ],
      ),
    );
  }
  //
  // Future<void> checkPessition() async {
  //   bool permition = await getPormiation();
  //   debugPrint("checkPessition()");
  //   if (permition) {
  //     if (Platform.isIOS) {
  //       var status = await Permission.photos.status;
  //       if (status.isGranted) {
  //         // Uint8List images = byteData!.buffer.asUint8List();
  //         // await ImageGallerySaver.saveImage(images, quality: 60, name: "customerinvitationcode");
  //         // EasyLoading.showToast("保存成功，请前往相册查看");
  //       }
  //       if (status.isDenied) {
  //         debugPrint("IOS拒绝");
  //       }
  //     } else {
  //       var status = await Permission.storage.status;
  //       if (status.isGranted) {
  //         debugPrint("Android已授权");
  //         // downloadFile(
  //         //     savedDir, url, downloadStatusCallback, downloadProgressCallback);
  //         downloadFile();
  //       }
  //     }
  //   } else {
  //     //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
  //     // savePhoto();
  //     debugPrint("未授权");
  //   }
  // }
  //
  // void downloadFile(){
  //   // Download
  //    request = DownloadManager.instance
  //       .download(url, path: savedDir+'/mmm');
  //
  //   // Listen
  //   request?.events.listen((event) {
  //     if (event is DownloadState) {
  //       print("event: $event");
  //       if (event == DownloadState.finished) dispose();
  //     } else if (event is double) {
  //       print("progress: ${(event * 100.0).toStringAsFixed(0)}%");
  //     }
  //   }, onError: (error) {
  //     print("error $error");
  //     dispose();
  //   });
  //
  // }
  //
  // Future<bool> getPormiation() async {
  //   debugPrint("getPormiation()");
  //   if (Platform.isIOS) {
  //     var status = await Permission.photos.status;
  //     if (status.isDenied) {
  //       debugPrint('getCorporation() ios');
  //       await [
  //         Permission.photos,
  //       ].request();
  //       // saveImage(globalKey);
  //     } else {
  //       debugPrint('getCorporation() ios2');
  //     }
  //     debugPrint('${status.isGranted}');
  //     return status.isGranted; //true的话说明已经申请权限
  //   } else {
  //     debugPrint('getCorporation() Android');
  //     var status = await Permission.storage.status;
  //     if (status.isDenied) {
  //       await [
  //         Permission.storage,
  //       ].request();
  //     }
  //     return status.isGranted;
  //   }
  // }
}

