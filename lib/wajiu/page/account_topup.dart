import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_money/utils/text_utils.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 账户充值
 */
class AccountTopup extends StatefulWidget {
  @override
  _AccountTopupState createState() => _AccountTopupState();
}

class _AccountTopupState extends State<AccountTopup> {
  final payImageList = ["images/pay_zhifubao.png","images/pay_weixin.png"];
  final payNameList = ["支付宝","微信"];
  final payDescriptList = ["推荐有支付宝帐号的用户使用","推荐安装微信5.0及以上版本的用户使用"];

  bool selectedZFB = false;
  bool selectedWX = false;

  bool _inputMoneyEmpty = true;
  bool _bottomButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      title: "账户充值",
      home: Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "账户充值",
        ),
        body: Column(
          children: [
            _balance(),
            _inputMoney(),
            _divider(8.h,ColorUtil.color("#EDEDED")),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 13),
              color: Colors.white,
              child: Text("支付方式",style: TextStyle(fontSize: 15.sp)),
            ),
            _divider(1.h,ColorUtil.color("#EDEDED")),
            _addTypeItem(0,payImageList[0],payNameList[0],payDescriptList[0]),
            _divider(1.h,ColorUtil.color("#EDEDED")),
            _addTypeItem(1,payImageList[1],payNameList[1],payDescriptList[1]),
            _divider(1.h,ColorUtil.color("#EDEDED")),
            bottomButton()
          ],
        ),
      ),
    );
  }

  Widget bottomButton(){
    return Container(
      padding: EdgeInsets.only(bottom: 3),
      margin: EdgeInsets.only(left: 13,right: 13,top: 45),
      alignment:Alignment.center,
      height: 45.h,
      decoration: BoxDecoration(
        color: _bottomButtonEnable?ColorUtil.color("#f56e1d"):ColorUtil.color("#cdcdcd"),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text("充值",
        style: TextStyle(color: _bottomButtonEnable?ColorUtil.color("#ffffff"):ColorUtil.color("#aeaeae"),fontSize: 17.sp),),
    );
  }

  void selectPayType(int payType){
    switch (payType){
      case 0://支付宝
          setState(() {
            selectedZFB = true;
            selectedWX = false;
          });
        break;
      case 1://微信
        setState(() {
          selectedZFB = false;
          selectedWX = true;
        });
        break;
      default:
        break;
    }
    setEnableButton();
  }

  //支付方式
  Widget _addTypeItem(int payType,String imagePath,String payName,String payDescript){
    return GestureDetector(
      onTap: ()=>selectPayType(payType),
      child: Container(
        color: Colors.transparent,//这里处理 GestureDetector+Expanded点击无效果的问题
        padding: EdgeInsets.only(top: 6,bottom: 6,left: 13),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 15),
              child: Image.asset(imagePath,width: 30,height: 30),),
            Expanded(//设置权重
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payName,
                      style: TextStyle(
                          color: ColorUtil.color("#343434"), fontSize: 14.sp),
                    ),
                    Text(
                      payDescript,
                      style: TextStyle(
                          color: ColorUtil.color("#8b8b8b"), fontSize: 12.sp),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(right: 13),
              child:_selectWithPayType(payType)
            )
          ],
        ),
      ),
    );
  }

  Widget _selectWithPayType(int payType){
    if(payType == 0){
      return selectedZFB?
      Image.asset(
        "images/ic_radio_check.png",
        width: 20,
        height: 20,
      ):Image.asset(
        "images/shopping_cart_weixuanzhong.png",
        width: 20,
        height: 20,
      );
    }else{
      return selectedWX?
      Image.asset(
        "images/ic_radio_check.png",
        width: 20,
        height: 20,
      ):Image.asset(
        "images/shopping_cart_weixuanzhong.png",
        width: 20,
        height: 20,
      );
    }
  }

  Widget _divider(double? height,Color? color){
    return Container(
      height: height,
      color: color,
    );
  }
  
  //余额
  Widget _balance(){
    return Container(
      color: ColorUtil.color("#EFEFED"),
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child:  Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 13,right: 15),
            child:  Text("账户余额:",style: TextStyle(fontSize: 15.sp),),
          ),
          Text("¥927474.98")
        ],
      ),
    );
  }

  Widget _inputMoney(){
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10,left:13),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(right: 15),
            child: Text("充值金额",style: TextStyle(fontSize: 15.sp)),),
          Expanded(child: Container(
            child: TextField(
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: "请输入金额",
                hintStyle: TextStyle(fontSize: 14.sp),

                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (result)=>_judgeInputMoney(result),
              maxLines: null,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ))
        ],
      ),
      color: Colors.white,
    );
  }

  void setEnableButton(){
    if((selectedZFB || selectedWX) && !_inputMoneyEmpty){
      setState(() {
        _bottomButtonEnable = true;
      });
    }else{
      setState(() {
        _bottomButtonEnable = false;
      });
    }
  }

  void _judgeInputMoney(String inputMoney){
    if(TextUtils.isEmpty(inputMoney)){
      _inputMoneyEmpty = true;
    }else{
      _inputMoneyEmpty = false;
    }
    setEnableButton();
  }
}
