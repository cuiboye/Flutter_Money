import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import '../view/custom_appbar.dart';

/**
 * 挖酒-登录
 */
class WajiuLogin extends StatefulWidget {
  @override
  _WajiuLoginState createState() => _WajiuLoginState();
}

class _WajiuLoginState extends State<WajiuLogin> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        title: "登录",
        home: Scaffold(
          appBar: CustomAppbar(
            title: '登录',
            context: context,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(13.0,0,13.0,0),
            child: _loginWidget(),
          ),
        ));
  }
}


Widget _loginWidget(){
  return ConstrainedBox(constraints: const BoxConstraints.expand(),
    child:  Column(
      children: [
        TextField(
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
        Flexible(
          child: Align(
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("登录"),
              ),
              onPressed: () {
                _toLogin();
              },
            ),
          )
        )
      ],
    )
  );
}

void _toLogin(){
  print("toLogin");
}
