import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/utils/repaint_boundary_utils.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:fluwx/fluwx.dart';

mixin class WechatShareMixin {
  bool hasRegister = false;
  final Fluwx fluwx = Fluwx();
  bool wechatInstall = true;

  ///注册微信api
  void registerWechatApi() async {
    if (hasRegister) {
      return;
    }
    await fluwx
        .registerApi(
            appId: Platform.isAndroid
                ? 'wxeae6404f23403b65'
                : 'wx22d5ab853c3e8aea',
            universalLink: "https://bqjcd.share2dlink.com/")
        .then((_) {
      hasRegister = true;
    });

    //微信登录回调
    fluwx.addSubscriber((response) {
      if (response is WeChatShareResponse) {
        EasyLoading.dismiss();
      }
    });
  }

  Future<bool> installWechat() async => await fluwx.isWeChatInstalled;

  ///分享网络图片
  void shareWechatNetImage(String imageUrl) async {
    if (!hasRegister) {
      ToastUtils.showToast('微信未注册成功！');
      return;
    }
    bool installedWechat = await installWechat();

    if (!installedWechat) {
      ToastUtils.showToast('未安装微信');
      return;
    }

    EasyLoading.show(status:'微信分享中');
    var model = WeChatShareImageModel(WeChatImage.network(imageUrl),
        scene: WeChatScene.session);
    fluwx.share(model);
  }

  ///分享下载到相册的图片
  void shareWechatAssestImage() async {
    if (!hasRegister) {
      ToastUtils.showToast('微信未注册成功！');
      return;
    }

    bool installedWechat = await installWechat();
    if (!installedWechat) {
      ToastUtils.showToast('未安装微信');

      return;
    }

    EasyLoading.show(status:'微信分享中');

    //获取从相册获取的图片
    String imageUrl = await RepaintBoundaryUtils().captureImage();
    var model = WeChatShareImageModel(WeChatImage.file(File(imageUrl)),
        scene: WeChatScene.session);
    fluwx.share(model);
  }
}
