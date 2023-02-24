import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx/navigation/navigation_demo3.dart';

/**
 * getX navigation工具类
 * Get.to(NextScreen())：跳转到新页面(新页面带导航按钮可返回)
 * Get.off(NextScreen())：跳转到新页面(上一个页面页面出栈，关闭上一个页面，没有返回按钮)
 * Get.offAll(NextScreen())：跳转到新页面，并关闭之前的所有页面(没有返回按钮)
 * Get.back()：返回到上一个页面(对应于Get.to放到到路由页面跳转有效，off方法页面跳转无效)
 */
class GetNavigationUtils {
  //返回上一个页面并携带参数
  static void backWithParams(dynamic backParams){
    Get.back(result: "$backParams");
  }

  //通过名字跳转
  static void navigateWithName(String routerName) {
    Get.toNamed(routerName);
  }

  //通过非名字跳转；动画：进入时从右到左，退出是从左到右
  static void navigateRightToLeft(dynamic page) {
    Get.to(page, transition: Transition.rightToLeft);
  }

  //通过非名字跳转，传递参数;接收上一个页面返回的参数
  //下个页面返回的参数如下设置：
  //Get.back(result: "我是第二个页面返回的数据")
  static Future<dynamic>? navigateRightToLeftWithParams(dynamic page,dynamic arguments) {
    return Get.to(page, transition: Transition.rightToLeft,arguments: arguments);
  }

  //跳转到下一个页面，当前这个页面销毁
  static void navigateRightToLeftWithOff(dynamic page) {
    Get.off(page, transition: Transition.rightToLeft);
  }

  //跳转到下一个页面，销毁前面所有的页面
  static void navigateRightToLeftWithAllOff(dynamic page,String tag) {
    // Get.offUntil(
    //     GetPageRoute<dynamic>(
    //         settings: RouteSettings(
    //           name: 'navigation_page3',
    //           // arguments: arguments,
    //         ),
    //         page: () => NavigationPage3()),
    //     (route) => (route as GetPageRoute).routeName == 'navigation_page');


    //不能使用上面的那种方式，否则会报：
    //type 'MaterialPageRoute<dynamic>' is not a subtype of type 'GetPageRoute<dynamic>' in type cast
    Get.offUntil(
        MaterialPageRoute(
            builder: (context) => page,
            settings: RouteSettings(arguments: "hello")), (route) {
      var currentRoute = route.settings.name;
      debugPrint("Get.currentRoute --- $currentRoute");
      // if (currentRoute == "/WajiuMainPage") {//销毁WajiuMainPage之前所有的页面
      if (currentRoute == "/$tag") {
        return true;
      } else {
        return false;
      }
    });
  }

  //可以销毁多个页面，这是单纯的销毁，没有参数返回
  void destroryMorePageNoParams(int pageNumber) {
    Get.close(pageNumber);
  }

}