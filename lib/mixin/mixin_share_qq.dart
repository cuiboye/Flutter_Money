import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/utils/repaint_boundary_utils.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:tencent_kit/tencent_kit_platform_interface.dart';

mixin class QQShareMixin {
  bool hasRegister = false;

  ///分享api注册
  void registerQQApi() async {
    if (hasRegister) {
      return;
    }
    await TencentKitPlatform.instance.setIsPermissionGranted(granted: true);
    await TencentKitPlatform.instance
        .registerApp(appId: '1108762481')
        .then((value) {
      hasRegister = true;
    });
    TencentKitPlatform.instance.respStream().listen(_listenLogin);
  }

  void _listenLogin (TencentResp resp) {
    if (resp is TencentShareMsgResp) {
      final String content = 'share: ${resp.ret} - ${resp.msg}';
      if(resp.ret == 0){
        EasyLoading.showToast('分享成功');
      }else{
        EasyLoading.showToast('分享失败');
      }
      debugPrint('分享 $content');
    }
  }

  ///是否安装了QQ
  Future<bool> installQQ() async => await TencentKitPlatform.instance.isQQInstalled();

  ///分享网络图片
  void shareNetWorkImageWithQQ(String imagePath) async {
    bool installedQQ = await installQQ();
    if (!installedQQ) {
      ToastUtils.showToast('QQ未安装');
      return;
    }
    if (!hasRegister) {
      ToastUtils.showToast('QQ未注册成功！');
      return;
    }
    EasyLoading.show(status:'QQ分享中');
    final File file = await DefaultCacheManager().getSingleFile(imagePath);
    await TencentKitPlatform.instance.shareImage(
      scene: TencentScene.kScene_QQ,
      imageUri: Uri.parse(file.path),
    );
  }

  ///分享本地图片
  void shareAssetImageWithQQ() async {
    bool installedQQ = await installQQ();
    if (!installedQQ) {
      ToastUtils.showToast('QQ未安装');
      return;
    }
    if (!hasRegister) {
      ToastUtils.showToast('QQ未注册成功！');
      return;
    }
    EasyLoading.show(status:'QQ分享中');
    ///获取保存在相册的图片
    String? imageUrl = await RepaintBoundaryUtils().captureImage();
    await TencentKitPlatform.instance.shareImage(
      scene: TencentScene.kScene_QQ,
      imageUri: Uri.file(imageUrl),
    );
  }
}
