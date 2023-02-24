import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/wajiu_phone_login_password.dart';

/**
 * 挖酒-手机验证码登录
 */
class WajiuPhoneLogin extends StatefulWidget {
  @override
  _WajiuPhoneLoginState createState() => _WajiuPhoneLoginState();
}

class _WajiuPhoneLoginState extends State<WajiuPhoneLogin> {
  bool phoneNumberEmpty = true;
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
            child:  _loginWidget(),
          ),
        ));
  }

  Widget _loginWidget(){
    return ConstrainedBox(constraints: const BoxConstraints.expand(),
        child:  Column(
          children: [
            TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String text){
                setState(() {
                  phoneNumberEmpty = TextUtils.isEmpty(text);
                });
              },
              decoration: InputDecoration(
                  labelText: '手机号',
                  hintText: "请输入手机号",
                  prefixIcon: Icon(Icons.phone),
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
          color: phoneNumberEmpty?ColorUtil.color("#cdcdcd"):ColorUtil.color("#ff0000"),
        ),
        child: Text("下一步",
            style: TextStyle(color: phoneNumberEmpty?ColorUtil.color("#aeaeae"):ColorUtil.color("#ffffff"),)),
      ),
      onTap: () => {
        if(!phoneNumberEmpty){
          GetNavigationUtils.navigateRightToLeft(WajiuPhoneLoginPassword())
        }
      },
    );
  }
}
