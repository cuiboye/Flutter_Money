import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

class DialogUtils {
  static Future<T?> showListDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true, //点击空白Dialog是否消失
    required WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: SafeArea(child: builder(context)));
        });
  }

  //弹出 dialog
  static Future<T?> showYDCDialog<T>({
    required BuildContext context,
    bool barrierDismissible = false,

    required WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: SafeArea(child: builder(context)));
        });
  }


  /**
   * 弹框列表
   */
  static Future<void> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 300.0,
    height = 400.0,
  }) {
    return showListDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: width,
              height: height,
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child:Scaffold(
                body:  ListView.builder(
                    itemCount: commitMaps.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child:Text(commitMaps[index],style: TextStyle(color: ColorConstant.systemColor,fontSize: 20),),
                        onTap: () {
                          Navigator.pop(context);
                          onTap(index);
                        },
                      );
                    }),
              )
            ),
          );
        });
  }

  /**
   * 加载圈
   */
 static Future<void> showLoadingDialog(BuildContext context) {
   return showYDCDialog(
       context: context,
       builder: (BuildContext context) {
         return    Material(
             color: Colors.transparent,
             child: WillPopScope(
               onWillPop: () =>    Future.value(false),
               child: Center(
                 child:    Container(
                   width: 200.0,
                   height: 200.0,
                   padding:    EdgeInsets.all(4.0),
                   decoration:    BoxDecoration(
                     color: Colors.red,
                     //用一个BoxDecoration装饰器提供背景图片
                     borderRadius: BorderRadius.all(Radius.circular(4.0)),
                   ),
                   child:    Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          //不断循环的进度条
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                        Container(height: 10.0),
                        Container(
                            child: Text("正在处理中",
                                style: TextStyle(
                                    color: ColorConstant.color_ffffff,
                                    fontSize: 18))),
                      ],
                    ),
                  ),
               ),
             ));
       });
 }

  /**
   * 确定取消对话框
   */
  static Future<void> showAlertDialog(BuildContext context, String contentMsg,ValueChanged<String> onTap) {
    return showYDCDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                width: 260,
                height: 140,
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //用一个BoxDecoration装饰器提供背景图片
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Scaffold(
                    body: Column(
                  children: [
                    Container(
                      height: 85,
                      width: double.infinity,
                      child: Center(
                        child: Text("$contentMsg"),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: ColorConstant.color_eeeeee,
                    ),
                    Expanded(
                        child: Row(

                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: () => {Navigator.pop(context)},
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(right: BorderSide(
                                        width: 1,color: ColorConstant.color_eeeeee
                                    ))
                                ),
                                child: Center(
                                  child: Text("取消"),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: (){
                          Navigator.pop(context);
                                onTap("");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1,
                                        color: ColorConstant.color_eeeeee))),
                            child: Center(
                              child: Text("确定"),
                            ),
                          ),
                        )),
                      ],
                    ))
                  ],
                ))),
          );
        });

  }

  /**
   * 底部弹出框
   */
  static Widget shareWidget(BuildContext context,List<String> nameItems) {
    return   Container(
      height: 250.0,
      child:   Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child:   Container(
              height: 190.0,
              child:   GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return    InkWell(
                      onTap: () {
//                         Fluttertoast.showToast(
//                             msg: "正在建设中...",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIos:1
// //            backgroundColor: Color(0xe74c3c),
// //            textColor: Color(0xffffff)
//
//                         );
                      },
                      child:  Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                              child:   Image.asset("images/main_page_banner1.jpeg",
                                width: 30.0,
                                height: 30.0,)),
                          Text(nameItems[index])
                        ],
                      ));
                },
                itemCount: nameItems.length,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.blueGrey,
          ),
          Center(
            child:   Padding(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              child: GestureDetector(
                  onTap:(){
                    Navigator.of(context).pop();
                  },
                  child:   Text(
                    '取  消',
                    style:   TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  )),
            ),
          ),
        ],
      ),
    );
  }

}
