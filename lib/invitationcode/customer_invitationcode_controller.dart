import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money/mixin/mixin_share_qq.dart';
import 'package:flutter_money/mixin/mixin_wechat_share.dart';
import 'package:flutter_money/utils/repaint_boundary_utils.dart';
import 'package:get/get.dart';

class CustomerInvitationCodeController extends GetxController
    with WechatShareMixin, QQShareMixin {
  String inviteCode = '';
  String? coins;
  String? inviteUrl;

  @override
  void onInit() {
    super.onInit();

    registerWechatApi();
    registerQQApi();

    requestData();
  }

  void requestData() {
    // HttpUtil.getInstance().requestGet(Api.gMyInviteCode,
    //     success: (dynamic data) {
    //       CustomerInvitationCodeModel model =
    //       CustomerInvitationCodeModel.fromJson(data['result']);
    //       inviteCode = model.inviteCode??'';
    //       coins = model.coins;
    //       inviteUrl = model.inviteUrl;
    //       update();
    //     }, failed: (int code, String msg) {
    //       showToast(msg);
    //     });
    inviteCode = '889966';
    coins = '80';
  }

  void savePhoto() {
    debugPrint('下载图片');
    RepaintBoundaryUtils().savePhoto();
  }

  void shareWechatImage() {
    debugPrint('微信');
    shareWechatAssestImage();
  }

  void shareQQImage() {
    debugPrint('QQ');
    shareAssetImageWithQQ();
  }

  void clipboardData() {
    if(inviteCode.isEmpty)return;
    Clipboard.setData(ClipboardData(text: inviteCode)).then((value) =>  EasyLoading.showToast('复制成功'));
  }
}
