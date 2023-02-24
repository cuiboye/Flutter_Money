import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/http.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/main.dart';
import 'package:flutter_money/wajiu/wajiu_phone_login.dart';
import 'package:flutter_money/wajiu/wajiu_register_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/custom_appbar.dart';
import 'package:http/http.dart' as http;

import 'model/login_model.dart';

/**
 * 挖酒-登录
 */
class WajiuLogin extends StatefulWidget {
  @override
  _WajiuLoginState createState() => _WajiuLoginState();
}

class _WajiuLoginState extends State<WajiuLogin> {
  String inputUserName = "";
  String inputPassword = "";
  String? backRegisterUserName = "";
  @override
  Widget build(BuildContext context) {
    //controller监听文本输入内容
    //text 这里给的是个默认值
    TextEditingController _inputUserNameController = TextEditingController(text: backRegisterUserName??"");
    _inputUserNameController.addListener(() {
      inputUserName = _inputUserNameController.text;//获取文本输入内容
    });

    TextEditingController _inputPasswordController = TextEditingController();
    _inputPasswordController.addListener(() {
      inputPassword = _inputPasswordController.text;//获取文本输入内容
    });

    return CustomMaterialApp(
        title: "登录",
        home: Scaffold(
          appBar: CustomAppbar(
            title: '登录',
            rightText: "注册",
            callback: ()=>_toRegister(),
            context: context,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(13.0,0,13.0,0),
            child: _loginWidget(_inputUserNameController,_inputPasswordController),
          ),
        ));
  }

  void _toRegister() {
    GetNavigationUtils.navigateRightToLeftWithParams(
            WajiuRegisterPage(), "第一个页面的参数")
        ?.then((value) => {
              setState(() {
                print("注册的用户为：$value");
              })
            });
  }

  Widget _loginWidget(TextEditingController inputUserNameController,TextEditingController _inputPasswordController){
    return ConstrainedBox(constraints: const BoxConstraints.expand(),
        child:  Column(
          children: [
            TextField(
              controller:inputUserNameController, //通过controller也可以获取文本输入内容
              decoration: InputDecoration(
                  labelText: '账号',
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: UnderlineInputBorder(//未获取焦点时，下滑线为灰色
                      borderSide: const BorderSide(
                          color: Colors.grey
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)//获取焦点时，下滑线为蓝色
                  )
              ),
            ),
            TextField(
              controller: _inputPasswordController,
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
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text("手机验证码登录",style: TextStyle(color: ColorUtil.color("ff0000"),fontWeight: FontWeight.bold)),
                    onTap: ()=>{
                      GetNavigationUtils.navigateRightToLeft(WajiuPhoneLogin())
                    },
                  ),
                  Text("忘记密码?",style: TextStyle(color: ColorUtil.color("ff0000"),fontWeight: FontWeight.bold)),
                ],
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
        child: Text("登录",
            style: TextStyle(color: ColorUtil.color("#ffffff"))),
      ),
      onTap: () => _toLogin(),
    );
  }

  Future<void> _toLogin() async {
    var params = Map<String, dynamic>();
    params["username"] = inputUserName;
    params["password"] = inputPassword;
    DioInstance.getInstance().get(
        ApiService.login,
        params, success: (json) {//注意：这里的json字段要和 typedef Success = void Function(dynamic json)中的字段一致
      print("获取到的数据：$json");
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("获取到的数据_toLogin：$json");
      LoginModel model =  LoginModel.fromJson(json);
      if(null!=model){
        int status = model.states;
        String msg = model.msg;
        if(status == 200){
          Fluttertoast.showToast(
              msg: "登录成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          // GetNavigationUtils.navigateRightToLeftWithAllOff(WajiuMainPage(),"WajiuMainPage");
          GetNavigationUtils.navigateRightToLeftWithOff(WajiuMainPage());
        }else if(status == 201){//用户不存在
          print("$status");
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
      print("获取到的数据：$model");
    }, fail: (reason, code) {
      print("获取到的数据：$reason");
    });
  }
}

