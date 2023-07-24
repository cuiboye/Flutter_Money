import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/view/custom_text_field_with_clear.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/custom_appbar.dart';

/**
 * 输入框及表单
 * 1）autofocus: 是否自动获取焦点
 * 2）obscureText：是否是密文输入
 * 3）获取文本输入内容
 * ---通过onChange()获取
 * ---通过controller获取
 * 两者区别：onChange是专门监听文字变化的，controller功能则更多一些
 * 4)焦点操作
 * 焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理，它代表焦点控制范围，可以在
 * 这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等。我们可以通过FocusScope.of(context) 来
 * 获取Widget树中默认的FocusScopeNode。
 *
 * FocusNode还可以监听焦点变化
 * 5)通过  border: InputBorder.none 可以隐藏下划线
 * 6）Form主要时验证信息是否正确，可以参考 https://book.flutterchina.club/chapter3/input_and_form.html#_3-5-2-%E8%A1%A8%E5%8D%95form
 */
class InputAddForm extends StatefulWidget {
  @override
  _InputAddFormState createState() => _InputAddFormState();
}

class _InputAddFormState extends State<InputAddForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController taskDetailController = TextEditingController();


    //controller监听文本输入内容
    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = "hello world!"; //设置默认值
    _textEditingController.selection = TextSelection(
        //从第三个字符开始选中后面的字符
        baseOffset: 2,
        extentOffset: _textEditingController.text.length);
    _textEditingController.addListener(() {
      print(_textEditingController.text); //获取文本输入内容
    });

    //监听焦点变化
    FocusNode focusNode1 = FocusNode();
    focusNode1.addListener(() {
      print("input1的焦点：${focusNode1.hasFocus}");
    });
    FocusNode focusNode2 = FocusNode();
    FocusScopeNode? focusScopeNode;

    TextEditingController _unameController = TextEditingController();
    TextEditingController _pwdController = TextEditingController();
    GlobalKey _formKey = GlobalKey<FormState>();
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(
            title: '输入框及表单',
            context: context,
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text("账号密码登录"),
                      TextField(
                        autofocus: true, //自动获取焦点
                        decoration: const InputDecoration(
                            labelText: "用户名",
                            hintText: "请输入用户名",
                            prefixIcon: Icon(Icons.person)),
                        controller:
                            _textEditingController, //通过controller也可以获取文本输入内容
                      ),
                      TextField(
                          decoration: const InputDecoration(
                              labelText: "密码",
                              hintText: "请输入密码",
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: true, //密文输入
                          onChanged: (result) => {
                                //onChange用户监听输入文本变化
                                print(result)
                              })
                    ],
                  ),
                  Column(
                    children: [
                      Text("焦点控制"),
                      TextField(
                        autofocus: true,
                        focusNode: focusNode1, //关联focusNode1
                        decoration: const InputDecoration(labelText: "input1"),
                      ),
                      TextField(
                        focusNode: focusNode2, //关联focusNode2
                        decoration: const InputDecoration(labelText: "input2"),
                      ),
                      ElevatedButton(
                        child: const Text("移动焦点"),
                        onPressed: () {
                          //将焦点从第一个TextField移到第二个TextField
                          // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                          // 这是第二种写法
                          focusScopeNode ??= FocusScope.of(context);
                          focusScopeNode?.requestFocus(focusNode2);
                        },
                      ),
                      ElevatedButton(
                        child: const Text("隐藏键盘"),
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Text("通过TextField自己的属性来自定义样式"),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "账号",
                            hintText: "请输入账号",
                            prefixIcon: Icon(Icons.person),
                            enabledBorder: UnderlineInputBorder(
                                //未获取焦点时，下滑线为灰色
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue) //获取焦点时，下滑线为蓝色
                                )),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("隐藏下划线"),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "账号",
                            hintText: "请输入账号",
                            icon: Icon(Icons.email),
                            border: InputBorder.none),
                      )
                    ],
                  ),
                  Form(
                    key: _formKey, //设置globalKey，用于后面获取FormState
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: true,
                          controller: _unameController,
                          decoration: InputDecoration(
                            labelText: "用户名",
                            hintText: "用户名或邮箱",
                            icon: Icon(Icons.person),
                          ),
                          // 校验用户名
                          validator: (v) {
                            return v!.trim().isNotEmpty ? null : "用户名不能为空";
                          },
                        ),
                        TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            labelText: "密码",
                            hintText: "您的登录密码",
                            icon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          //校验密码
                          validator: (v) {
                            return v!.trim().length > 5 ? null : "密码不能少于6位";
                          },
                        ),
                        // 登录按钮
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("登录"),
                                  ),
                                  onPressed: () {
                                    // 通过_formKey.currentState 获取FormState后，
                                    // 调用validate()方法校验用户名密码是否合法，校验
                                    // 通过后再提交数据。
                                    if ((_formKey.currentState as FormState)
                                        .validate()) {
                                      //验证通过提交数据
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text("TextField设置样式"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 13.w),
                    padding: EdgeInsets.only(left: 10.w),
                    decoration: const BoxDecoration(
                      color: ColorConstant.color_eeeeee,
                    ),
                    child: TextField(//这个输入框输入文字键盘消失后文字会消失，如果遇到这种情况需要把上面的代码都注释掉
                      maxLines: 6,
                      // enabled: ,//是否可以输入
                      controller: taskDetailController,
                      style: TextStyle(fontSize: 16.sp, color: ColorConstant.color_333333),
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请输入内容",
                        hintStyle: TextStyle(
                            fontSize: 16.sp, color: ColorConstant.color_d6d6d6),
                      ),
                    )
                  ),
                  const Text("自定义带有清空功能的TextField"),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 50,left: 13,right: 13),
                    padding: EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                        color: ColorConstant.color_f9f9fb,
                        borderRadius: BorderRadius.all(Radius.circular(5.w))),
                    child: const CustomTextFieldWithClear(
                      maxLines: 1,
                      hintText: 'ERP账号',
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
