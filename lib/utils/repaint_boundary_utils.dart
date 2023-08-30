import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//全局key-截图key
final GlobalKey boundaryKey = GlobalKey();

/// 保存图片到相册，供分享使用
class RepaintBoundaryUtils {
  /// 截屏图片生成图片流ByteData，获取生成的图片
  Future<String> captureImage() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    var image = await boundary!.toImage(pixelRatio: 6.0);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    var filePath = "";

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // getApplicationDocumentsDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
            "${applicationDir.path}${DateTime.now().toIso8601String()}.jpg")
        .writeAsBytes(pngBytes);
    filePath = saveFile.path;
    debugPrint('filePath：$filePath');
    return filePath;
  }

//申请存本地相册权限
  Future<bool> getPormiation() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        debugPrint('getCorporation() ios');
        await [
          Permission.photos,
        ].request();
        // saveImage(globalKey);
      } else {
        debugPrint('getCorporation() ios2');
      }
      debugPrint('${status.isGranted}');
      return status.isGranted; //true的话说明已经申请权限
    } else {
      debugPrint('getCorporation() Android');
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

//保存到相册
  void savePhoto() async {
    EasyLoading.show(status: '图片下载中');
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    var image = await boundary!.toImage(pixelRatio: 6.0);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //获取保存相册权限，如果没有，则申请改权限
    bool permition = await getPormiation();

    if (permition) {
      if (Platform.isIOS) {
        var status = await Permission.photos.status;
        if (status.isGranted) {
          Uint8List images = byteData!.buffer.asUint8List();
          await ImageGallerySaver.saveImage(images, quality: 60, name: "customerinvitationcode");
          EasyLoading.showToast("保存成功，请前往相册查看");
        }
        if (status.isDenied) {
          debugPrint("IOS拒绝");
        }
      } else {
        var status = await Permission.storage.status;
        if (status.isGranted) {
          debugPrint("Android已授权");
          Uint8List images = byteData!.buffer.asUint8List();
          final result = await ImageGallerySaver.saveImage(images, quality: 60);
          if (result != null) {
            EasyLoading.showToast('保存成功，请前往相册查看');
          } else {
            EasyLoading.showToast('保存失败');
          }
        }
      }
    } else {
      //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
      savePhoto();
    }
  }
}
