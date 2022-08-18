import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io' show Platform;
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;
import 'package:permission_handler/permission_handler.dart';
import 'flutter_map_demo.dart';

/**
 * 百度地图
 */
class MapMainExample extends StatefulWidget {
  @override
  _MapMainExampleState createState() => _MapMainExampleState();
}

class _MapMainExampleState extends State<MapMainExample> {
  @override
  void initState() {
    super.initState();
    /// 动态申请定位权限
    requestPermission();

    LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();

    /// 设置用户是否同意SDK隐私协议
    /// since 3.1.0 开发者必须设置
    BMFMapSDK.setAgreePrivacy(true);
    myLocPlugin.setAgreePrivacy(true);

    // 百度地图sdk初始化鉴权
    if (Platform.isIOS) {
      myLocPlugin.authAK('wZqKbGEtWCYiTGO5YX3CG9PIwXmH3IbR');
      BMFMapSDK.setApiKeyAndCoordType(
          'wZqKbGEtWCYiTGO5YX3CG9PIwXmH3IbR', BMF_COORD_TYPE.BD09LL);
    } else if (Platform.isAndroid) {
      // Android 目前不支持接口设置Apikey,
      // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(
            context: context,
            title: '百度地图flutter插件Demo',
          ),
          body: FlutterBMFMapDemo()),
    );
  }
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
