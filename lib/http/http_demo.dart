import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/http/user.dart';
import 'package:http/http.dart' as http;
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';
import 'CommonModel.dart';

class HttpDemo extends StatefulWidget {
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  var _content = "网络请求111111";

  @override
  Widget build(BuildContext context) {
    print("build");
    return CustomMaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GestureDetector(
              // onTap: ()=>fetchPost().then((value) => {//这样也可以
              onTap: () => fetchPost().then((CommonModel value) => {
                    //then表示成功的回调
                    print(value.title)
                  }),
              child: Text("$_content"),
            ),
            GestureDetector(
              // onTap: ()=>fetchPost().then((value) => {//这样也可以
              onTap: () => fetchPost2().then((User user) {
                setState(() {
                  _content = user.title;
                });
              }, onError: (e) {//如果catchError与onError同时存在，则会只调用onError；
                print('onError: $e');
              }).catchError((e) {
                print('catchError: $e');
              }).whenComplete(() => {
                //then().catchError()的模式类似于try-catch，try-catch有个finally代码块，而future.whenComplete就是Future的finally。
                //无论对错，都会执行whenComplete这个方法
              print('whenComplete')
              }).timeout(Duration(milliseconds: 1)),//设置超时，会报：ERROR:flutter/lib/ui/ui_dart_state.cc(198)] Unhandled Exception: TimeoutException after 0:00:00.001000: Future not completed
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: const Text("网络请求-序列化"),
              ),
            ),
            FutureBuilder<User>(
                future: fetchPost2(),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  print("===========$_content");
                  return Text('$_content');
                }),
          ],
        ),
        appBar:CustomAppbar(
          title: '网络请求',
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
    print(result);
    return CommonModel.fromJson(result);
  }

  //
  Future<User> fetchPost2() async {
    final response = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model1.json'));

    Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    print(result);
    return User.fromJson(result);
  }
}
