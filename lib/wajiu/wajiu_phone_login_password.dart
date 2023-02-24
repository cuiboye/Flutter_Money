import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/list_anim_demo_page.dart';
import 'package:flutter_money/wajiu/sliver_list_demo_page.dart';
import 'package:flutter_money/wajiu/widget/verification_code_input_demo_page.dart';

/**
 * 挖酒-手机验证码登录，输入密码框
 */
class WajiuPhoneLoginPassword extends StatefulWidget {
  @override
  _WajiuPhoneLoginPasswordState createState() => _WajiuPhoneLoginPasswordState();
}

class _WajiuPhoneLoginPasswordState extends State<WajiuPhoneLoginPassword> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "登录",
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "登录"),
        // body: VerificationCodeInputDemoPage(),
        body: SliverListDemoPage(),
      ),
    );
  }
}
