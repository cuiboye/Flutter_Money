import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CommonModel.dart';

class HttpDemo extends StatefulWidget {
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GestureDetector(
              // onTap: ()=>fetchPost().then((value) => {//这样也可以
              onTap: ()=>fetchPost().then((CommonModel value) => {//then表示成功的回调
                print(value.title)
              }),
              child: Text("打开浏览器"),
            )
          ],
        ),
        appBar: AppBar(
          title: Text("如何打开第三方应用?"),
        ),
      ),
    );
  }
  _requestData(){

  }
  Future<CommonModel> fetchPost() async {
    final response = await http.get(Uri.parse('http://www.devio.org/io/flutter_app/json/test_common_model.json'));

    Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    print(result);
    return CommonModel.fromJson(result);
  }
}
