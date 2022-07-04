import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';
import 'CommonModel.dart';

/**
 * FutureBuilder使用
 * 1)FurureBuilder的构造方法
 * FutureBuilder({Key? key,this.future,this.initialData,required this.builder})
 *  future： Future对象表示此构建器当前连接的异步计算；
    initialData： 表示一个非空的Future完成前的初始化数据；
    builder： AsyncWidgetBuilder类型的回到函数，是一个基于异步交互构建widget的函数；

    这个builder函数接受两个参数BuildContext context 与 AsyncSnapshot<T> snapshot，它返回一个widget。AsyncSnapshot包含异
    步计算的信息，它具有以下属性：

    connectionState - 枚举ConnectionState的值，表示与异步计算的连接状态，ConnectionState有四个值：none，waiting，active和done；

    // 当前没有异步任务，比如[FutureBuilder]的[future]为null时
    none,
    // 异步任务处于等待状态
    waiting,
    // Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
    active,
    // 异步任务已经终止.
    done,

    AsyncSnapshot还具有hasData和hasError属性，以分别检查它是否包含非空数据值或错误值。
    data - 异步计算接收的最新数据；
    error - 异步计算接收的最新错误对象；

    现在我们可以看到使用FutureBuilder的基本模式。 在创建新的FutureBuilder对象时，我们将Future对象作为要处理的异
    步计算传递。 在构建器函数中，我们检查connectionState的值，并使用AsyncSnapshot中的数据或错误返回不同的窗口小部件。
 */
class FutureBuilderDemo extends StatefulWidget {
  @override
  _FutureBuilderDemoState createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Center(
          child:FutureBuilder<CommonModel>(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
              //请求已经结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  print("请求Error，Error为：${snapshot.error}");
                  return Text("Error : ${snapshot.error}");
                } else {
                  print("请求成功，数据为：${snapshot.data}");
                  // 请求成功，显示数据
                  return Text("Contents: ${snapshot.data?.title}");
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ),
        appBar:CustomAppbar(
          title: 'FutureBuilder使用',
          context: context,
        ),
      ),
    );
  }

  Future<CommonModel> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json'));

    Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    print("futurebuild data $result");
    return CommonModel.fromJson(result);
  }
}
