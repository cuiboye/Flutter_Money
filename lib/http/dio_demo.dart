import 'dart:collection';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../model/product_list_model.dart';
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
  String? _imagePath = null;
  double _downloadCurrentProgress = 0;

  // get请求
  // http://192.168.5.199:8082/danyuan/getBaokuanzhijiang?page=1
  @override
  void initState() {
    super.initState();

    //测试Dio单例
    var params = Map<String, dynamic>();
    DioInstance.getInstance().get(
        "http://v.juhe.cn/joke/content/text.php?page=1&pagesize=20&key=03303e4d34effe095cf6a4257474cda9",
        params, success: (json) {//注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      print("获取到的数据：$json");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });

    _future = getdata();
  }

  @override
  Widget build(BuildContext context) {
    //这段代码是使用FutureBuilder
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Dio使用'),
    //     leading: GestureDetector(
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //       child: Icon(Icons.arrow_back),
    //     ),
    //   ),
    //   body: Container(
    //     alignment: Alignment.center,
    //     child: FutureBuilder<List<ListData>?>(
    //         future: _future,
    //         builder: (BuildContext context, AsyncSnapshot<List<ListData>?> snapshot) {
    //           //请求完成
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             //发生错误
    //             if (snapshot.hasError) {
    //               // return Text(snapshot.error.toString());
    //               return Column(
    //                 children: [
    //                   Expanded(
    //                     child: GestureDetector(
    //                       child: Center(
    //                         child: Text("出错了,请重试！"),
    //                       ),
    //                       onTap: () => refresh(),
    //                     ),
    //                   )
    //                 ],
    //               );
    //             }
    //             List<ListData>? list = snapshot.data;
    //
    //             //请求成功，通过项目信息构建用于显示项目名称的ListView
    //             return RefreshIndicator(
    //                 child: buildListView(context, list),
    //                 onRefresh: refresh);
    //           }
    //           //请求未完成时弹出loading
    //           return CircularProgressIndicator();
    //         }),
    //   ),
    // );

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

      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text("选择图片")),
          SizedBox(
            width: 50,
            height: 50,
            child: _imagePath == null
                ? Text("no image selected")
                : Image.file(
              File(_imagePath!),
              width: 50,
              height: 50,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _uploadImage(_imagePath);
              },
              child: Text("上传图片")),
          ElevatedButton(
              onPressed: () {
                _downloadFile();
              },
              child: Text("下载文件")),
          Row(
            children: [
              Text("当前下载进度：${_downloadCurrentProgress*100}%"),
              Expanded(child: LinearProgressIndicator(
                //指示器的背景颜色
                value:_downloadCurrentProgress,
                backgroundColor: Colors.grey[200],
                //指示器的颜色，需要使用 AlwaysStoppedAnimation
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),)
            ],
          )
        ],
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
    //get请求的参数
    Map<String,dynamic> map = {
      "page":1
    };
    Response response = await _dio
        .get("http://192.168.5.199:8082/danyuan/getBaokuanzhijiang",
    queryParameters: map);
    final responseData = json.decode(response.toString());
    ProductListModel productListModel = ProductListModel.fromJson(responseData);
    if (productListModel.states != 200) {
      return null;
    }
    return productListModel.result.list;
  }

  //使用相机或者从相册选择图片
  Future<void> getImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 1);
    setState(() {
      print("getImage");
      _imagePath = image?.path;
    });
    _uploadImage(_imagePath);
  }

  //上传图片，除了图片还可以上传其他文件，post提交
  //FormData 将提交的参数 name与value进行组合，实现表单数据的序列化，从而减少表单元素的拼接
  //也可以这样来描述:FormData 接口提供了一种表示表单数据的键值对的构造方式,通过FormData发出的请求编码类型被设
  //为 “multipart/form-data”，而在网络请求访问中，通过 Content-Type 来记录这个值，可以理解为Content-Type 表示具
  //体请求中的媒体类型信息。

  //而我们在实际开发中常用的 Content-Type如下
  // multipart/form-data
  // application/json     JSON数据格式
  // application/x-www-form-urlencoded 表单数据格式
  _uploadImage(String? imagePath) async {
    if (_imagePath != null) {
      var fileName = _imagePath?.substring(
          (_imagePath?.lastIndexOf("/"))! + 1, _imagePath?.length);

      //上传单张图片
      // var formData = FormData.fromMap({
      //   'name': 'wendux',
      //   'age': 25,
      //   'file': await MultipartFile.fromFile(File(_imagePath!).path,filename: fileName)
      // });

    // 多个文件上传
      var formData = FormData.fromMap({
        //file这个字段必须和后台设置的一致，否则会报错
        'file': [
          MultipartFile.fromFileSync(File(_imagePath!).path, filename: fileName),
          MultipartFile.fromFileSync(File(_imagePath!).path, filename: fileName),
        ],
        //如果有其他参数，可以在这里设置
        "userid":"348592"
      });
      //上传多张图片
      var response = await _dio.post("http://192.168.5.199:8082/danyuan/upload",
          data: formData,options: Options(contentType: "multipart/form-data"),
      onSendProgress: (int count, int total){
        print("图片下载进度：${(count/total)*100}%");

      });
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码

      if(response.statusCode == 200){
        print("上传成功");
        print(response);
      }
    }
  }

  _downloadFile() async{
    ///当前进度进度百分比  当前进度/总进度 从0-1
    double currentProgress =0.0;
    ///下载文件的网络路径
    String apkUrl ="http://image.59cdn.com/app/apk/official-wajiulegu_signed_3.70.5.apk";
    ///使用dio 下载文件
    /// 申请写文件权限
    var status = await Permission.storage.status;
    print("status的值为：$status");
    if(status == PermissionStatus.granted) {
      ///    手机储存目录
      ///    /data/user/0/com.example.flutter_money/app_flutter/dawang.apk
      /// final dir = await getApplicationDocumentsDirectory();
      ///    获取临时目录文件
      ///    /data/user/0/com.example.flutter_money/cache/dawang.apk
      /// final dir = await getTemporaryDirectory();
      ///    获取应用程序目录文件
      ///    /data/user/0/com.example.flutter_money/files/dawang.apk
       final dir = await getApplicationSupportDirectory();

      /// 外部存储目录：可以使用getExternalStorageDirectory()来获取外部存储目录，如SD卡；
      /// 由于iOS不支持外部目录，所以在iOS下调用该方法会抛出UnsupportedError异常，
      /// 而在Android下结果是android SDK中getExternalStorageDirectory的返回值。
      /// /storage/emulated/0/Android/data/com.example.flutter_money/files/dawang.apk
      // final dir = await getExternalStorageDirectory();
      var savePath = File('${dir.path}/dawang.apk');
      print("文件的路径为：$savePath");
      ///创建DIO
      Dio dio = Dio();

      ///参数一 文件的网络储存URL
      ///参数二 下载的本地目录文件
      ///参数三 下载监听
      Response response = await dio.download(
          apkUrl, "${savePath.path}", onReceiveProgress: (received, total) {
        if (total != -1) {
          ///当前下载的百分比例
          print((received / total * 100).toStringAsFixed(0) + "%");
          // CircularProgressIndicator(value: currentProgress,) 进度 0-1
          currentProgress = received / total;
          setState(() {
            _downloadCurrentProgress = (received/total).toDouble();
          });
        }
      });
    }else{
      ///提示用户请同意权限申请
      print("未获取权限");
      requestPermission();
    }
  }

  Future<bool> requestPermission() async {
    late PermissionStatus status;
    // 1、读取系统权限的弹框
    if (Platform.isIOS) {
      status = await Permission.photosAddOnly.request();
    } else {
      status = await Permission.storage.request();
    }
    // 2、假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
    // 这时候需要你自己写一个弹框，然后去打开app权限的页面
    if (status != PermissionStatus.granted) {
      print("11111111");
    } else {
      print("22222222");
      return true;
    }
    return false;
  }

  /// 写入数据
  Future<File> writeString(String name) async {
    final file = await _getLocalDocumentFile();
    return await file.writeAsString(name);
  }

  /// 获取文档目录文件
  Future<File> _getLocalDocumentFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/str.txt');
  }
}
