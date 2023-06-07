import 'package:flutter_money/wajiu/interface/orderlist_with_getconnect_interface.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:get/get.dart';

class OrderListWithConnectController extends SuperController<WajiuProductListNewModel> {
  OrderListWithConnectController({required this.repository});

  final IOrderListWithConnectRepository repository;

  @override
  void onInit() {
    super.onInit();

    //Loading, Success, Error handle with 1 line of code
    // append(() => repository.getOrderListData);//如果想一进页面获取数据，可以在onInit这个方法中进行操作
  }

  // 拉取新闻列表
  Future<void> getNewsPageList() async {
    append(() => repository.getOrderListData);
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  @override
  void onClose() {
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    print('onDetached called');
  }

  @override
  void onInactive() {
    print('onInative called');
  }

  @override
  void onPaused() {
    print('onPaused called');
  }

  @override
  void onResumed() {
    print('onResumed called');
  }
}
