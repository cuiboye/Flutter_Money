import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading({String? status, EasyLoadingMaskType? maskType}) {
  if (isLoadingShow()) return;
  EasyLoading.show(
      status: status ?? '加载中...',
      maskType: maskType ?? EasyLoadingMaskType.black);
}

bool isLoadingShow() {
  return EasyLoading.isShow;
}

void dismissLoading() {
  if (isLoadingShow()) EasyLoading.dismiss();
}

void showError(String msg) {
  EasyLoading.showError(msg);
}

void showSuccess(String msg) {
  EasyLoading.showSuccess(msg);
}

void showToast(String msg, {Duration? duration, bool? dismissOnTap}) {
  EasyLoading.showToast(msg, duration: duration, dismissOnTap: dismissOnTap);
}
