import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/model/login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
class WajiuRegisterPage extends StatefulWidget {
  @override
  _WajiuRegisterPageState createState() => _WajiuRegisterPageState();
}

class _WajiuRegisterPageState extends State<WajiuRegisterPage> {
  String inputUserName = "";
  @override
  Widget build(BuildContext context) {
    //controller监听用户名输入内容
    TextEditingController _inputUserNameController = TextEditingController();
    _inputUserNameController.addListener(() {
      inputUserName = _inputUserNameController.text;//获取文本输入内容
    });

    return CustomMaterialApp(
        title: "注册",
        home: Scaffold(
          appBar: CustomAppbar(
            title: '注册',
            context: context,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(13.0,0,13.0,0),
            child: _loginWidget(_inputUserNameController),
          ),
        ));
  }

  Widget _loginWidget(TextEditingController inputUserNameController){
    return ConstrainedBox(constraints: const BoxConstraints.expand(),
        child:  Column(
          children: [
            TextField(
              controller:inputUserNameController, //通过controller也可以获取文本输入内容
              decoration: InputDecoration(
                  labelText: "账号",
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: UnderlineInputBorder(//未获取焦点时，下滑线为灰色
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)//获取焦点时，下滑线为蓝色
                  )
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: UnderlineInputBorder(//未获取焦点时，下滑线为灰色
                      borderSide: BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)//获取焦点时，下滑线为蓝色
                  )
              ),
            ),
            _loginButtonWidget()
          ],
        ));
  }

  Widget _loginButtonWidget(){
    return GestureDetector(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorUtil.color("#ff0000"),
        ),
        child: Text("注册",
            style: TextStyle(color: ColorUtil.color("#ffffff"))),
      ),
      onTap: () => {
        for(int i=0;i<1000;i++){
          _toRegister(i)
        }
      },
    );
  }

  Future<void> _toRegister(int i) async {
    var formData = FormData.fromMap({
      "username":"用户$i"
    });
    DioInstance.getInstance().post(
        "http://192.168.5.206:8083/danyuan/saveUser",
        formData: formData, success: (json) {//注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      print("获取到的数据：$json");
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("获取到的数据_toLogin：$json");
      LoginModel model =  LoginModel.fromJson(json);
      if(null!=model){
        int status = model.states;
        String? msg = model.msg;
        if(status == 200){
          //返回登录页面，并携带参数 GetNavigationUtils
          GetNavigationUtils.backWithParams("$inputUserName");
        }else if(status == 201){//用户已经存在
          print("$status");
        }
      }
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });
  }
}
