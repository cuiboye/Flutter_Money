import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_list_model.dart';
import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';
import 'dart:convert';

/**
 * 第三方网络请求框架Dio的使用
 */
class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  Dio _dio = new Dio();
  late Future<List<ListData>?> _future;
  // get请求
  // http://192.168.5.199:8082/danyuan/getBaokuanzhijiang?page=1
  @override
  void initState() {
    super.initState();
    _future = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio使用'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<ListData>?>(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<List<ListData>?> snapshot) {
              //请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                //发生错误
                if (snapshot.hasError) {
                  // return Text(snapshot.error.toString());
                  return Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Center(
                            child: Text("出错了,请重试！"),
                          ),
                          onTap: () => refresh(),
                        ),
                      )
                    ],
                  );
                }
                List<ListData>? list = snapshot.data;

                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return RefreshIndicator(
                    child: buildListView(context, list),
                    onRefresh: refresh);
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  //刷新数据,重新设置future就行了
  Future refresh() async {
    setState(() {
      _future = getdata();
    });
  }

  buildListView(BuildContext context, List<ListData>? list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ListData? bean = list?[index];
        return ListTile(
          title: Text("${bean?.beforePrice}"),
          subtitle: Text("${bean?.productName}"),
          trailing: IconButton(
              icon: Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
              onPressed: () {}),
        );
      },
      itemCount: list?.length,
    );
  }

  //获取数据的逻辑，利用dio库进行网络请求，拿到数据后利用json_serializable解析json数据
  //并将列表的数据包装在一个future中
  Future<List<ListData>?> getdata() async {
    // Response response = await _dio.get("http://192.168.5.199:8082/danyuan/getBaokuanzhijiang?page=1");
    Response response = await _dio.get("http://192.168.0.102:8082/danyuan/getBaokuanzhijiang?page=1");
    final responseData = json.decode(response.toString());
    ProductListModel productListModel = ProductListModel.fromJson(responseData);
    if(productListModel.states!=200){
      return null;
    }
    return productListModel.result.list;
  }
}
