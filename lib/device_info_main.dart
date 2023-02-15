
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * 获取设备信息
 */
class DeviceInfoMain extends StatefulWidget {
  @override
  _DeviceInfoMainState createState() => _DeviceInfoMainState();
}

class _DeviceInfoMainState extends State<DeviceInfoMain> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: ElevatedButton(
          onPressed: ()=>printDeviceInfo(),
          child: Text("获取设备信息"),
        ),
      ),
    );
  }
  
  void printDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');
  }
}
