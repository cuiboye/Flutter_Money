import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view/joke_view.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:path_provider/path_provider.dart';

/**
 * 文件操作
 * 参考链接：https://liujunmin.com/flutter/io/path_provider.html
 */
class FileExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Jimi";
    writeString(name);

    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,
          title: "文件操作",

        ),
        body: Text("文件操作",style: TextStyle(fontSize: 12,color: ColorUtil.color("#333333")))
      ),
    );
  }
}

/// 写入数据
Future<void> writeString(String name) async {
  final file = await _getLocalDocumentFile();
  await file.writeAsString(name);

  final file1 = await _getLocalTemporaryFile();
  await file1.writeAsString(name);

  final file2 = await _getLocalSupportFile();
  await file2.writeAsString(name);
  print("写入成功");
}

/// 获取文档目录文件
Future<File> _getLocalDocumentFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/str.txt');
}

/// 获取临时目录文件
Future<File> _getLocalTemporaryFile() async {
  final dir = await getTemporaryDirectory();
  return File('${dir.path}/str.txt');
}

/// 获取应用程序目录文件
Future<File> _getLocalSupportFile() async {
  final dir = await getApplicationSupportDirectory();
  return File('${dir.path}/str.txt');
}
